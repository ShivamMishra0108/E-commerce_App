import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

String uri = 'http://10.238.254.20:3000';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}
