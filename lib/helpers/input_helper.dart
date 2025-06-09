import 'package:flutter/services.dart';

TextInputFormatter metrFormatter =
    FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\,?\d{0,2}'));
