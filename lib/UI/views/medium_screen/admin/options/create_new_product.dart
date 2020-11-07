import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/UI/shared/menu/simplified_top_menu.dart';
import 'package:flutter_app/UI/widgets/checkboxes/categories/LabelNewCheckBox.dart';
import 'package:flutter_app/UI/widgets/checkboxes/categories/NewCheckBox.dart';
import 'package:flutter_app/UI/widgets/flutter_widgets/devider.dart';
import 'package:flutter_app/UI/widgets/flutter_widgets/text_form_field.dart';
import 'package:flutter_app/UI/widgets/flutter_widgets/title.dart';
import 'package:flutter_app/UI/widgets/singleWidgets/widgets/fragments/submit/create_new_product.dart';
import 'package:flutter_app/core/entity/product.dart';
import 'package:flutter_app/core/models/Constants.dart';
import 'package:flutter_app/core/models/card_model.dart';
import 'package:flutter_app/core/viewModels/CRUDModelForTableProducts.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:path/path.dart' as Path;
import 'package:provider/provider.dart';

class CreateNewProduct extends StatefulWidget {
  CreateNewProduct({Key key, this.snapshot}) : super(key: key);

  var snapshot;

  @override
  _CreateNewProductState createState() => _CreateNewProductState();
}

enum CategoriesEnum { packs_and_combos, pizza, roll, sushi }

class _CreateNewProductState extends State<CreateNewProduct> {
  final _formKey = GlobalKey<FormState>();

  File _image;

  FocusNode _myFocusNode_phone = FocusNode();
  FocusNode _myFocusNode_name = FocusNode();
  FocusNode _myFocusNode_details = FocusNode();
  FocusNode _myFocusNode_price = FocusNode();
  FocusNode _myFocusNode_old_price = FocusNode();

  CategoriesEnum _categories_enum = CategoriesEnum.pizza;

  final _phone_field_controller = TextEditingController();
  final _name_field_controller = TextEditingController();
  final _details_field_controller = TextEditingController();
  final _price_field_controller = TextEditingController();
  final _old_price_field_controller = TextEditingController();

  bool _isSelected_check_box_for_label_new = false;

