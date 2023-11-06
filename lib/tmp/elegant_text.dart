import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Text elegantText(String text, {Color color = Colors.black, TextAlign align = TextAlign.center, double size = 18}) {
  return Text(
    text,
    textAlign: align,
    style: GoogleFonts.poppins(color: color, fontSize: size),
  );
}
