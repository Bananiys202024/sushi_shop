import 'package:flutter/material.dart';
import 'package:flutter_app/UI/shared/flutter_widgets/divider.dart';
import 'package:flutter_app/UI/shared/flutter_widgets/text_form_field/multiline_text_form_field.dart';
import 'package:flutter_app/UI/shared/flutter_widgets/text_form_field/text_form_field.dart';
import 'package:flutter_app/UI/shared/flutter_widgets/text_form_field/text_form_field_not_require_validation.dart';
import 'package:flutter_app/UI/shared/flutter_widgets/title.dart';

import 'package:flutter_app/UI/widgets/fragments/show_ordered_items_inside_shop_bucket_on_tab_order_on_final_stage_of_order.dart';
import 'package:flutter_app/UI/widgets/fragments/submit/form_of_order.dart';
import 'package:flutter_app/UI/widgets/fragments/FieldOfCallMeBack.dart';
import 'package:flutter_app/UI/widgets/fragments/FieldPhone.dart';
import 'package:flutter_app/core/models/card_model.dart';
import 'package:flutter_app/core/viewModels/CRUDModelForTableOrders.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';

class BodyFormOfOrder extends StatefulWidget {
  CardModel model;

  BodyFormOfOrder({Key key, this.model}) : super(key: key);

  @override
  _BodyFormOfOrderState createState() => _BodyFormOfOrderState();
}


enum TimeOfDelivery { so_fast_as_possible, by_a_certain_time }

enum Payment { card, cashe }

class _BodyFormOfOrderState extends State<BodyFormOfOrder> {

  final _formKey = GlobalKey<FormState>();

  FocusNode myFocusNode_phone = FocusNode();
  FocusNode myFocusNode_name = FocusNode();
  FocusNode myFocusNode_promo_code = FocusNode();
  FocusNode myFocusNode_place_of_delivery = FocusNode();
  FocusNode myFocusNode_comment = FocusNode();
  TimeOfDelivery time_of_delivery = TimeOfDelivery.so_fast_as_possible;
  String dropdownValue_day = 'Today';
  String dropdownValue_time = '22:00';
  bool pressed_by_a_certain_time_button = false;
  Payment _payment = Payment.cashe;


  final phone_field_controller = TextEditingController();
  final name_field_controller = TextEditingController();
  final promo_code_field_controller = TextEditingController();
  final geo_location_field_controller = TextEditingController();
  final comment_field_controller = TextEditingController();

  @override
  void dispose() {
    myFocusNode_phone.dispose();
    myFocusNode_name.dispose();
    myFocusNode_promo_code.dispose();
    myFocusNode_place_of_delivery.dispose();
    myFocusNode_comment.dispose();

    phone_field_controller.dispose();
    name_field_controller.dispose();
    promo_code_field_controller.dispose();
    geo_location_field_controller.dispose();
    comment_field_controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return form(widget.model);
  }

