import 'package:flutter/material.dart';

get_promo_code_field(promo_code_field_controller, myFocusNode_promo_code) {
  return TextFormField(
    controller: promo_code_field_controller,
    focusNode: myFocusNode_promo_code,
    onTap: _requestFocus_promo_code(myFocusNode_promo_code),
    decoration: InputDecoration(
      labelText: 'promo code',
      labelStyle: TextStyle(
          color:
          myFocusNode_promo_code.hasFocus ? Colors.black : Colors.grey),
      icon: Icon(Icons.whatshot,
          color:
          myFocusNode_promo_code.hasFocus ? Colors.black : Colors.grey),
      hintText: 'promo code',
      helperText: '',
      border: const OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
    ),
  );
}




_requestFocus_promo_code(myFocusNode_promo_code) {
  myFocusNode_promo_code.addListener(() {
  });
}
