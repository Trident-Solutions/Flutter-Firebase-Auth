import 'package:flutter/material.dart';
import 'package:flutter_firebase/utils/Constants.dart';

class LogoImageController {
  static Widget logo(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 220,
        child: Stack(
          children: <Widget>[
            Positioned(
                child: Container(
              child: Align(
                child: new Text(
                  Constants.tridentapp,
                  style: TextStyle(
                      fontSize: 35.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold // insert your font size here
                      ),
                ),
              ),
              height: 154,
            )),
          ],
        ),
      ),
    );
  }
}
