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
  ScanResult scanResult;
  SizeConfig sizeConfig = SizeConfig();

  UserService get userService => GetIt.I<UserService>();

  Future<void> showDialogFunction(ApiResponse<User> res) async {
    String message = res.data != null ? res.data : res.errorMessage;
    Color messageColor = res.data != null ? Colors.green : Colors.red;
    String imageName = res.data != null ? 'check' : 'error';
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CustomDialog(
            message: message,
            messageColor: messageColor,
            imageName: imageName,
          );
        });
  }

  Future _qrCodeScan() async {
    try {
      var res = await BarcodeScanner.scan();
      setState(() {
        scanResult = res;
      });
      if (scanResult.rawContent != "") {
        final ApiResponse<User> response =
            await userService.getUserById(scanResult.rawContent);
        showDialogFunction(response);
      }
    } on PlatformException catch (e) {
      var result = ScanResult(
        type: ResultType.Error,
        format: BarcodeFormat.unknown,
      );
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          result.rawContent = 'The user did not grant the camera permission!';
        });
      } else {
        result.rawContent = 'Unknown error: $e';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    sizeConfig.init(context);
    double defaultSize = SizeConfig.defaultSize;
    return Scaffold(
      backgroundColor: Color(0xffd2d5cd),
      body: SafeArea(
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: defaultSize * 25,
                  height: defaultSize * 6,
                  decoration: BoxDecoration(
                      color: Color(0xff0066a1),
                      borderRadius: BorderRadius.circular(20.0)),
                  child: FlatButton(
                    onPressed: () {
                      _qrCodeScan();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Scan Qr Code',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
