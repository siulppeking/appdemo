import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';

class CustomButtonScanQR extends StatelessWidget {
  const CustomButtonScanQR({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.filter_center_focus),
      onPressed: () async {
        var result = await BarcodeScanner.scan(
          options: const ScanOptions(
            strings: {
              'cancel': 'Cancelar',
              'flash_on': 'Flash on',
              'flash_off': 'Flash off',
            },
          ),
        );
        final value = result.rawContent;
        if (value.isNotEmpty) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Resultado: '),
              content: Text(result.rawContent),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Ok'),
                )
              ],
            ),
          );
        }

        /*
        print(result.type); // The result type (barcode, cancelled, failed)
        print(result.rawContent); // The barcode content
        print(result.format); // The barcode format (as enum)
        print(result
            .formatNote); // If a unknown format was scanned this field contains a note
        */
      },
    );
  }
}
