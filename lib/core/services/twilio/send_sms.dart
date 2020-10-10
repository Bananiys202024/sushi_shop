// send_sms.dart

import 'dart:io' show Platform;
import 'dart:math';

import 'package:flutter_app/core/models/twilio.dart';


Future<void> send_sms_to_phone_twilio(int generated_code, String phone) async {
  // See http://twil.io/secure for important security information
  var _accountSid = Platform.environment['TWILIO_ACCOUNT_SID'];
  var _authToken = Platform.environment['TWILIO_AUTH_TOKEN'];

  // Your Account SID and Auth Token from www.twilio.com/console
  // You can skip this block if you store your credentials in environment variables
  _accountSid ??= 'AC11633a33e992df442b167e7a702f0fcf';
  _authToken ??= '133dce9ededae091031212f6d1d24a83';

  // Create an authenticated client instance for Twilio API
  var client = new Twilio(_accountSid, _authToken);

  // Send a text message
  // Returns a Map object (key/value pairs)
  Map message = await client.messages.create({
    'body': 'Your code for registration in sushi shop application:'+ generated_code.toString(),
    'from': '+19048440791', // a valid Twilio number
    'to': '+'+phone, // your phone number
  });

  // access individual properties using the square bracket notation
  // for example print(message['sid']);
  print(message);
}