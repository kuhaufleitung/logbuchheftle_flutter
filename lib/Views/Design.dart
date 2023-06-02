import 'package:flutter/material.dart';

class Design {
  static ShaderMask yearStyle(String input) {
    return ShaderMask(
        shaderCallback: (bounds) => const LinearGradient(
                colors: [Colors.indigo, Colors.blue], tileMode: TileMode.mirror)
            .createShader(bounds),
        blendMode: BlendMode.srcIn,
        child: Text(input,
            style: const TextStyle(fontSize: 80, fontWeight: FontWeight.bold)));
  }

  static ShaderMask monthStyle(String input) {
    return ShaderMask(
        shaderCallback: (bounds) => const LinearGradient(
                colors: [Colors.grey, Colors.white], tileMode: TileMode.mirror)
            .createShader(bounds),
        blendMode: BlendMode.srcIn,
        child: Text(input,
            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)));
  }

  static TextStyle defaultSettingsViewFont(int size, BuildContext context) {
    return TextStyle(
        color: Colors.white,
        fontSize: size * MediaQuery.of(context).textScaleFactor);
  }

  static TextStyle defaultSummaryViewBoldStyle() {
    return const TextStyle(
        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14);
  }

  static TextStyle defaultSummaryViewStyle() {
    return const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.normal,
        height: 0,
        fontSize: 14);
  }

  static TextStyle defaultDetailsViewStyle() {
    return const TextStyle(color: Colors.white, fontSize: 20.0);
  }

  static TextStyle defaultDetailsViewBoldStyle() {
    return const TextStyle(
        color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold);
  }

  static BoxDecoration singleFlightBox() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        gradient: const RadialGradient(
            center: FractionalOffset(0.2, 3),
            radius: 4,
            stops: [0.6, 1],
            colors: [Colors.indigo, Colors.blue]));
  }
}
