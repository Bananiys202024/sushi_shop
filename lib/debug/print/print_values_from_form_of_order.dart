import 'package:flutter/material.dart';

void print_values_from_form_of_order(
    phone_field_controller,
    name_field_controller,
    comment_field_controller,
    promo_code_field_controller,
    geo_location_field_controller,
    time_of_delivery,
    _payment,
    call_me_back,
    dropdownValue_day,
    dropdownValue_time,
    )
{


  debugPrint("Value of phone field---" + phone_field_controller.text);
  debugPrint("Value of name field---" + name_field_controller.text);
  debugPrint(
      "Value of comment field---" + comment_field_controller.text);
  debugPrint("Value of promo code field---" +
      promo_code_field_controller.text);
  debugPrint(
      "Value of address field---" + geo_location_field_controller.text);
  debugPrint("Time of delivery---" + time_of_delivery.toString());
  debugPrint("Payment---" + _payment.toString());
  debugPrint("Other------" + call_me_back.toString());
  debugPrint("DropDownValue___Day___"+dropdownValue_day);
  debugPrint("DropDownValue___Time___"+dropdownValue_time);


}