  @override
  void dispose() {
    _myFocusNode_phone.dispose();
    _myFocusNode_name.dispose();
    _myFocusNode_price.dispose();
    _myFocusNode_old_price.dispose();
    _myFocusNode_details.dispose();
    _phone_field_controller.dispose();
    _name_field_controller.dispose();
    _details_field_controller.dispose();
    _price_field_controller.dispose();
    _old_price_field_controller.dispose();

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

  Widget form() {
    var _productProvider = Provider.of<CRUDModelForTableProducts>(context);

    return Padding(
      padding: EdgeInsets.only(top: 12.0, left: 10, right: 10, bottom: 12.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            get_title("Create new product", 20.0, Colors.black),
            devider(),
            text_form_field_name(
              _name_field_controller,
              _myFocusNode_name,
              _requestFocus_name,
              "name",
              "baked devil",
              Icons.account_circle_outlined,
              "Please enter name for product",
              widget.snapshot,
            ),
            text_form_field(
                _details_field_controller,
                _myFocusNode_details,
                _requestFocus_details,
                'details',
                'put more vasabi',
                Icons.account_circle_outlined,
                'Please enter details for product'),
            text_form_field(
                _price_field_controller,
                _myFocusNode_price,
                _requestFocus_price,
                'price',
                '199',
                Icons.attach_money,
                "Please enter price for product"),
            text_form_field(
                _old_price_field_controller,
                _myFocusNode_old_price,
                _requestFocus_old_price,
                'old_price',
                '33',
                Icons.money_off,
                "empty"),
            get_title("Choose categories", 20.0, Colors.black),
            devider(),
            get_radio_categories(),
            get_title("Mark product as new", 20.0, Colors.black),
            devider(),
            get_field_is_new_product(),
            get_title("Choose image", 20.0, Colors.black),
            devider(),
            choose_file_to_load(),
            _image != null ? get_block_of_loaded_image() : Container(),
            get_title("Create product", 20.0, Colors.black),
            devider(),
            submit_button(
              _productProvider,
              _formKey,
              _image,
              _name_field_controller,
              _details_field_controller,
              _price_field_controller,
              _old_price_field_controller,
              _categories_enum,
              this._isSelected_check_box_for_label_new,
              context,
            ),
          ],
        ),
      ),
    );
  }

  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
      });
    });
  }

  Widget text_form_field_name(
    TextEditingController _field_controller,
    FocusNode _myFocusNode,
    _requestFocus,
    String _labelText,
    String _hintText,
    IconData _icon,
    String _validator_text,
    snapshot,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        autovalidate: true,
        controller: _field_controller,
        focusNode: _myFocusNode,
        onTap: _requestFocus,
        decoration: InputDecoration(
          labelText: _labelText,
          labelStyle: TextStyle(
              color: _myFocusNode.hasFocus ? Colors.black : Colors.grey),
          icon: Icon(_icon,
              color: _myFocusNode.hasFocus ? Colors.black : Colors.grey),
          hintText: _hintText,
          errorMaxLines: 2,
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
            ),
          ),
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
        validator: (value) {

          if (value.isEmpty) {
            return _validator_text;
          }

//check if name taken

          //get list
          List<dynamic> list;
          bool is_name_taken = false;

          if (snapshot.hasData) {
            list = snapshot.data.documents
                .map((doc) => Product.fromMap(doc.data(), doc.documentID))
                .toList();
          }

          debugPrint("LIST---" + list.toString());

          ///..
          if (list != null)
            for (int i = 0; i < list.length; i++) {
              Product element = list[i];
              if (element.name == value) is_name_taken = true;
            }

          if (is_name_taken) {
              return "Already exist product with that name";
          }
//...


          return null;
        },
      ),
    );
  }

  get_block_of_loaded_image() {
    return Column(children: <Widget>[
      get_title("Loaded image", 20.0, Colors.black),
      devider(),
      display_image(),
      devider(),
    ]);
  }

  Widget get_field_is_new_product() {
    return LabelNewCheckbox(
      label: 'put label new',
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      value: _isSelected_check_box_for_label_new,
      fontsize: 20.0,
      onChanged: (bool newValue) {
        setState(() {
          _isSelected_check_box_for_label_new = newValue;
        });
      },
    );
  }

  Widget get_radio_categories() {
    return Column(children: <Widget>[
      RadioListTile<CategoriesEnum>(
        title: const Text('roll categorie'),
        value: CategoriesEnum.roll,
        groupValue: _categories_enum,
        onChanged: (CategoriesEnum value) {
          setState(() {
            _categories_enum = value;
          });
        },
      ),
      RadioListTile<CategoriesEnum>(
        title: const Text('pizza categorie'),
        value: CategoriesEnum.pizza,
        groupValue: _categories_enum,
        onChanged: (CategoriesEnum value) {
          setState(() {
            _categories_enum = value;
          });
        },
      ),
      RadioListTile<CategoriesEnum>(
        title: const Text('sushi categorie'),
        value: CategoriesEnum.sushi,
        groupValue: _categories_enum,
        onChanged: (CategoriesEnum value) {
          setState(() {
            _categories_enum = value;
          });
        },
      ),
      RadioListTile<CategoriesEnum>(
        title: const Text('packs and combos categorie'),
        value: CategoriesEnum.packs_and_combos,
        groupValue: _categories_enum,
        onChanged: (CategoriesEnum value) {
          setState(() {
            _categories_enum = value;
          });
        },
      ),
    ]);
  }

  void _requestFocus_name() {
    setState(() {
      _myFocusNode_name.addListener(() {
        setState(() {});
      });
    });
  }

  void _requestFocus_details() {
    setState(() {
      _myFocusNode_name.addListener(() {
        setState(() {});
      });
    });
  }

  void _requestFocus_price() {
    setState(() {
      _myFocusNode_price.addListener(() {
        setState(() {});
      });
    });
  }

  void _requestFocus_old_price() {
    setState(() {
      _myFocusNode_old_price.addListener(() {
        setState(() {});
      });
    });
  }

  void _requestFocus_phone() {
    setState(() {
      _myFocusNode_phone.addListener(() {
        setState(() {});
      });
    });
  }

  display_image() {
    return Center(
      child: Image.file(
        _image,
        height: 450,
      ),
    );
  }

  choose_file_to_load() {
    return Center(
      child: RaisedButton(
        child: Text('Choose File'),
        onPressed: chooseFile,
      ),
    );
  }
}
