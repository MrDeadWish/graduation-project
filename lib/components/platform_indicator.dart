import 'package:flutter/material.dart';

Widget platformIndicator({double? value, Color? color}) {
  return Center(
    child: CircularProgressIndicator(value: value, color: color),
  );
}
