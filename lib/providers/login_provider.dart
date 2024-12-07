import 'package:flutter/material.dart';
import 'dart:convert'; // Para manejar JSON
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage = ''; // Error general
  List<String> _validationErrors = []; // Lista de errores de validación

  String _userId = ''; // ID del usuario
  String _nombreUsuario = '';
  String _correo = '';
  String _fotoURL = '';

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  List<String> get validationErrors => _validationErrors;
  String get userId => _userId;
  String get nombreUsuario => _nombreUsuario;
  String get correo => _correo;
  String get fotoURL => _fotoURL;
  String get baseApi => 'https://emot-backend.onrender.com/api/v1/auth';

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void _setValidationErrors(List<String> errors) {
    _validationErrors = errors;
    notifyListeners();
  }

  // Métodos para actualizar los datos del usuario
  void _setUserData(
      String userId, String nombreUsuario, String correo, String fotoURL) {
    _userId = userId;
    _nombreUsuario = nombreUsuario;
    _correo = correo;
    _fotoURL = fotoURL;
    notifyListeners();
  }

  // Método para almacenar el token de forma segura (utilizando SharedPreferences)
  Future<void> saveToken(String token) async {
    // Aquí guardas el token de manera segura en SharedPreferences
    // Dependiendo de la librería que uses, algo como:
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token'); // Eliminar el token
  }

  Future<void> login(BuildContext context, String correo, String clave) async {
    _setLoading(true);
    _setErrorMessage(''); // Limpiar el mensaje de error general
    _setValidationErrors([]); // Limpiar los errores de validación

    final url =
        Uri.parse('$baseApi/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'correo': correo, 'clave': clave}),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['respuesta'] == 'OK') {
          // Guardar datos del usuario
          _setUserData(
            responseData['datos']['userId'],
            responseData['datos']['nombreUsuario'],
            responseData['datos']['correo'],
            responseData['datos']['fotoURL'],
          );
          // Guardar el token en SharedPreferences
          String token = responseData['datos']['token'];

          saveToken(token);
          // Redirigir al Home
          Navigator.pushReplacementNamed(context, 'inicio');
          _setLoading(false);
        } else {
          // Si la respuesta es "OK" pero hay un problema en los datos
          _setErrorMessage('Error al procesar la respuesta del servidor');
          _setLoading(false);
        }
      } else if (response.statusCode == 400) {
        // Manejo de errores de validación (código 400)
        final responseData = json.decode(response.body);
        if (responseData['respuesta'] == 'ERRORES') {
          List<String> errors = [];
          for (var error in responseData['datos']['errores']) {
            errors.add(error['msg']);
          }
          _setValidationErrors(errors);
        } else if (responseData['respuesta'] == 'ERROR') {
          // Si la respuesta es "ERROR", indicar un error genérico
          _setErrorMessage(responseData['mensaje']);
        }
        _setLoading(false);
      } else {
        // Errores generales si el código de estado no es ni 200 ni 400
        _setErrorMessage('Hubo un error en la conexión o en la respuesta.');
        _setLoading(false);
      }
    } catch (error) {
      // Si ocurre un error de conexión
      _setErrorMessage('Error de conexión: $error');
      _setLoading(false);
    }
  }

  Future<void> verifyToken(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    print(token);
    if (token == null || token.isEmpty) {
      // Si no hay token, redirigir al login
      Navigator.pushReplacementNamed(context, 'login');
      return;
    }

    final url =
        Uri.parse('$baseApi/verificar');
    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json', 'Authorization': token},
    );
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      _setUserData(
        responseData['datos']['userId'],
        responseData['datos']['nombreUsuario'],
        responseData['datos']['correo'],
        responseData['datos']['fotoURL'],
      );
      // Si el token es válido, continúa con la navegación a la página principal
      Navigator.pushReplacementNamed(context, 'inicio');
    } else {
      // Si el token es inválido, redirigir al login
      await prefs.remove('token');
      Navigator.pushReplacementNamed(context, 'login');
    }
  }
}
