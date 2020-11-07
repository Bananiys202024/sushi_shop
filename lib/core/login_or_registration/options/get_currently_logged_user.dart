
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


get_currently_logged_user(_auth)
{


  String logged_user = _auth.currentUser.phoneNumber.toString().toLowerCase();


  return logged_user;
}