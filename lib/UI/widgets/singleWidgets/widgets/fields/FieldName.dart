
import 'package:flutter/material.dart';

Widget get_name_field(name_field_controller, myFocusNode_name) {
  return Container(
    margin: EdgeInsets.only(bottom: 20.0),
    child: TextFormField(
      controller: name_field_controller,
      focusNode: myFocusNode_name,
      onTap: _requestFocus_name(myFocusNode_name),
      decoration: InputDecoration(
        labelText: 'name',
        labelStyle: TextStyle(
            color: myFocusNode_name.hasFocus ? Colors.black : Colors.grey),
        icon: Icon(Icons.account_circle_outlined,
            color: myFocusNode_name.hasFocus ? Colors.black : Colors.grey),
        hintText: 'John',
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    ),
  );
}





_requestFocus_name(myFocusNode_name) {
  myFocusNode_name.addListener(() {
  });
}
