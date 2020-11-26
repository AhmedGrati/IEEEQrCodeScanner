import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_code_ieee/model/api_response.dart';
import 'package:qr_code_ieee/model/partner.dart';
import 'package:qr_code_ieee/model/secret.dart';
import 'package:qr_code_ieee/pages/scan_page.dart';
import 'package:qr_code_ieee/service/partner_service.dart';
import 'package:qr_code_ieee/widgets/social_rounded_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../consts.dart';
import '../size_config.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String secretCode;
  bool isObscure = true;
  SizeConfig sizeConfig = SizeConfig();
  PartnerService partnerService = PartnerService();
  FToast fToast;

  void manageUserRedirection() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String secretCode = sharedPreferences.getString('secretCode');
    print('secret home code : $secretCode');
    if (secretCode != null) {
      redirectToScanPage(secretCode);
    }
  }

  void changeSecretCode(String secretCode) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('secretCode', secretCode);
  }

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    manageUserRedirection();
  }

  void redirectToScanPage(String secretCode) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ScanPage(),
            settings: RouteSettings(arguments: secretCode)));
  }



  @override
  Widget build(BuildContext context) {
    sizeConfig.init(context);
    double defaultSize = SizeConfig.defaultSize;
    return Scaffold(
      backgroundColor: kGreyColorHex,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  height: defaultSize * 65,
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
                        bottomRight: Radius.circular(40.0),
                        bottomLeft: Radius.circular(40.0),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Image.asset(
                            "images/sb-logo-white.webp",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 16.0, right: 16.0),
                          child: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                secretCode = value.trim();
                              });
                            },
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isObscure = !isObscure;
                                  });
                                },
                                icon: Icon(
                                  isObscure
                                      ? FontAwesomeIcons.eye
                                      : FontAwesomeIcons.eyeSlash,
                                  color: Colors.black,
                                ),
                              ),
                              filled: true,
                              hintText: 'Enter your secret key...',
                              hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                  fontFamily: 'Roboto'),
                              fillColor: kGreyColorHex,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide(
                                    color: kGreyColorHex,
                                  )),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                  color: kGreyColorHex,
                                ),
                              ),
                            ),
                            obscureText: isObscure,
                            style: TextStyle(
                                color: Colors.black, fontFamily: 'Roboto'),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: defaultSize * 22.5,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: kSecondaryBlueColorHex,
                          ),
                          child: FlatButton(
                            onPressed: () async {
                              print("secret code : $secretCode");
                              ApiResponse<Partner> res = await partnerService
                                  .loginPartner(Secret(secretCode: secretCode));
                              if (!res.error) {
                                _showToast(Colors.greenAccent,
                                    "Logged in successfully", Icons.check);
                                changeSecretCode(secretCode);
                                redirectToScanPage(secretCode);
                              } else {
                                _showToast(Colors.redAccent, res.errorMessage,
                                    Icons.error);
                              }
                            },
                            child: Text(
                              'Let\'s Get Started',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SocialRoundedWidget(
                              iconData: FontAwesomeIcons.facebook,
                            ),
                            SocialRoundedWidget(
                              iconData: FontAwesomeIcons.instagram,
                            ),
                            SocialRoundedWidget(
                              iconData: FontAwesomeIcons.linkedin,
                            ),
                          ],
                        ),
                      ],
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

  _showToast(Color color, String message, IconData iconData) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: color,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            iconData,
            color: Colors.white,
          ),
          SizedBox(
            width: 12.0,
          ),
          Text(
            message,
            style: TextStyle(color: Colors.white, fontFamily: 'Serif'),
          ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP_LEFT,
      toastDuration: Duration(seconds: 2),
    );
  }
}
