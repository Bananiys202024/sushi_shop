import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/entity/product.dart';
import 'package:flutter_app/core/util/create_list_of_search_key_words.dart';

String _uploadedFileURL;

Widget submit_button(productProvider, _formKey, _image,
    _name_field_controller,
    _details_field_controller,
    _price_field_controller,
    _old_price_field_controller,
    _categories_enum,
    _mark_as_new,
    context,
    ) {

  return Center(
    child: RaisedButton(
      onPressed: () async {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();

          FirebaseAuth auth = FirebaseAuth.instance;
          debugPrint("CurrentUser---" + auth.currentUser.toString());

          if (_image != null)
            debugPrint('Image exist or not---' + _image.toString());

          await _uploadFile(_image);

          List<String> _list_of_search_keywords =
          await create_search_key_words_list(_name_field_controller.text);
          debugPrint('URL--' + _uploadedFileURL.toString());
          debugPrint("List---" + _list_of_search_keywords.toString());
          productProvider.addProduct(Product.createNewProduct(
            _uploadedFileURL.toString().toLowerCase(),
            _details_field_controller.text.toString().toLowerCase(),
            _name_field_controller.text.toString().toLowerCase(),
            int.parse(_price_field_controller.text.toString().toLowerCase()),
            int.parse(_old_price_field_controller.text.toString().toLowerCase()),
            _categories_enum.toString().substring(15).toString().toLowerCase(),
//            _isSelected_check_box_for_label_new,
            _mark_as_new,
            _list_of_search_keywords,
            null,
          ));

          Navigator.pop(context);
        }
      },
      child: Text('Submit'),
    ),
  );
}


Future _uploadFile(_image) async {
  debugPrint(
      "Image from uploadFile from create_new_product:__" + _image.toString());
  //check if image equals to null then don't do nothing
  if (_image != null) {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('products/${_image.path}}');
//  .child('products/${Path.basename(_image.path)}}');

  StorageUploadTask uploadTask = storageReference.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    // Waits till the file is uploaded then stores the download url
    String url = await taskSnapshot.ref.getDownloadURL();
    debugPrint("URL OF SFEWVRN__" + url);
    print('File Uploaded');
    _uploadedFileURL = url;
  }

}
