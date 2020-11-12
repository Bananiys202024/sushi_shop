import 'package:flutter/material.dart';

class NewCheckbox extends StatelessWidget {
  const NewCheckbox({
    this.label,
    this.padding,
    this.value,
    this.onChanged,
    this.fontsize
  });

  final String label;
  final EdgeInsets padding;
  final bool value;
  final Function onChanged;
  final double fontsize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Expanded(child: Text(label, style: TextStyle(fontSize: fontsize))),
            Checkbox(
              value: value,
              onChanged: (bool newValue) {
                onChanged(newValue);
              },
            ),
          ],
        ),
      ),
    );
  }
}
