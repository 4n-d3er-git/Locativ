import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locative/ui/widgets/customTextFormLable.dart';
import 'package:provider/provider.dart';

import '../../../../provider/userProviders.dart';
import '../../../../services/firestore_methods.dart';
import '../../../widgets/customSnakeBar.dart';
import '../../../widgets/default.dart';
import '../../../widgets/validator.dart';


class Body extends StatefulWidget {
  Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController _userName = TextEditingController();

  final TextEditingController _userPhone = TextEditingController();
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
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Modifiez votre profil ",
                style: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              customTextFieldLable(lableText: 'Prénom', isRequired: true),
              SizedBox(
                height: 8.h,
              ),
              TextFormField(
                autocorrect: true,
                autofocus: true,
                controller: _userName,
                validator: requiredField,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: "${creaditials.fullname}",
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
              customTextFieldLable(lableText: 'Telephone', isRequired: true),
              SizedBox(
                height: 8.h,
              ),
              TextFormField(
                controller: _userPhone,
                validator: requiredField,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: "${creaditials.phoneNo}",
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
                  ? CupertinoActivityIndicator(
                      radius: 25.r,
                      color: Colors.brown,
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
                            lienFacebook: creaditials.lienFacebook??'',
                            name: _userName.text,
                            country: creaditials.country??'',
                            age: creaditials.age??'',
                            phoneNo: _userPhone.text, 
                            address: _userAddress.text,
                            gender: creaditials.gender??'',
                            uid: FirebaseAuth.instance.currentUser!.uid,
                          //  cnic: creaditials.cnic??'',
                            email: creaditials.email??'',
                            lastName: creaditials.lastName??'',
                            profilePic: creaditials.profilePic??'',
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
    );
  }

  OutlineInputBorder customOutlineBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(40),
      borderSide: BorderSide(color: Colors.grey),
    );
  }
}
