import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class QrProvider extends ChangeNotifier {
  String _qrData = 'Enter some data';
  GlobalKey qrKey = GlobalKey();

  String get qrData => _qrData;

  void updateQrData(String newData) {
    _qrData = newData;
    notifyListeners();
  }

  Future<void> saveQrImage(BuildContext context) async {
    try {
      RenderRepaintBoundary boundary = qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final status = await Permission.storage.request();
      if (status.isGranted) {
        final directory = await getExternalStorageDirectory();
        final imagePath = await File('${directory!.path}/qr_code.png').create();
        await imagePath.writeAsBytes(pngBytes);

        final result = await ImageGallerySaver.saveFile(imagePath.path, isReturnPathOfIOS: true);

        if (result != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('QR Code saved to gallery!'),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error saving QR Code.'),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Storage permission denied.'),
          ),
        );
      }
    } catch (e) {
      print('Error saving QR code: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving QR Code: $e'),
        ),
      );
    }
  }
}
