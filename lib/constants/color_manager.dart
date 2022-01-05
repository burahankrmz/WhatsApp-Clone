import 'package:flutter/material.dart';

class ColorManager {
  //static Color tealGreen = HexColor.fromHex('#ED9728');
  static Color tealGreen = HexColor.fromHex("#128C7E");
  static Color tealGreenDark = HexColor.fromHex('#075E54');
  static Color lightGreen = HexColor.fromHex("#25D366");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color chatBuuble = HexColor.fromHex("#DCF8C6");
  static Color checkMarkBlue = HexColor.fromHex("#34B7F1");
  static Color chatBackground = HexColor.fromHex("#ECE5DD");
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = 'FF' + hexColorString;
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
