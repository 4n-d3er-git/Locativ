import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locative/provider/userProviders.dart';
import 'package:locative/services/firestore_methods.dart';
import 'package:locative/ui/widgets/customSnakeBar.dart';
import 'package:locative/ui/widgets/customTextFormLable.dart';
import 'package:locative/ui/widgets/default.dart';
import 'package:locative/ui/widgets/validator.dart';
import 'package:provider/provider.dart';




class MotDePass extends StatefulWidget {
  MotDePass({
    Key? key,
  }) : super(key: key);

  @override
  State<MotDePass> createState() => _MotDePassState();
}

class _MotDePassState extends State<MotDePass> {
  final TextEditingController ancienmotdepass = TextEditingController();

  final TextEditingController nouveaumotdepass = TextEditingController();
  final TextEditingController renouveaumotdepass = TextEditingController();
 // final TextEditingController _userGender = TextEditingController();
 // final TextEditingController _userAge = TextEditingController();
 // final TextEditingController _userCountry = TextEditingController();

  bool isChecked = false;
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var creaditials = Provider.of<UserProviders>(context).getUser;

Future<void> _changePassword() async {
  try {
    await FirebaseAuth.instance.currentUser!.updatePassword(nouveaumotdepass.text);
    showSnakeBar("Mot de passe modifié avec succès", context);
    loading = false;
  } on FirebaseAuthException catch (e) {
    showSnakeBar(e.message!, context);
  }
  setState(() {
    loading = false;
  });
}

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Modifier le Profil',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20.sp,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                SizedBox(
                  height: 24.h,
                ),
                customTextFieldLable(lableText: 'Mot de pass actuel', isRequired: true),
                SizedBox(
                  height: 8.h,
                ),
                TextFormField(
                  autocorrect: true,
                  autofocus: true,
                  controller: ancienmotdepass,
                  validator: requiredField,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: "veuillez saisir votre mot de pass actuel",
                    contentPadding: EdgeInsets.fromLTRB(20.w, 0, 0, 0),
                    enabledBorder: customOutlineBorder(),
                    focusedBorder: customOutlineBorder(),
                    border: customOutlineBorder(),
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                customTextFieldLable(lableText: 'Nouveau mot de pass', isRequired: true),
                SizedBox(
                  height: 8.h,
                ),
                TextFormField(
                  controller: nouveaumotdepass,
                  validator: requiredField,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: "veuillez entrer un nouveau mot de pass",
                    contentPadding: EdgeInsets.fromLTRB(20.w, 0, 0, 0),
                    enabledBorder: customOutlineBorder(),
                    focusedBorder: customOutlineBorder(),
                    border: customOutlineBorder(),
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                customTextFieldLable(lableText: 'Confirmation', isRequired: true),
                SizedBox(
                  height: 8.h,
                ),
                TextFormField(
                  controller: renouveaumotdepass,
                  validator: requiredField,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: "veuillez re-entrer votre nouveau mot de pass",
                    contentPadding: EdgeInsets.fromLTRB(20.w, 0, 0, 0),
                    enabledBorder: customOutlineBorder(),
                    focusedBorder: customOutlineBorder(),
                    border: customOutlineBorder(),
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                
                SizedBox(
                  height: 25.h,
                ),
                loading
                    ? Center(
                      child: CupertinoActivityIndicator(
                          radius: 25.r,
                          color: Colors.brown,
                        ),
                    )
                    : defaultButton(
                        text: "Sauvegarder",
                        press: () async {
                          if (!_formKey.currentState!.validate()) {
                            // If the form is not valid, display a snackbar. In the real world,
      
                          } else {
                            if (nouveaumotdepass.text !=
                          renouveaumotdepass.text) {
                        // Affichez un message d'erreur car les mots de passe ne correspondent pas
                        showSnakeBar(
                            "Les mots de passe ne correspondent pas", context);
                        
                      }else{
                            setState(() {
                              loading = true;
                            });
                            _changePassword();
                            }
      
                          
                          }
                        })
              ],
            ),
          ),
        ),
      ),
    );
    
  }

  OutlineInputBorder customOutlineBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(40),
      borderSide: BorderSide(color: Colors.grey),
    );
  }

}
