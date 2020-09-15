import 'package:flutter/material.dart';
import 'package:flutter_app/UI/shared/menu/simplified_top_menu.dart';
import 'package:flutter_app/UI/widgets/checkboxes/categories/LabelNewCheckBox.dart';
import 'package:flutter_app/UI/widgets/checkboxes/categories/NewCheckBox.dart';
import 'package:flutter_app/core/entity/product.dart';
import 'package:flutter_app/core/models/Constants.dart';
import 'package:flutter_app/core/models/card_model.dart';
import 'package:flutter_app/core/viewModels/CRUDModel.dart';
import 'package:flutter_app/main.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:path/path.dart' as Path;
import 'package:provider/provider.dart';

class CreateNewProduct extends StatefulWidget {
  CreateNewProduct({Key key}) : super(key: key);

  @override
  _CreateNewProductState createState() => _CreateNewProductState();
}

enum Other { call_me_back }
enum TimeOfDelivery { so_fast_as_possible, by_a_certain_time }
enum Payment { card, cashe }
enum New { new_product, not_new_product }
enum CategoriesEnum { packs_and_combos, pizza, roll, sushi }

class _CreateNewProductState extends State<CreateNewProduct> {
  final _formKey = GlobalKey<FormState>();
  File _image;
  String _uploadedFileURL;

  FocusNode myFocusNode_phone = FocusNode();
  FocusNode myFocusNode_name = FocusNode();
  FocusNode myFocusNode_promo_code = FocusNode();
  FocusNode myFocusNode_place_of_delivery = FocusNode();
  FocusNode myFocusNode_comment = FocusNode();

  FocusNode myFocusNode_details = FocusNode();

  FocusNode myFocusNode_price = FocusNode();
  FocusNode myFocusNode_old_price = FocusNode();
  FocusNode myFocusNode_is_new_product = FocusNode();
  FocusNode myFocusNode_image = FocusNode();

  TimeOfDelivery time_of_delivery = TimeOfDelivery.so_fast_as_possible;
  Other call_me_back = Other.call_me_back;
  String dropdownValue_day = 'Today';
  String dropdownValue_time = '22:00';
  bool pressed_by_a_certain_time_button = false;
  Payment _payment = Payment.cashe;
  New new_product_enum = New.not_new_product;
  CategoriesEnum categories_enum = CategoriesEnum.pizza;

  final phone_field_controller = TextEditingController();
  final name_field_controller = TextEditingController();
  final promo_code_field_controller = TextEditingController();
  final geo_location_field_controller = TextEditingController();
  final comment_field_controller = TextEditingController();

  final details_field_controller = TextEditingController();

  final price_field_controller = TextEditingController();
  final image_controller = TextEditingController();
  final old_price_field_controller = TextEditingController();
  final is_new_product_field_controller = TextEditingController();

  bool _isSelected_check_box_for_categories_label_new = false;
  bool _isSelected_check_box_for_categories_new = false;
  bool _isSelected_check_box_for_categories_pizza = false;
  bool _isSelected_check_box_for_categories_roll = false;
  bool _isSelected_check_box_for_categories_sushi = false;
  bool _isSelected_check_box_for_categories_packs_and_combos = false;

  String new_categorie = "";
  String pizza_categorie = "pizza";
  String roll_categorie = "";
  String packs_and_combos_categorie = "";
  String sushi_categorie = "";
  String label_new = "";

