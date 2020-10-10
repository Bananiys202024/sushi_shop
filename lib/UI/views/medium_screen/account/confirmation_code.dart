import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/core/services/twilio/send_sms.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'cabinet.dart';

class ConfirmationCode extends StatefulWidget {

  int generated_code;
  String phone;
  ConfirmationCode({Key key, this.generated_code, this.phone}) : super(key: key);

  @override
  _ConfirmationCodeState createState() => _ConfirmationCodeState();
}

class _ConfirmationCodeState extends State<ConfirmationCode> {

  FirebaseAuth auth = FirebaseAuth.instance;
  final myController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.red, //change your color here
        ),
        backgroundColor: Colors.white,
        title: Text("Confirmation of phone",
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
            child:new Text("Please enter your confirmation code",
            style: TextStyle(fontSize: 20, color: Colors.black)),
          ),

          Padding(
          padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: Form(
          key: _formKey,
          child:
          TextFormField(
            decoration: InputDecoration(
              hintText: '8341',
              helperText: 'You did get sms with code of confirmation',
              filled: true,
              fillColor: Colors.white,
            ),
            keyboardType: TextInputType.phone,
            controller: myController,
            validator: (value) {

//              if(value.toString() != widget.generated_code.toString())
//                {
//                  return "Code does not match";
//                }

              if (value.isEmpty) {
                return 'Please enter code';
              }

              //...

              return null;
            },
          ),
          ),
          ),

//          resend_code(),
          submit_button(),

        ],
       ),
       ),
     );
  }
//
//
//  Widget resend_code() {
//    return Center(
//      child: RaisedButton(
//        color: Colors.grey,
//        onPressed: () {
//          // Validate returns true if the form is valid, or false
//          // otherwise.
//          if (_formKey.currentState.validate()) {
//            // If the form is valid, display a Snackbar.
////            scaffold
////                .showSnackBar(SnackBar(content: Text('Processing Data....')));
//         Navigator.push(
//                context, MaterialPageRoute(builder: (context) => ConfirmationCode()));
//          }
//        },
//        child: Text('Resend code'),
//      ),
//    );
//  }



  Future registerUser(String mobile, BuildContext context) async{

    String phone = '+'+mobile;
    print('Phone__'+phone);
    auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 20),
        verificationCompleted: (AuthCredential credential) async{
          print('Complited verification');
          UserCredential result = await auth.signInWithCredential(credential);

          User user = result.user;

          if(user != null){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => AccountCabinet()
            ));
          }else{
            print("Error");
          }

          //This callback would gets called when verification is done auto maticlly
        },
        verificationFailed: (Exception exception){
          print("Exception----"+exception.toString());
        },
        codeSent: (String verificationId, [int forceResendingToken]){
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text("Give the code?"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: _codeController,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Confirm"),
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: () async{
                        print('mobile---'+mobile);
                        final code = _codeController.text.trim();
                        AuthCredential credential = PhoneAuthProvider.getCredential(verificationId: verificationId, smsCode: code);
                        print("Mobile code---"+code);
                        UserCredential result = await auth.signInWithCredential(credential);
                        print('after result');
                        User user = result.user;

                        if(user != null){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => AccountCabinet()
                          ));
                        }else{
                          print("Error");
                        }
                      },
                    )
                  ],
                );
              }
          );
        },
        codeAutoRetrievalTimeout: (String message) {
          print('CodeAutoRetrievalTimeout---'+message);
        }
    );

  }


  Widget submit_button() {
    return Center(
      child: RaisedButton(
        color: Colors.grey,
        onPressed: () async {
          // Validate returns true if the form is valid, or false
          // otherwise.
          if (_formKey.currentState.validate()) {
            // If the form is valid, display a Snackbar.
//            scaffold
//                .showSnackBar(SnackBar(content: Text('Processing Data....')));


            await print("Before");
            await auth
                .idTokenChanges()
                .listen((User user) {
              if (user == null) {
                print('by token User is currently signed out!');
              } else {
                print('by token User is signed in!');
              }
            });

            await registerUser(widget.phone, context);
//
//            await FirebaseAuth.instance.signOut();

            //end auth..
            //insert authetication process here, make await that and add logged phone  to cashe

          }
        },
        child: Text('Send confirmation'),
      ),
    );
  }

}
