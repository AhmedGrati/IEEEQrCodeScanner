import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_ieee/pages/home_page.dart';
import 'package:qr_code_ieee/pages/scan_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch(settings.name) {
      case '/':
        return MaterialPageRoute(builder:(_) => HomePage());
      case '/home':
        return MaterialPageRoute(builder:(_) => HomePage());
      case '/scan':
        return MaterialPageRoute(builder:(_) => ScanPage());
      default:
        return MaterialPageRoute(builder:(_) => HomePage());
    }
  }
}