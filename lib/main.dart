import 'package:flutter/material.dart';
import 'package:qr_code_ieee/pages/home_page.dart';
import 'package:qr_code_ieee/service_set_up.dart';

void main() {
  ServiceSetUp serviceSetUp = ServiceSetUp();
  runApp(IeeeScanQrCodeApp());
}

class IeeeScanQrCodeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
