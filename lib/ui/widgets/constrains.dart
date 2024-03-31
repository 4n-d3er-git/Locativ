// Form Error
import 'package:flutter/material.dart';

final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Veuillez entrer votre email";
const String kInvalidEmailError = "Veuillez entrer un email valide";
const String kPassNullError = "Veuillez entrer votre mot de pass";
const String kShortPassError = "Mot de pass trop court";
const String kMatchPassError = "Les mots de pass sont differents";
const String kNamelNullError = "Veuillez entrer votre nom";
const String kPhoneNumberNullError = "Veuillez entrer votre numero de téléphone";
const String kAddressNullError = "Veuillez entrer votre adresse";

InputDecoration otpInputDecoration() {
  return InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 30, horizontal: 14),
    enabledBorder: outlineborder(),
    floatingLabelBehavior: FloatingLabelBehavior.always,
    focusedBorder: outlineborder(),
    border: outlineborder(),
  );
}

OutlineInputBorder outlineborder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: Colors.grey),
    gapPadding: 10,
  );
}
