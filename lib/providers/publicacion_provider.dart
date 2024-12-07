import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PublicacionProvider with ChangeNotifier {
  bool _isLoading = true; // Estado de carga
  bool get isLoading => _isLoading;

  List<dynamic> _publicaciones = [];
  List<dynamic> get publicaciones => _publicaciones;

  // Método para obtener las publicaciones
  Future<void> obtenerPublicaciones() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token'); // Obtener el token guardado

    if (token == null || token.isEmpty) {
      print('Token no encontrado.');
      _isLoading = false;
      notifyListeners();
      return;
    }

    final url =
        Uri.parse('https://emot-backend.onrender.com/api/v1/publicaciones');
    print('Realizando solicitud a la API: $url');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': token, // Mandamos el token en el header
        },
      );

      print('Respuesta del servidor: ${response.statusCode}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['estado'] == 'OK') {
          _publicaciones = responseData['datos'];
        }
      } else {
        print('Error al obtener publicaciones: ${response.statusCode}');
        _publicaciones = [];
      }
    } catch (e) {
      print('Error en la solicitud HTTP: $e');
      _publicaciones = [];
    }

    // Cambiamos el estado de carga a falso y notificamos a los listeners
    _isLoading = false;
    notifyListeners();
  }
}
