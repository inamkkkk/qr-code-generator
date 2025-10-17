import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_code_generator/providers/qr_provider.dart';

class QRCodeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final qrProvider = Provider.of<QrProvider>(context);

    return RepaintBoundary(
      key: qrProvider.qrKey,
      child: QrImageView(
        data: qrProvider.qrData,
        version: QrVersions.auto,
        size: 200.0,
      ),
    );
  }
}
