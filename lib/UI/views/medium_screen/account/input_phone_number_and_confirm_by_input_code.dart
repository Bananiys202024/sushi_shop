import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/UI/views/medium_screen/account/cabinet.dart';

import 'dart:io' show Platform;
import 'dart:math';

import 'package:flutter_app/UI/widgets/singleWidgets/widgets/fragments/submit/input_phone_number_and_confirm_by_input_code.dart';


class InputPhoneNumber extends StatefulWidget {
  InputPhoneNumber({Key key}) : super(key: key);


  @override
  _InputPhoneNumberState createState() => _InputPhoneNumberState();
}

class _InputPhoneNumberState extends State<InputPhoneNumber> {

  final _codeController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  final _myController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.red, //change your color here
        ),
        backgroundColor: Colors.white,
        title: Text("Input phone number",
        style: TextStyle(color: Colors.black)),
      ),
      body: get_body(),
    );
  }

  Widget get_body() {
     return
     ColoredBox(
       color: Colors.black12,
       child: Padding(
         padding: EdgeInsets.only(top: 20.0, bottom:10.0),
       child: Column(
        children: [

          Center(
            child:new Text("Please enter your phone number",
            style: TextStyle(fontSize: 20, color: Colors.black)),
          ),

          Padding(
          padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: Form(
          key: _formKey,
          child:
          TextFormField(
            decoration: InputDecoration(
              hintText: '380743328441',
              helperText: 'You will get sms with code of confirmation. You should input phone number in international format;',
              filled: true,
              prefixText: '+',
              fillColor: Colors.white,
            ),

            keyboardType: TextInputType.phone,
            controller: _myController,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter mobile number';
              }

              //check mobile phone
              String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
              RegExp regExp = new RegExp(pattern);
              if (!regExp.hasMatch(value)) {
                return 'Please enter valid mobile number';
              }
              //...

              return null;
            },
          ),
          ),
          ),

          submit_button(_auth, _formKey, _myController, context, _codeController),

        ],
       ),
       ),
     );
  }








}