  @override
  void dispose() {
    myFocusNode_phone.dispose();
    myFocusNode_name.dispose();
    myFocusNode_promo_code.dispose();
    myFocusNode_place_of_delivery.dispose();
    myFocusNode_comment.dispose();
    myFocusNode_price.dispose();
    myFocusNode_old_price.dispose();
    myFocusNode_is_new_product.dispose();
    myFocusNode_image.dispose();
    myFocusNode_details.dispose();

    phone_field_controller.dispose();
    name_field_controller.dispose();
    promo_code_field_controller.dispose();
    geo_location_field_controller.dispose();
    comment_field_controller.dispose();
    details_field_controller.dispose();

    price_field_controller.dispose();
    image_controller.dispose();
    old_price_field_controller.dispose();
    is_new_product_field_controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SimplifiedTopMenu(),
        body: SingleChildScrollView(
          child: form(),
        ));
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

  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
      });
    });
  }

  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('products/${Path.basename(_image.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
      });
    });
  }

  Widget form() {
    double height = MediaQuery.of(context).size.width * 0.65;
    var productProvider = Provider.of<CRUDModel>(context);

    return ScopedModelDescendant<CardModel>(
      builder: (context, child, model) {
        bool is_shop_bucket_empty = model.get_all().length == 0;

        return Padding(
          padding:
              EdgeInsets.only(top: 12.0, left: 10, right: 10, bottom: 12.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                get_title_form_of_order(),
                get_devider(),
                get_name_field(),

                get_details_field(),


                get_price_field(),
                get_old_price_field(),

                get_title_categories(),
                get_devider(),

                get_radio_categories(),

                get_title_new_product(),

                get_devider(),

                get_field_is_new_product(),

                get_title_image(),

                get_devider(),

                Center(
                  child: RaisedButton(
                    child: Text('Choose File'),
                    onPressed: chooseFile,
//                color: Colors.cyan,
                  ),
                ),

                _image != null ? get_title_loaded_image() : Container(),
                _image != null ? get_devider() : Container(),

                _image != null
                    ? Center(
                        child: Image.file(
                          _image,
                          height: 450,
                        ),
                      )
                    : Container(),

                _image != null ? get_devider() : Container(),

                get_title_send(),

//              RaisedButton(
//                child: Text('Upload File'),
//                onPressed: uploadFile,
//                color: Colors.cyan,
//              ),

//
//              _uploadedFileURL != null
//                  ? Image.network(
//                _uploadedFileURL,
//                height: 150,
//              )
//                  : Container(),

//              get_title_time_of_delivery(),
//              get_devider(),
//              get_body_of_time_of_delivery(),
//              pressed_by_a_certain_time_button
//                  ? get_hided_body_of_time_of_delivery()
//                  : new Container(),
//              get_title_place_of_delivery(),
//              get_devider(),
//              get_place_of_delivery_field(),
//              get_title_payment(),
                get_devider(),
//              get_body_of_payment(),
//              get_title_comment(),
//              get_devider(),
//              get_body_comment(),
//              get_title_other(),
//              get_devider(),
//              get_body_of_other_section(model),
                submit_button(productProvider),
              ],
            ),
          ),
        );
      },
    );
  }

  void _requestFocus_name() {
    setState(() {
      myFocusNode_name.addListener(() {
        setState(() {});
      });
    });
  }

  void _requestFocus_details() {
    setState(() {
      myFocusNode_name.addListener(() {
        setState(() {});
      });
    });
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

  Widget get_title_new_product() {
    return Center(
      child: Text(
        "Mark product as new",
        style: new TextStyle(
          fontSize: 20.0,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget get_title_loaded_image() {
    return Center(
      child: Text(
        "Loaded image",
        style: new TextStyle(
          fontSize: 20.0,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget get_title_send() {
    return Center(
      child: Text(
        "Create product",
        style: new TextStyle(
          fontSize: 20.0,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget get_title_image() {
    return Center(
      child: Text(
        "Choose image",
        style: new TextStyle(
          fontSize: 20.0,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget get_title_categories() {
    return Center(
      child: Text(
        "Choose categories",
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
        "Create new product",
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

  Widget get_field_is_new_product() {
    return LabelNewCheckbox(
      label: 'put label new',
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      value: _isSelected_check_box_for_categories_label_new,
      fontsize: 20.0,
      onChanged: (bool newValue) {
        setState(() {
          _isSelected_check_box_for_categories_label_new = newValue;
          label_new = "put label";
        });
      },
    );
  }

  Widget get_radio_categories() {
    return Column(children: <Widget>[
      NewCheckbox(
        label: 'new categorie',
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        value: _isSelected_check_box_for_categories_new,
        fontsize: 20.0,
        onChanged: (bool newValue) {
          setState(() {
            _isSelected_check_box_for_categories_new = newValue;

            if (newValue)
              new_categorie = "new";
            else {
              new_categorie = '';
            }
          });
        },
      ),
      RadioListTile<CategoriesEnum>(
        title: const Text('roll categorie'),
        value: CategoriesEnum.roll,
        groupValue: categories_enum,
        onChanged: (CategoriesEnum value) {
          setState(() {
            debugPrint('VALUE---' + value.toString());
            roll_categorie = 'roll';
            pizza_categorie = '';
            sushi_categorie = '';
            packs_and_combos_categorie = '';
            categories_enum = value;
          });
        },
      ),
      RadioListTile<CategoriesEnum>(
        title: const Text('pizza categorie'),
        value: CategoriesEnum.pizza,
        groupValue: categories_enum,
        onChanged: (CategoriesEnum value) {
          setState(() {
            pizza_categorie = 'pizza';
            sushi_categorie = '';
            roll_categorie = '';
            packs_and_combos_categorie = '';

            categories_enum = value;
          });
        },
      ),
      RadioListTile<CategoriesEnum>(
        title: const Text('sushi categorie'),
        value: CategoriesEnum.sushi,
        groupValue: categories_enum,
        onChanged: (CategoriesEnum value) {
          setState(() {
            sushi_categorie = 'sushi';
            roll_categorie = '';
            pizza_categorie = '';
            packs_and_combos_categorie = '';

            categories_enum = value;
          });
        },
      ),
      RadioListTile<CategoriesEnum>(
        title: const Text('packs and combos categorie'),
        value: CategoriesEnum.packs_and_combos,
        groupValue: categories_enum,
        onChanged: (CategoriesEnum value) {
          setState(() {
            packs_and_combos_categorie = 'packs and combos';
            roll_categorie = '';
            pizza_categorie = '';
            sushi_categorie = '';

            categories_enum = value;
          });
        },
      ),
    ]);
  }

  Widget get_image_field() {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        controller: image_controller,
        focusNode: myFocusNode_image,
        onTap: _requestFocus_image,
        decoration: InputDecoration(
          labelText: 'image',
          labelStyle: TextStyle(
              color: myFocusNode_image.hasFocus ? Colors.black : Colors.grey),
          icon: Icon(Icons.image,
              color: myFocusNode_image.hasFocus ? Colors.black : Colors.grey),
          hintText: 'John',
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget get_price_field() {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        controller: price_field_controller,
        keyboardType: TextInputType.number,
        focusNode: myFocusNode_price,
        onTap: _requestFocus_price,
        decoration: InputDecoration(
          labelText: 'price',
          labelStyle: TextStyle(
              color: myFocusNode_price.hasFocus ? Colors.black : Colors.grey),
          icon: Icon(Icons.attach_money,
              color: myFocusNode_price.hasFocus ? Colors.black : Colors.grey),
          hintText: '7633',
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter price for product';
          }

          return null;
        },
      ),
    );
  }

  Widget get_old_price_field() {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        controller: old_price_field_controller,
        keyboardType: TextInputType.number,
        focusNode: myFocusNode_old_price,
        onTap: _requestFocus_old_price,
        decoration: InputDecoration(
          labelText: 'old_price',
          labelStyle: TextStyle(
              color:
                  myFocusNode_old_price.hasFocus ? Colors.black : Colors.grey),
          icon: Icon(Icons.money_off,
              color:
                  myFocusNode_old_price.hasFocus ? Colors.black : Colors.grey),
          hintText: '33',
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget get_details_field() {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        maxLines: 8,
        maxLength: 1000,
        controller: details_field_controller,
        focusNode: myFocusNode_details,
        onTap: _requestFocus_details,
        decoration: InputDecoration(
          labelText: 'details',
          labelStyle: TextStyle(
              color: myFocusNode_details.hasFocus ? Colors.black : Colors.grey),
          icon: Icon(Icons.account_circle_outlined,
              color: myFocusNode_details.hasFocus ? Colors.black : Colors.grey),
          hintText: 'The dish has 7 flavors. When ordering 30 dishes, 31 dishes as a gift',
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter name for product';
          }

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
          hintText: 'baked devil',
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter name for product';
          }

          return null;
        },
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

  void _requestFocus_price() {
    setState(() {
      myFocusNode_price.addListener(() {
        setState(() {});
      });
    });
  }

  void _requestFocus_old_price() {
    setState(() {
      myFocusNode_old_price.addListener(() {
        setState(() {});
      });
    });
  }

  void _requestFocus_image() {
    setState(() {
      myFocusNode_image.addListener(() {
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



  Widget submit_button(productProvider) {
    return Center(
      child: RaisedButton(
        onPressed: () async {
          debugPrint("CHECKB CHECKBOX");
          debugPrint("Categorie new---" + new_categorie);
          debugPrint("Categorie pizza----" + pizza_categorie);
          debugPrint(
              "Categorie packs and combos---" + packs_and_combos_categorie);
          debugPrint("Categorie roll---" + roll_categorie);
          debugPrint("Categorie sushi---" + sushi_categorie);
          debugPrint("label new product--" + label_new);

          debugPrint('name field ---' + name_field_controller.text);
          debugPrint('old price field---' + old_price_field_controller.text);
          debugPrint('price field---' + price_field_controller.text);

//          uploadFile

          // Validate returns true if the form is valid, or false
          // otherwise.
//
//          debugPrint("Value of phone field---" + phone_field_controller.text);
//          debugPrint("Value of name field---" + name_field_controller.text);
//          debugPrint(
//              "Value of comment field---" + comment_field_controller.text);
//          debugPrint("Value of promo code field---" +
//              promo_code_field_controller.text);
//          debugPrint(
//              "Value of address field---" + geo_location_field_controller.text);
//          debugPrint("Time of delivery---" + time_of_delivery.toString());
//          debugPrint("Payment---" + _payment.toString());
//          debugPrint("Other------" + call_me_back.toString());

          debugPrint('categorie enum---'+categories_enum.toString().substring(14));

          if (_formKey.currentState.validate()) {

            String url_path_to_image = '';

            await uploadFile();
            _formKey.currentState.save();

            debugPrint("Uplaoded url--"+ _uploadedFileURL);

            debugPrint('here');
            await productProvider.addProduct(
              Product(_uploadedFileURL, details_field_controller.text, name_field_controller.text,
                  price_field_controller.text, old_price_field_controller.text,
                  categories_enum.toString().substring(14), this._isSelected_check_box_for_categories_label_new)
            );

//            this.name, this.details, this.image,
//          this.price, this.old_price, this.is_favorite,
//          this.is_new, this.quantity

            Navigator.pop(context);

            // If the form is valid, display a Snackbar.
//            Scaffold.of(context)
//                .showSnackBar(SnackBar(content: Text('Processing Data....')));

//            Navigator.push(
//                context, MaterialPageRoute(builder: (context) => MyApp()));
          }
        },
        child: Text('Submit'),
      ),
    );
  }
}
