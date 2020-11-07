import 'package:flutter/material.dart';
import 'package:flutter_app/core/models/Constants.dart';

Widget get_body_comment(comment_field_controller, myFocusNode_comment) {
  return Container(
    margin: EdgeInsets.only(bottom: 20.0),
    child: TextFormField(
      controller: comment_field_controller,
      keyboardType: TextInputType.multiline,
      maxLines: 10,
      maxLength: 100,
      focusNode: myFocusNode_comment,
      onTap: _requestFocus_comment(myFocusNode_comment),
      decoration: InputDecoration(
        labelStyle: TextStyle(
            color: myFocusNode_comment.hasFocus ? Colors.black : Colors.grey),
        hintText: Constants.get_comment_text(),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    ),
  );
}



_requestFocus_comment(myFocusNode_comment) {
  myFocusNode_comment.addListener(() {
  });

}
