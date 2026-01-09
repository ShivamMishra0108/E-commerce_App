import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

String uri = 'http://192.168.29.49:3000';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}
