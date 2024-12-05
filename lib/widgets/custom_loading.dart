import 'package:flutter/material.dart';

class CustomLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.75),
      child: Center(
        child: CircularProgressIndicator(
          color: Colors.white.withOpacity(0.75),
        ),
      ),
    );
  }
}
