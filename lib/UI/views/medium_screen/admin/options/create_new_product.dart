import 'package:flutter/material.dart';
import 'package:flutter_app/UI/shared/menu/simplified_top_menu.dart';
import 'package:flutter_app/UI/widgets/checkboxes/categories/LabelNewCheckBox.dart';
import 'package:flutter_app/UI/widgets/checkboxes/categories/NewCheckBox.dart';
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
  CreateNewProduct({Key key}) : super(key: key);

  @override
  _CreateNewProductState createState() => _CreateNewProductState();
}

enum CategoriesEnum { packs_and_combos, pizza, roll, sushi }

class _CreateNewProductState extends State<CreateNewProduct> {
  final _formKey = GlobalKey<FormState>();

  File _image;

  String _uploadedFileURL;

  FocusNode myFocusNode_phone = FocusNode();
  FocusNode myFocusNode_name = FocusNode();
  FocusNode myFocusNode_details = FocusNode();
  FocusNode myFocusNode_price = FocusNode();
  FocusNode myFocusNode_old_price = FocusNode();

  CategoriesEnum categories_enum = CategoriesEnum.pizza;

  final phone_field_controller = TextEditingController();
  final name_field_controller = TextEditingController();
  final details_field_controller = TextEditingController();
  final price_field_controller = TextEditingController();
  final old_price_field_controller = TextEditingController();

  bool _isSelected_check_box_for_label_new = false;

  @override
  void dispose() {
    myFocusNode_phone.dispose();
    myFocusNode_name.dispose();
    myFocusNode_price.dispose();
    myFocusNode_old_price.dispose();
    myFocusNode_details.dispose();
    phone_field_controller.dispose();
    name_field_controller.dispose();
    details_field_controller.dispose();
    price_field_controller.dispose();
    old_price_field_controller.dispose();

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
    var productProvider = Provider.of<CRUDModelForTableProducts>(context);
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
                choose_file_to_load(),
                _image != null ? get_block_of_loaded_image() : Container(),
                get_title_send(),
                get_devider(),
                submit_button(productProvider),
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

  Future uploadFile() async {

    //check if image equals to null then don't do nothing
  if(_image.toString() != 'null') {
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

  }

  get_block_of_loaded_image() {
    return Column(children: <Widget>[
      get_title_loaded_image(),
      get_devider(),
      display_image(),
      get_devider(),
    ]);
  }

  Widget get_devider() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Divider(color: Colors.black),
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
        groupValue: categories_enum,
        onChanged: (CategoriesEnum value) {
          setState(() {
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
            categories_enum = value;
          });
        },
      ),
    ]);
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
          hintText:
              'The dish has 7 flavors. When ordering 30 dishes, 31 dishes as a gift',
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

  void _requestFocus_phone() {
    setState(() {
      myFocusNode_phone.addListener(() {
        setState(() {});
      });
    });
  }

  Widget submit_button(productProvider) {
    return Center(
      child: RaisedButton(
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            await uploadFile();
            _formKey.currentState.save();


            await productProvider.addProduct(Product(
                _uploadedFileURL,
                details_field_controller.text,
                name_field_controller.text,
                int.parse(price_field_controller.text),
                int.parse(old_price_field_controller.text),
                categories_enum.toString().substring(15),
                this._isSelected_check_box_for_label_new));

            Navigator.pop(context);
          }
        },
        child: Text('Submit'),
      ),
    );
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
