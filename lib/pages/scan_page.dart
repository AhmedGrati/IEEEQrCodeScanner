import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:qr_code_ieee/model/api_response.dart';
import 'package:qr_code_ieee/model/user.dart';
import 'package:qr_code_ieee/service/user_service.dart';
import 'package:qr_code_ieee/widgets/custom_dialog.dart';

import '../size_config.dart';

class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  ScanResult scanResult;
  bool isLoading = false;
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
      var options = ScanOptions(useCamera: 0);
      var res = await BarcodeScanner.scan(options: options);
      setState(() {
        scanResult = res;
      });
      if (scanResult.rawContent != "") {
        setState(() {
          isLoading = true;
        });
        isLoading ? showDialog(context: context ,
            barrierDismissible: false,
            builder: (context) {
              return Dialog(
                backgroundColor: Color(0xff1D2333),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  height: SizeConfig.defaultSize*12,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Processing ...' ,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Image.asset("images/loading.webp" ,
                          width: SizeConfig.defaultSize * 3,
                          height: SizeConfig.defaultSize * 3,
                        )
                      ],
                    ),
                  ),
                ),
              );
            }) : Text('');
        final ApiResponse<User> response =
            await userService.getUserById(scanResult.rawContent);
        Navigator.pop(context);
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
    return Scaffold(
      backgroundColor: Color(0xff91bdd6),
      body: Container(
        margin: EdgeInsets.only(top: 100.0),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30.0), topLeft: Radius.circular(30.0)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Scan QR Code.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Place QR code inside the frame to scan and please avoid shake to get results quickly.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Colors.blueGrey,
                    fontSize: 15.0),
              ),
            ),
            QrImage(
              data: scanResult == null
                  ? "123456"
                  : (scanResult.rawContent == ''
                      ? '123456'
                      : scanResult.rawContent),
              version: QrVersions.auto,
              size: 250.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Color(0xffeb5e55),
                    borderRadius: BorderRadius.circular(10.0)),
                child: FlatButton(
                  onPressed: () {
                    _qrCodeScan();
                  },
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            'Place Camera Code',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                        ],
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
