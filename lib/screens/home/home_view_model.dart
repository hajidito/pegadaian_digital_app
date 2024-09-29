import 'package:flutter/material.dart';
import './home.dart';

abstract class HomeViewModel extends State<Home> {
  int counter = 0;

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }
}
