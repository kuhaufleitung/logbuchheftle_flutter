import 'package:flutter/material.dart';

enum CredentialsType {
  ADDRESS(TextInputType.number, "e.g meinwebserver.de"),
  PORT(TextInputType.number, "e.g 8000"),
  USERNAME(TextInputType.text, "Loginname des Servers"),
  PASSWORD(TextInputType.text, "Passwort des Servers");

  const CredentialsType(this.kbType, this.textHint);
  final TextInputType kbType;
  final String textHint;
}