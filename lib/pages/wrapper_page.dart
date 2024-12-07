import 'package:appdemo/providers/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WrapperPage extends StatelessWidget {
  const WrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Llamar al método de verificación del token desde el LoginProvider
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    loginProvider.verifyToken(context);
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ), // Esperamos mientras validamos
    );
  }
}
