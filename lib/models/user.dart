import 'dart:convert'; // Para convertir JSON a Map
import 'dart:io';
import 'package:http/http.dart' as http;

// Clase para modelar un usuario
class User {
  final int id;
  final String name;
  final String username;
  final String email;

  User(
      {required this.id,
      required this.name,
      required this.username,
      required this.email});

  // Crear un User desde JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
    );
  }
}

// Función para obtener usuarios con validaciones
Future<List<User>> fetchUsers() async {
  const String url = 'https://jsonplaceholder.typicode.com/users';

  try {
    // Comprobando conectividad
    final result = await InternetAddress.lookup('jsonplaceholder.typicode.com');
    if (result.isEmpty || result[0].rawAddress.isEmpty) {
      throw Exception('No tienes conexión a Internet');
    }

    // Realizar la solicitud GET
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Error en la solicitud: ${response.statusCode}');
    }
  } on SocketException {
    throw Exception(
        'No se pudo conectar al servidor. Verifica tu conexión a Internet.');
  } on Exception catch (e) {
    throw Exception('Ocurrió un error: $e');
  }
}
