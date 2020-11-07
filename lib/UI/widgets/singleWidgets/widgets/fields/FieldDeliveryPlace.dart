import 'package:flutter/material.dart';

get_place_of_delivery_field(geo_location_field_controller,  myFocusNode_place_of_delivery) {
  return Container(
    margin: EdgeInsets.only(bottom: 20.0),
    child: TextFormField(
      controller: geo_location_field_controller,
      focusNode: myFocusNode_place_of_delivery,
      onTap: _requestFocus_place_of_delivery(myFocusNode_place_of_delivery),
      decoration: InputDecoration(
        labelText: 'address',
        labelStyle: TextStyle(
            color: myFocusNode_place_of_delivery.hasFocus
                ? Colors.black
                : Colors.grey),
        icon: Icon(Icons.location_on,
            color: myFocusNode_place_of_delivery.hasFocus
                ? Colors.black
                : Colors.grey),
        hintText: '1 North Street Pembroke HM 09 Bermuda.',
        helperText: '*required field',
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter place of delivery';
        }
        return null;
      },
    ),
  );
}



 _requestFocus_place_of_delivery(myFocusNode_place_of_delivery) {
  myFocusNode_place_of_delivery.addListener(() {
  });
}