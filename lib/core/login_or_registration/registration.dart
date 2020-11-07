
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/UI/views/medium_screen/account/cabinet.dart';

Future registerUser(String mobile, BuildContext context, _auth, _codeController) async{

  String phone = '+'+mobile;
  print('Phone__'+phone);
  _auth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: Duration(seconds: 20),
      verificationCompleted: (AuthCredential credential) async{
        print('Complited verification');
        UserCredential result = await _auth.signInWithCredential(credential);

        User user = result.user;

        debugPrint("FIRST *weffw#");
        if(user != null){
//          Navigator.of(context).pushReplacementNamed('/cabinet');
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => AccountCabinet()),
                (Route<dynamic> route) => false,
          );
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
                      UserCredential result = await _auth.signInWithCredential(credential);
                      print('after result');
                      User user = result.user;

                      debugPrint("Second *weffw#");
                      if(user != null){
//                        Navigator.push(context, MaterialPageRoute(
//                            builder: (context) => AccountCabinet()
//                        ));
//                        Navigator.of(context).pushAndRemoveUntil('/cabinet');
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => AccountCabinet()),
                              (Route<dynamic> route) => false,
                        );
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