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




class VilleQuartier extends StatefulWidget {
  VilleQuartier({
    Key? key,
  }) : super(key: key);

  @override
  State<VilleQuartier> createState() => _VilleQuartierState();
}

class _VilleQuartierState extends State<VilleQuartier> {
  // final TextEditingController _userName = TextEditingController();

  final TextEditingController _villee = TextEditingController();
  final TextEditingController _userAddress = TextEditingController();
 // final TextEditingController _userGender = TextEditingController();
 // final TextEditingController _userAge = TextEditingController();
 // final TextEditingController _userCountry = TextEditingController();

  bool isChecked = false;
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var creaditials = Provider.of<UserProviders>(context).getUser;
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
                customTextFieldLable(lableText: 'Ville', isRequired: true),
                SizedBox(
                  height: 8.h,
                ),
                TextFormField(
                  autocorrect: true,
                  autofocus: true,
                  controller: _villee,
                  validator: requiredField,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: "${creaditials.country}",
                    contentPadding: EdgeInsets.fromLTRB(20.w, 0, 0, 0),
                    enabledBorder: customOutlineBorder(),
                    focusedBorder: customOutlineBorder(),
                    border: customOutlineBorder(),
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                customTextFieldLable(lableText: 'Quartier/Commune', isRequired: true),
                SizedBox(
                  height: 8.h,
                ),
                TextFormField(
                  controller: _userAddress,
                  validator: requiredField,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: "${creaditials.address}",
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
                            setState(() {
                              loading = true;
                            });
      
                            var res = await FirestoreMethods().updateUserData(
                              name: creaditials.fullname??'',
                              country: _villee.text,
                              age: creaditials.age??'',
                              phoneNo: creaditials.phoneNo??'', 
                              address: _userAddress.text,
                              gender: creaditials.gender??'',
                              uid: FirebaseAuth.instance.currentUser!.uid,
                            //  cnic: creaditials.cnic??'',
                              email: creaditials.email??'',
                              lastName: creaditials.lastName??'',
                              profilePic: creaditials.profilePic??'',
                              lienFacebook: creaditials.lienFacebook??'',
                              estcertifie: creaditials.estcertifie??false,
                              certification: creaditials.certification,
                            );
                            if (res == "success") {
                              showSnakeBar(
                                  "Modification Effectuée avec Succès.", context);
                              setState(() {
                                loading = false;
                              });
                            } else {
                              setState(() {
                                loading = false;
                              });
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