  Widget form(CardModel model) {
    double height = MediaQuery.of(context).size.width * 0.65;
    var provider = Provider.of<CRUDModelForTableOrders>(context);

    return ScopedModelDescendant<CardModel>(
      builder: (context, child, model) {
        bool is_shop_bucket_empty = model.get_all().length == 0;

        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              is_shop_bucket_empty ? Container() : show_ordered_items(model),
              get_title("Form of order", 20.0, Colors.black),

              get_devider(),
              get_phone_field(phone_field_controller, myFocusNode_phone),


              text_form_field(
               name_field_controller,
                myFocusNode_name,
                _requestFocus_name,
                "name",
                "John",
                Icons.account_circle_outlined,
                "Please enter name",
              ),

              text_form_field_not_require_validation
                (
                  promo_code_field_controller,
                  myFocusNode_promo_code,
                  _requestFocus_promo_code,
                "promo code",
                "Spanch Bob",
                  Icons.whatshot,
                ""
              ),
              get_title("Time of delivery", 20.0, Colors.black),

              get_devider(),
              get_body_of_time_of_delivery(),
              pressed_by_a_certain_time_button
                  ? get_hided_body_of_time_of_delivery()
                  : new Container(),
              get_title("Place of delivery", 20.0, Colors.black),

              get_devider(),

              text_form_field(
                geo_location_field_controller,
                myFocusNode_place_of_delivery,
                _requestFocus_place_of_delivery,
                "address",
                "1 North Street Pembroke HM 09 Bermuda.",
                Icons.location_on,
                "Please enter place of delivery",
              ) ,

              get_title("Payment", 20.0, Colors.black),

              get_devider(),
              get_body_of_payment(),
              get_title("add comment", 20.0, Colors.black),
              get_devider(),

              multiline_text_form_field(
                comment_field_controller,
                myFocusNode_comment,
                _requestFocus_comment,
                "",
                "",
                null,
                "",
              ),

              get_title("Other", 20.0, Colors.black),
              get_devider(),
              get_body_of_other_section(model),
              submit_button(
                phone_field_controller,
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
                model,
              ),
            ],
          ),
        );
      },
    );
  }





  Widget get_body_of_time_of_delivery() {
    return Column(
      children: <Widget>[
        RadioListTile<TimeOfDelivery>(
          title: const Text('so fast as possible'),
          value: TimeOfDelivery.so_fast_as_possible,
          groupValue: time_of_delivery,
          onChanged: (TimeOfDelivery value) {
            setState(() {
            time_of_delivery = value;
            pressed_by_a_certain_time_button = false;
            });
          },
        ),
        RadioListTile<TimeOfDelivery>(
          title: const Text('by a certain time'),
          value: TimeOfDelivery.by_a_certain_time,
          groupValue: time_of_delivery,
          onChanged: (TimeOfDelivery value) {
            setState(() {

              time_of_delivery = value;
            pressed_by_a_certain_time_button = true;
    });
            },
        ),
      ],
    );
  }


  _requestFocus_comment(myFocusNode_comment) {

    setState(() {
      myFocusNode_comment.addListener(() {
        setState(() {});
      });
    });
  }

  _requestFocus_place_of_delivery(myFocusNode_place_of_delivery) {
    setState(() {
      myFocusNode_place_of_delivery.addListener(() {
        setState(() {});
      });
    });
    }

  _requestFocus_name(myFocusNode_name) {
    setState(() {
      myFocusNode_name.addListener(() {
        setState(() {});
      });
    });
  }


  _requestFocus_promo_code(myFocusNode_promo_code) {
    setState(() {
      myFocusNode_promo_code.addListener(() {
        setState(() {});
      });
    });
  }




  get_body_of_payment() {
    return Column(
      children: <Widget>[
        RadioListTile<Payment>(
          title: const Text('сash payment'),
          value: Payment.cashe,
          groupValue: _payment,
          onChanged: (Payment value) {
    setState(() {

            _payment = value;
    });

          },
        ),
        RadioListTile<Payment>(
          title: const Text('card payment'),
          value: Payment.card,
          groupValue: _payment,
          onChanged: (Payment value) {
            setState(() {

            _payment = value;
            });

          },
        ),
      ],
    );
  }



  Widget get_hided_body_of_time_of_delivery() {
    return Padding(
      padding: EdgeInsets.only(left: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DropdownButton<String>(
            value: dropdownValue_day,
            style: TextStyle(color: Colors.black, fontSize: 20),
            onChanged: (String newValue) {
setState(() {

              dropdownValue_day = newValue;

    });

  },
            items: <String>['Today', 'Tomorrow', '26.06.2020', '27.06.2020']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          DropdownButton<String>(
            value: dropdownValue_time,
            style: TextStyle(color: Colors.black, fontSize: 20),
            onChanged: (String newValue) {
              setState(() {

              dropdownValue_time = newValue;
    });

  },
            items: <String>['22:00', '22:30', '23:00', '23:30', '00:00']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }


}
