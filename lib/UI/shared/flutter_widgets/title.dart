import 'package:flutter/material.dart';

Widget get_title(String title, double font_size, Color color) {
  return Center(
    child: Text(
      title,
      style: new TextStyle(
        fontSize: font_size,
        color: color,
      ),
    ),
  );
}