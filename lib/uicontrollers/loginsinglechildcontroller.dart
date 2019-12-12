import 'package:flutter/material.dart';
import 'package:flutter_firebase/utils/inpurtcontroller.dart';
import 'package:flutter_firebase/utils/Constants.dart';
import 'package:flutter_firebase/uicontrollers/buttoncontroller.dart';

class LoginSingleChildController {
  static Widget loginsinglechildcontrol(
      BuildContext context,
      TextEditingController _nameController,
      TextEditingController _emailController,
      TextEditingController _passwordController,
      Color primary,
      void function()) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 140,
            child: Stack(
              children: <Widget>[
                Positioned(
                  child: Align(
                    child: Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor),
                    ),
                    alignment: Alignment.center,
                  ),
                ),
                Positioned(
                  child: Container(
                    child: Text(
                      Constants.login,
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    alignment: Alignment.center,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20, top: 60),
            child: InputController.input(context, Icon(Icons.email),
                Constants.email, _emailController, false),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: InputController.input(context, Icon(Icons.lock),
                Constants.password, _passwordController, true),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              child: ButtonController.button(Constants.login, Colors.white,
                  primary, primary, Colors.white, function),
              height: 50,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
