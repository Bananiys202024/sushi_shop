
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/login_or_registration/registration.dart';

Widget submit_button(_auth, _formKey, _myController, context, _codeController, _is_error_validation_for_input_phone_number_field) {
  return Center(
    child: RaisedButton(
      color: Colors.grey,
      onPressed: () async {
        // Validate returns true if the form is valid, or false
        // otherwise.
        if (_formKey.currentState.validate()) {



          await print("Before");
          await _auth
              .idTokenChanges()
              .listen((User user) {
            if (user == null) {
              print('by token User is currently signed out!');
            } else {
              print('by token User is signed in!');
            }
          });

          debugPrint("CurrentUser---"+_auth.currentUser.toString());


          String phone = await _myController.text.toString();
          await registerUser(phone, context, _auth, _codeController, _is_error_validation_for_input_phone_number_field);

//          Navigator.push (
//              context, MaterialPageRoute(builder: (context) => ConfirmationCode()));
        }
      },
      child: Text('Send confirmation'),
    ),
  );
}
