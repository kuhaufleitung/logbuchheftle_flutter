import 'package:flutter/material.dart';

enum CredentialsType {
  ADDRESS(TextInputType.text, false, "e.g meinwebserver.de"),
  PORT(TextInputType.number, false, "e.g 8000"),
  USERNAME(TextInputType.text, false, "Loginname des Servers"),
  PASSWORD(TextInputType.text, true, "Passwort des Servers");

  const CredentialsType(this.kbType, this.hiddenChars, this.textHint);
  final TextInputType kbType;
  final bool hiddenChars;
  final String textHint;
}