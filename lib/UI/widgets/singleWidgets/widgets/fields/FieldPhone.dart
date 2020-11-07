import 'package:flutter/material.dart';

get_phone_field(phone_field_controller,  myFocusNode_phone) {
  return Container(
    margin: EdgeInsets.only(bottom: 20.0),
    child: TextFormField(
      controller: phone_field_controller,
      keyboardType: TextInputType.phone,
      focusNode: myFocusNode_phone,
      onTap: _requestFocus_phone(myFocusNode_phone),
      decoration: InputDecoration(
        labelText: 'phone number',
        labelStyle: TextStyle(
            color: myFocusNode_phone.hasFocus ? Colors.black : Colors.grey),
        icon: Icon(Icons.phone,
            color: myFocusNode_phone.hasFocus ? Colors.black : Colors.grey),
        hintText: '+380743328441',
        helperText: '*required field',
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
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
  );
}



_requestFocus_phone(myFocusNode_phone) {

  myFocusNode_phone.addListener(() {
  });

}

