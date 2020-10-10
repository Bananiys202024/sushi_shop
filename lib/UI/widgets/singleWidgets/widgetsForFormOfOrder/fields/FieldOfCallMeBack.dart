import 'package:flutter/material.dart';
import 'package:flutter_app/core/models/card_model.dart';

enum Other { call_me_back }

Other call_me_back = Other.call_me_back;


Widget get_body_of_other_section(CardModel model) {
  return RadioListTile(
    title: const Text('сall me back to confirm order'),
    value: Other.call_me_back,
    groupValue: call_me_back,
    selected: true,
  );
}

