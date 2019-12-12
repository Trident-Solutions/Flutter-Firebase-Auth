import 'package:flutter/material.dart';

import 'package:flutter_firebase/uicontrollers/loginsinglechildcontroller.dart';

class LoginController {
  static Widget loginController(
      BuildContext context,
      TextEditingController _emailController,
      TextEditingController _passwordController,
      TextEditingController _nameController,
      Color primary,
      void function()) {
    return DecoratedBox(
      decoration: BoxDecoration(color: Theme.of(context).canvasColor),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
        child: Container(
          child: ListView(
            children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 10,
                      top: 10,
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _emailController.clear();
                          _passwordController.clear();
                        },
                        icon: Icon(
                          Icons.close,
                          size: 30.0,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    )
                  ],
                ),
                height: 50,
                width: 50,
              ),
              LoginSingleChildController.loginsinglechildcontrol(
                  context,
                  _nameController,
                  _emailController,
                  _passwordController,
                  primary,
                  function),
            ],
          ),
          height: MediaQuery.of(context).size.height / 1.1,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
        ),
      ),
    );
  }
}
