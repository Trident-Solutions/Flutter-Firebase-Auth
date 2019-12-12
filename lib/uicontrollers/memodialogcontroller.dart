import 'package:flutter/material.dart';
import 'package:flutter_firebase/firebase/FirebaseOperations.dart';
import 'package:flutter_firebase/utils/Constants.dart';

import 'package:flutter_firebase/model/MemoModel.dart';
import 'package:flutter_firebase/uicontrollers/alert.dart';

class MemoDialogController {
  static displayDialog(
      BuildContext context,
      String title,
      TextEditingController _textTitleController,
      TextEditingController _textMemoController,
      int currentTabIndex,
      FirebaseOperations firebaseOperations) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                        decoration: InputDecoration(labelText: Constants.title),
                        controller: _textTitleController),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                        decoration: InputDecoration(labelText: Constants.notes),
                        controller: _textMemoController),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text(Constants.cancel),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text(Constants.save),
                onPressed: () {
                  if (_textTitleController.text.isEmpty) {
                    Alert.showAlert(Constants.title);
                  } else if (_textMemoController.text.isEmpty) {
                    Alert.showAlert(Constants.entermemo);
                  } else {
                    MemoModel memoModel = new MemoModel(
                        _textTitleController.text, _textMemoController.text);

                    if (currentTabIndex == 0) {
                      firebaseOperations.insertFirebaseMemo(memoModel);
                    } else {
                      firebaseOperations.insertFireStoreMemo(memoModel);
                    }
                    _textMemoController.clear();
                    _textTitleController.clear();
                    Navigator.of(context).pop();
                  }
                },
              )
            ],
          );
        });
  }
}
