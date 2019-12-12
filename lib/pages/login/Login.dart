import 'package:flutter/material.dart';
import 'package:flutter_firebase/firebase/FirebaseOperations.dart';
import 'package:flutter_firebase/model/User.dart';
import 'package:flutter_firebase/pages/home/Home.dart';
import 'package:flutter_firebase/utils/Constants.dart';
import 'package:flutter_firebase/uicontrollers/alert.dart';
import 'package:flutter_firebase/uicontrollers/buttoncontroller.dart';
import 'package:flutter_firebase/uicontrollers/clipper.dart';
import 'package:flutter_firebase/utils/emaivalidation.dart';
import 'package:flutter_firebase/uicontrollers/logincontroller.dart';
import 'package:flutter_firebase/uicontrollers/logoimagecontroller.dart';
import 'package:flutter_firebase/uicontrollers/registercontroller.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  String _email;
  String _password;
  String _displayName;
  FirebaseOperations firebaseOperations = new FirebaseOperations();

  @override
  Widget build(BuildContext context) {
    Color primary = Theme.of(context).primaryColor;

    void signInUser() async {
      String userId = "";
      _email = _emailController.text.trim();
      _password = _passwordController.text.trim();
      if (_email == null || _email.isEmpty) {
        Alert.showAlert(Constants.emailvalidation);
      } else if (!EmailValidation.isValidEmail(_email)) {
        Alert.showAlert(Constants.validemail);
      } else if (_password == null || _password.isEmpty) {
        Alert.showAlert(Constants.passwordEmptyValidation);
      } else if (_password.length < 6) {
        Alert.showAlert(Constants.passwordLengthValidation);
      } else {
        userId = await firebaseOperations.signIn(_email, _password);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home(userId)),
        );
        print(userId);
      }
    }

    void _registerUser() async {
      String userId = "";
      _displayName = _nameController.text;
      _email = _emailController.text.trim();
      _password = _passwordController.text.trim();
      if (_email == null || _email.isEmpty) {
        Alert.showAlert(Constants.emailvalidation);
      } else if (!EmailValidation.isValidEmail(_email)) {
        Alert.showAlert(Constants.validemail);
      } else if (_password == null || _password.isEmpty) {
        Alert.showAlert(Constants.passwordEmptyValidation);
      } else if (_password.length < 6) {
        Alert.showAlert(Constants.passwordLengthValidation);
      } else if (_displayName == null || _displayName.isEmpty) {
        Alert.showAlert(Constants.displayNameValidation);
      } else {
        var user = User(
          _displayName,
          _email,
        );

        userId = await firebaseOperations.signUp(user, _password);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home(userId)),
        );
        print(userId);
        _emailController.clear();
        _passwordController.clear();
        _nameController.clear();
        //    print(userId);

      }
    }

    void _loginSheet() {
      _scaffoldKey.currentState.showBottomSheet<void>((BuildContext context) {
        return LoginController.loginController(context, _emailController,
            _passwordController, _nameController, primary, signInUser);
      });
    }

    void _registerSheet() {
      _scaffoldKey.currentState.showBottomSheet<void>((BuildContext context) {
        return RegisterController.registerController(context, _emailController,
            _passwordController, _nameController, primary, _registerUser);
      });
    }

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          children: <Widget>[
            LogoImageController.logo(context),
            Padding(
              child: Container(
                child: ButtonController.button(Constants.login, primary,
                    Colors.white, Colors.white, primary, _loginSheet),
                height: 50,
              ),
              padding: EdgeInsets.only(top: 80, left: 20, right: 20),
            ),
            Padding(
              child: Container(
                child: OutlineButton(
                  highlightedBorderColor: Colors.white,
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                  highlightElevation: 0.0,
                  splashColor: Colors.white,
                  highlightColor: Theme.of(context).primaryColor,
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  child: Text(
                    Constants.register,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                  onPressed: () {
                    _registerSheet();
                  },
                ),
                height: 50,
              ),
              padding: EdgeInsets.only(top: 10, left: 20, right: 20),
            ),
            Expanded(
              child: Align(
                child: ClipPath(
                  child: Container(
                    color: Colors.white,
                    height: 300,
                  ),
                  clipper: BottomWaveClipper(),
                ),
                alignment: Alignment.bottomCenter,
              ),
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.stretch,
        ));
  }
}
