import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appdemo/providers/login_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InicioPage extends StatelessWidget {
  // Método para eliminar el token
  Future<void> removeToken(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token'); // Eliminar el token

    // Redirigir al LoginPage
    Navigator.pushReplacementNamed(context, 'login');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(title: Text("Home")),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(provider.fotoURL),
                ),
                SizedBox(height: 10),
                Text(
                  'Bienvenido, ${provider.nombreUsuario}',
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 20),
                Text('Correo: ${provider.correo}'),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => removeToken(
                      context), // Llamar al método para eliminar token
                  child: Text("Salir"),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.pushReplacementNamed(context, 'publicacion'), // Llamar al método para eliminar token
                  child: Text("Ver Publicaciones"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
