import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:recipes_app/screens/main.dart';

void main() {
  final Client client = Client();
  runApp(App(client: client));
}
