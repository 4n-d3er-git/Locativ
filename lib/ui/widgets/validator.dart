import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

final requiredField = MultiValidator([
  RequiredValidator(errorText: 'ce champ est réquis'),
]);
final emailValidator = MultiValidator([
  RequiredValidator(errorText: 'email est requis'),
  EmailValidator(errorText: 'veuillez entrer une addresse email valide'),
]);

final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'mot de pass est réquis'),
  MinLengthValidator(8, errorText: 'le mot de pass doit contenir au moins 8 caractères'),
  
]);
final numberValidator = MultiValidator([
  RequiredValidator(errorText: 'numero réquis'),
  MinLengthValidator(9,
    errorText: 'le numéro de téléphone doit être de 9 chiffres',
  ),
  PatternValidator(
    r'(^(?:[+0]6)?[0-9]{9,15}$)',
    errorText: 'numéro de téléphone invalide.',
  )
]);
final cnicValidator = MultiValidator([
  RequiredValidator(errorText: 'Cnic is required'),
  MinLengthValidator(
    10,
    errorText: 'CNIC Number must be 13 digits long',
  ),
  PatternValidator(
    r'(^(?:[+0]9)?[0-9]{10,12}$)',
    errorText: 'CNIC Number is not valid.',
  )
]);
