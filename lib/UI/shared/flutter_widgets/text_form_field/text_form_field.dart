import 'package:flutter/material.dart';

Widget text_form_field(
  TextEditingController _field_controller,
  FocusNode _myFocusNode,
  _requestFocus,
  String _labelText,
  String _hintText,
  IconData _icon,
  String _validator_text,
) {
  return Container(
    margin: EdgeInsets.only(bottom: 20.0),
    child: TextFormField(
      controller: _field_controller,
      focusNode: _myFocusNode,
      onTap: () => _requestFocus,
      decoration: InputDecoration(
        labelText: _labelText,
        labelStyle: TextStyle(
            color: _myFocusNode.hasFocus ? Colors.black : Colors.grey),
        icon: Icon(_icon,
            color: _myFocusNode.hasFocus ? Colors.black : Colors.grey),
        hintText: _hintText,
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return _validator_text;
        }

        return null;
      },
    ),
  );
}
