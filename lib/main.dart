import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_ieee/pages/home_page.dart';
import 'package:qr_code_ieee/route_generator.dart';
import 'package:qr_code_ieee/service_set_up.dart';
import 'package:device_preview/device_preview.dart';
void main() {
  ServiceSetUp serviceSetUp = ServiceSetUp();

  runApp(
     DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => IeeeScanQrCodeApp(),
    )
  );
}

class IeeeScanQrCodeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.of(context).locale,
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
