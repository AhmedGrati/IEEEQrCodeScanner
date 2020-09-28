import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:qr_code_ieee/model/api_response.dart';
import 'package:qr_code_ieee/model/user.dart';
import 'package:qr_code_ieee/service/user_service.dart';
import 'package:qr_code_ieee/widgets/custom_dialog.dart';
import '../consts.dart';
import '../size_config.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SizeConfig sizeConfig = SizeConfig();
  @override
  Widget build(BuildContext context) {
    sizeConfig.init(context);
    double defaultSize = SizeConfig.defaultSize;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                    height: 200,
                    width: 200,
                    child: Image.asset("images/sb-logo.png")
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('Welcome to IEEE INSAT student branch.' ,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Roboto',
                      fontSize: 30.0
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Please give access your camera so we can scan and provide you what is inside the code.' ,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontFamily: 'Roboto',
                      fontSize: 20.0
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xffeb5e55),
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/scan');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Let \'s Get Started' ,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
