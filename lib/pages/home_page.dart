import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import '../size_config.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  ScanResult scanResult;
  SizeConfig sizeConfig = SizeConfig();

  Future<void> showDialogFunction(String content) async {
    return showDialog(context: context ,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Scan QR code result!'),
          content: SingleChildScrollView(
            child: Row(
              children: [
                Text('Scan Result : '),
                Text('$content'),
              ],
            ),
          ),
          actions: [
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      }
    );
  }

  Future _qrCodeScan() async {
    try {
      var res = await BarcodeScanner.scan();
      setState(() {
        scanResult = res;
      });
      showDialogFunction(scanResult.rawContent);
    } on PlatformException catch (e) {
      var result = ScanResult(
        type: ResultType.Error,
        format: BarcodeFormat.unknown,
      );

      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          result.rawContent = 'The user did not grant the camera permission!';
        });
        showDialogFunction(result.rawContent);
      } else {
        result.rawContent = 'Unknown error: $e';
        showDialogFunction(result.rawContent);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    sizeConfig.init(context);
    double defaultSize = SizeConfig.defaultSize;
    print(defaultSize);
    return Scaffold(
      backgroundColor: Color(0xffd2d5cd),
      body: SafeArea(
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: defaultSize*25,
                  height: defaultSize *6,
                  decoration: BoxDecoration(
                      color: Color(0xff0066a1),
                    borderRadius: BorderRadius.circular(20.0)
                  ),
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
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}
