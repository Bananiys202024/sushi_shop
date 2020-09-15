import 'package:flutter/material.dart';
import 'package:flutter_app/core/models/Constants.dart';
import 'package:flutter_app/core/models/card_model.dart';
import 'package:flutter_app/core/models/product.dart';
import 'package:flutter_app/main.dart';
import 'package:scoped_model/scoped_model.dart';

class BodyFormOfOrder extends StatefulWidget {
  CardModel model;

  BodyFormOfOrder({Key key, this.model}) : super(key: key);

  @override
  _BodyFormOfOrderState createState() => _BodyFormOfOrderState();
}

enum Other { call_me_back }

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
  Other call_me_back = Other.call_me_back;
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

  TimeOfDay _time = new TimeOfDay.now();

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );

    if (picked != null && picked != _time) {
      print('Time selected: ${_time.toString()}');
      setState(() {
        _time = picked;
      });
    }
  }

  Widget form(CardModel model) {
    double height = MediaQuery.of(context).size.width * 0.65;

    return ScopedModelDescendant<CardModel>(
      builder: (context, child, model) {
        bool is_shop_bucket_empty = model.get_all().length == 0;

        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
//              LimitedBox(
//                  maxHeight: height,
//                  child:
//              Wrap(
//                  children:
//                  <Widget>[
              is_shop_bucket_empty ? Container() : show_ordered_items(model),
//                  ],
//                ),
//              ),
              get_title_form_of_order(),
              get_devider(),
              get_phone_field(),
              get_name_field(),
              get_promo_code_field(),
              get_title_time_of_delivery(),
              get_devider(),
              get_body_of_time_of_delivery(),
              pressed_by_a_certain_time_button
                  ? get_hided_body_of_time_of_delivery()
                  : new Container(),
              get_title_place_of_delivery(),
              get_devider(),
              get_place_of_delivery_field(),
              get_title_payment(),
              get_devider(),
              get_body_of_payment(),
              get_title_comment(),
              get_devider(),
              get_body_comment(),
              get_title_other(),
              get_devider(),
              get_body_of_other_section(model),
              submit_button(),
            ],
          ),
        );
      },
    );
  }

  Widget get_devider() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Divider(color: Colors.black),
    );
  }

  get_title_payment() {
    return Center(
      child: Text(
        "Payment",
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  Widget get_title_time_of_delivery() {
    return Center(
      child: Text(
        "Time of delivery",
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  Widget get_title_place_of_delivery() {
    return Center(
      child: Text(
        "Place of delivery",
        style: new TextStyle(
          fontSize: 20.0,
          color: Colors.black,
        ),
      ),
    );
  }

  get_title_comment() {
    return Center(
      child: Text(
        "add comment",
        style: new TextStyle(
          fontSize: 20.0,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget get_title_form_of_order() {
    return Center(
      child: Text(
        "Form of order",
        style: new TextStyle(
          fontSize: 20.0,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget get_title_other() {
    return Center(
      child: Text(
        "Other",
        style: new TextStyle(
          fontSize: 20.0,
          color: Colors.black,
        ),
      ),
    );
  }

  get_phone_field() {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        controller: phone_field_controller,
        keyboardType: TextInputType.phone,
        focusNode: myFocusNode_phone,
        onTap: _requestFocus_phone,
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

  Widget get_name_field() {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        controller: name_field_controller,
        focusNode: myFocusNode_name,
        onTap: _requestFocus_name,
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

  Widget get_body_comment() {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        controller: comment_field_controller,
        keyboardType: TextInputType.multiline,
        maxLines: 10,
        maxLength: 100,
        focusNode: myFocusNode_comment,
        onTap: _requestFocus_comment,
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

  get_promo_code_field() {
    return TextFormField(
      controller: promo_code_field_controller,
      focusNode: myFocusNode_promo_code,
      onTap: _requestFocus_promo_code,
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

  void _requestFocus_name() {
    setState(() {
      myFocusNode_name.addListener(() {
        setState(() {});
      });
    });
  }

  void _requestFocus_phone() {
    setState(() {
      myFocusNode_phone.addListener(() {
        setState(() {});
      });
    });
  }

  void _requestFocus_comment() {
    setState(() {
      myFocusNode_comment.addListener(() {
        setState(() {});
      });
    });
  }

  void _requestFocus_place_of_delivery() {
    setState(() {
      myFocusNode_place_of_delivery.addListener(() {
        setState(() {});
      });
    });
  }

  void _requestFocus_promo_code() {
    setState(() {
      myFocusNode_phone.addListener(() {
        setState(() {});
      });
    });
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

  get_place_of_delivery_field() {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        controller: geo_location_field_controller,
        focusNode: myFocusNode_place_of_delivery,
        onTap: _requestFocus_place_of_delivery,
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

  Widget get_body_of_other_section(CardModel model) {
    return RadioListTile(
      title: const Text('сall me back to confirm order'),
      value: Other.call_me_back,
      groupValue: call_me_back,
      selected: true,
    );
  }

  Widget show_ordered_items(CardModel model) {
    int total_price = 0;

    //get total price
    List<Product> list = model.get_all();
    for (int i = 0; i < list.length; i++)
      total_price +=
          int.parse(list[i].price.substring(0, list[i].price.length - 1)) *
              list[i].quantity;
    //...

    return new Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            child: new Text(
              "Your order",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        get_devider(),
        ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: model.get_all().length,
          itemBuilder: (context, pos) {
            Product product = model.get_all()[pos];
            //just to get price as int
            int quantity = product.quantity;
            String string_price = product.price;
            string_price = string_price.substring(0, string_price.length - 1);
            int price = int.parse(string_price) * product.quantity;
            //...

            return pattern_ordered_items(product, price);
          },
        ),
        get_devider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Text(
              'Total',
              style: TextStyle(fontSize: 20),
            ),
            new Text(
              total_price.toString() + "p",
              style: TextStyle(fontSize: 20),
            ),
          ],
        )
      ],
    );
  }

  Widget pattern_ordered_items(Product product, int price) {
    return new Column(
      children: <Widget>[
        Card(
          child: ListTile(
            leading: SizedBox(
              height: 60,
              width: 80,
              child: Image(
                image: AssetImage(product.image + product.id + '.png'),
              ),
            ),
            title: Text(product.name),
            subtitle: Text(price.toString() + "p"),
            trailing: new Text('x' + product.quantity.toString()),
          ),
        ),
      ],
    );
  }

  Widget submit_button() {
    return Center(
      child: RaisedButton(
        onPressed: () {
          // Validate returns true if the form is valid, or false
          // otherwise.

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

          if (_formKey.currentState.validate()) {
            // If the form is valid, display a Snackbar.
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text('Processing Data....')));

            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyApp()));
          }
        },
        child: Text('Submit'),
      ),
    );
  }
}
