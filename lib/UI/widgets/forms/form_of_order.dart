import 'package:flutter/material.dart';
import 'package:flutter_app/UI/widgets/singleWidgets/widgets/divider.dart';
import 'package:flutter_app/UI/widgets/singleWidgets/widgets/fields/FieldComment.dart';
import 'package:flutter_app/UI/widgets/singleWidgets/widgets/fields/FieldDeliveryPlace.dart';
import 'package:flutter_app/UI/widgets/singleWidgets/widgets/fields/FieldName.dart';
import 'package:flutter_app/UI/widgets/singleWidgets/widgets/fields/FieldOfCallMeBack.dart';
import 'package:flutter_app/UI/widgets/singleWidgets/widgets/fields/FieldPhone.dart';
import 'package:flutter_app/UI/widgets/singleWidgets/widgets/fields/FieldPromoCode.dart';
import 'package:flutter_app/UI/widgets/singleWidgets/widgets/fragments/show_ordered_items_inside_shop_bucket_on_tab_order_on_final_stage_of_order.dart';
import 'package:flutter_app/UI/widgets/singleWidgets/widgets/fragments/submit/form_of_order.dart';
import 'package:flutter_app/UI/widgets/singleWidgets/widgets/titles/TitleFormOfOrder.dart';
import 'package:flutter_app/UI/widgets/singleWidgets/widgets/titles/TitleOfOther.dart';
import 'package:flutter_app/UI/widgets/singleWidgets/widgets/titles/TitlePayment.dart';
import 'package:flutter_app/UI/widgets/singleWidgets/widgets/titles/titleComment.dart';
import 'package:flutter_app/UI/widgets/singleWidgets/widgets/titles/titleDelivery.dart';
import 'package:flutter_app/UI/widgets/singleWidgets/widgets/titles/titlePlaceOfDelivery.dart';
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
              get_title_form_of_order(),
              get_devider(),
              get_phone_field(phone_field_controller, myFocusNode_phone),
              get_name_field(name_field_controller, myFocusNode_name),
              get_promo_code_field(promo_code_field_controller, myFocusNode_promo_code),
              get_title_time_of_delivery(),
              get_devider(),
              get_body_of_time_of_delivery(),
              pressed_by_a_certain_time_button
                  ? get_hided_body_of_time_of_delivery()
                  : new Container(),
              get_title_place_of_delivery(),
              get_devider(),
              get_place_of_delivery_field(geo_location_field_controller, myFocusNode_place_of_delivery),
              get_title_payment(),
              get_devider(),
              get_body_of_payment(),
              get_title_comment(),
              get_devider(),
              get_body_comment(comment_field_controller, myFocusNode_comment),
              get_title_other(),
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
