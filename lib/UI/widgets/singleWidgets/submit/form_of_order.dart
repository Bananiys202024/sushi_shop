import 'package:flutter/material.dart';
import 'package:flutter_app/UI/views/main.dart';
import 'package:flutter_app/core/entity/order.dart';
import 'package:flutter_app/core/entity/product.dart';
import 'package:flutter_app/core/models/card_model.dart';
import 'package:flutter_app/debug/print/print_values_from_form_of_order.dart';

submit_button(phone_field_controller,
    name_field_controller,
    comment_field_controller,
    promo_code_field_controller,
    geo_location_field_controller,
    time_of_delivery,
    _payment,
    call_me_back,
    context,
    _formKey,
    dropdownValue_day,
    dropdownValue_time,
    provider,
    CardModel model,) {
  return Center(
    child: RaisedButton(
      onPressed: () async {
        // Validate returns true if the form is valid, or false
        // otherwise.

        debugPrint("Before print");
        print_values_from_form_of_order(
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
        );


        debugPrint("After print values_" +
            _formKey.currentState.validate().toString());

//        if (_formKey.currentState.validate()) {

        // If the form is valid, display a Snackbar.
        List<Product> list = model.get_all();
        List<Map<String, dynamic>> json_list_of_objects = await get_json_list_of_objects(
            list);

        //block for define time
        String time = "";


        if (time_of_delivery == "so_fast_as_possible") {
          time = "so fast as possible";
        }

        if (time_of_delivery == "by_a_certain_time") {
          time = " " + dropdownValue_day + " " + dropdownValue_time;
        }
        //...

        debugPrint("try save....");
        try {
          await debugPrint('start inside');
          await provider.addProduct(Order(
              name_field_controller.text,
              json_list_of_objects,
              promo_code_field_controller.text,
              phone_field_controller.text,
              comment_field_controller.text,
              geo_location_field_controller.text,
              time)
          );
          await debugPrint("still inside try");
        }
        catch (e) {
          debugPrint("ERROR---" + e.toString());
        }

        debugPrint("end save...");
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Processing Data....')));

        //in case success result;
        model.removeAll();

        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainPage(initIndex: 0,)));

//        }
      },
      child: Text('Submit'),
    ),
  );
}

get_json_list_of_objects(List<Product> list) async
{
  List<Map<String, dynamic>> list_of_objects = await List<Map<String, dynamic>>(list.length);
  int count = 0; //because can't add to a fixd length list so we create a counter;
  Map<String, dynamic> value = null;
  for (Product product in list) {

    value = await product.toJson();
    list_of_objects[count] = value;
    count++;
    debugPrint("Counter---"+count.toString());
  }

  return list_of_objects;
}