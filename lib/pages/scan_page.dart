import 'package:flutter/material.dart';
import 'package:qr_code_ieee/consts.dart';
import 'package:qr_code_ieee/model/scan_body.dart';
import 'package:qr_code_ieee/service/partner_service.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:qr_code_ieee/model/api_response.dart';
import 'package:qr_code_ieee/model/QrScanResponse.dart';
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
  String secretCode;

  PartnerService get partnerService => GetIt.I<PartnerService>();

  Future<void> showDialogFunction(ApiResponse<QrScanResponse> res) async {
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
        isLoading
            ? showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return Dialog(
                    backgroundColor: kPrimaryBlueColorHex,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Container(
                      height: SizeConfig.defaultSize * 12,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Processing ...',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Image.asset(
                              "images/loading.webp",
                              width: SizeConfig.defaultSize * 3,
                              height: SizeConfig.defaultSize * 3,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                })
            : Text('');
        final ScanBody scanBody = ScanBody(
          secretCode: secretCode,
            memberIeeeId: scanResult.rawContent
        );
        final ApiResponse<QrScanResponse> response =
            await partnerService.scanQRCode(scanBody);
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
    secretCode = ModalRoute.of(context).settings.arguments;
    print(secretCode);
    return Scaffold(
      backgroundColor: kGreyColorHex,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Hero(
                        tag:'logo',
                        child: Container(
                          width: SizeConfig.defaultSize *  25,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Image.asset("images/sb-logo.webp"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: kSecondaryBlueColorHex,
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
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            kPrimaryBlueColorHex,
                            kSecondaryBlueColorHex,
                            kTertiaryBlueColorHex
                          ]),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Scan QR Code',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                color: Colors.white,
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
                                color: kGreyColorHex,
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
                          size: SizeConfig.defaultSize * 30,
                        ),

                      ],
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
