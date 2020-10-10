// my_twilio.dart

import 'package:flutter_app/core/services/twilio/messages.dart';

class Twilio {
  final String _accountSid;
  final String _authToken;

  const Twilio(this._accountSid, this._authToken);

  Messages get messages => Messages(_accountSid, _authToken);
}