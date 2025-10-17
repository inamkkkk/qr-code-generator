import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_generator/widgets/qr_code_widget.dart';
import 'package:qr_code_generator/providers/qr_provider.dart';

class QRGeneratorScreen extends StatelessWidget {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final qrProvider = Provider.of<QrProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Generator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Enter Text',
                border: OutlineInputBorder(),
              ),
              onChanged: (text) {
                qrProvider.updateQrData(text);
              },
            ),
            SizedBox(height: 20),
            QRCodeWidget(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await qrProvider.saveQrImage(context);
              },
              child: Text('Save to Gallery'),
            ),
          ],
        ),
      ),
    );
  }
}
