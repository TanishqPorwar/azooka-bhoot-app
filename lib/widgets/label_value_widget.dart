import 'package:flutter/material.dart';

class LabelValueWidget extends StatelessWidget {
  final String label, value;
  final TextStyle labelStyle, valueStyle;

  const LabelValueWidget(
      {Key key, this.label, this.value, this.labelStyle, this.valueStyle})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(value, style: valueStyle),
        Text(label, style: labelStyle)
      ],
    );
  }
}
