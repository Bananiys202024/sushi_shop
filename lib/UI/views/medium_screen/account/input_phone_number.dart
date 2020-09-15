import 'package:flutter/material.dart';

import 'cabinet.dart';

class InputPhoneNumber extends StatefulWidget {
  InputPhoneNumber({Key key}) : super(key: key);

  @override
  _InputPhoneNumberState createState() => _InputPhoneNumberState();
}

class _InputPhoneNumberState extends State<InputPhoneNumber> {

  final myController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
              hintText: '+380743328441',
              helperText: 'You will get sms with code of confirmation',
              filled: true,
              fillColor: Colors.white,
            ),
            keyboardType: TextInputType.phone,
            controller: myController,
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

          submit_button(),

        ],
       ),
       ),
     );
  }

  Widget submit_button() {
    return Center(
      child: RaisedButton(
        color: Colors.grey,
        onPressed: () {
          // Validate returns true if the form is valid, or false
          // otherwise.
          if (_formKey.currentState.validate()) {
            // If the form is valid, display a Snackbar.
//            scaffold
//                .showSnackBar(SnackBar(content: Text('Processing Data....')));

            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AccountCabinet()));
          }
        },
        child: Text('Send confirmation'),
      ),
    );
  }

}
