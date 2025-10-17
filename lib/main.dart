import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_generator/screens/qr_generator_screen.dart';
import 'package:qr_code_generator/providers/qr_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider( 
      create: (context) => QrProvider(),
      child: MaterialApp(
        title: 'QR Code Generator',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: QRGeneratorScreen(),
      ),
    );
  }
}
