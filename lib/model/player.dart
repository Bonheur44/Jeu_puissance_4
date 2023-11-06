import 'package:flutter/material.dart';

class Player {
  final String name;
  final Color pawnColor;
  int pawnsNumber;

  Player({required this.pawnColor, required this.name, this.pawnsNumber = 21});
}
