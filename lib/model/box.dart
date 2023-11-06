import '../general.dart';
import 'package:flutter/material.dart';

class Box {
  final int xCoordinate;
  final int yCoordinate;
  bool selected = false;
  Color bg = unselectedBoxBg;

  Box({required this.xCoordinate, required this.yCoordinate});
}
