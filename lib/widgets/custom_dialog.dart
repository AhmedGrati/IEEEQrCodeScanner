import 'package:flutter/material.dart';
import 'package:qr_code_ieee/consts.dart';
class CustomDialog extends StatelessWidget {
  final Color messageColor;
  final String message;
  final String imageName;
  CustomDialog({this.message,this.messageColor,this.imageName});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      elevation: 1.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        width: 200,
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            Padding(

              padding: const EdgeInsets.all(16.0),
              child: Image.asset("images/$imageName.webp"),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Scanning Result: ',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Serif'
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                message,
                style: TextStyle(
                    color: messageColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: 175,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: kPrimaryBlueColorHex
              ),
              child: FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('Done' ,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Serif'
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
