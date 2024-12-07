import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appdemo/providers/publicacion_provider.dart';

class PublicacionesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final publicacionProvider =
        Provider.of<PublicacionProvider>(context, listen: false);
    publicacionProvider.obtenerPublicaciones();

    return Scaffold(
      appBar: AppBar(
        title: Text('Publicaciones'),
      ),
      body: Consumer<PublicacionProvider>(
        builder: (context, publicacionProvider, child) {
          if (publicacionProvider.isLoading) {
            // Mostrar un indicador de progreso mientras se cargan las publicaciones
            return Center(child: CircularProgressIndicator());
          }

          // Si las publicaciones están cargadas, mostrar la lista
          return ListView.builder(
            itemCount: publicacionProvider.publicaciones.length,
            itemBuilder: (context, index) {
              var publicacion = publicacionProvider.publicaciones[index];
              return Card(
                margin: EdgeInsets.all(8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(publicacion['usuario']['fotoURL']),
                  ),
                  title: Text(publicacion['titulo']),
                  subtitle: Text(publicacion['descripcion']),
                  trailing: Text(publicacion['fecCreFormato3']),
                  onTap: () {
                    // Lógica para abrir los detalles de la publicación si es necesario
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
