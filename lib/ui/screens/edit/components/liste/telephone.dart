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
import 'package:info_popup/info_popup.dart';

class Telephone extends StatefulWidget {
  Telephone({
    Key? key,
  }) : super(key: key);

  @override
  State<Telephone> createState() => _TelephoneState();
}

class _TelephoneState extends State<Telephone> {
  // final TextEditingController _userName = TextEditingController();

  final TextEditingController _userPhone = TextEditingController();
  final TextEditingController reseaufacebook = TextEditingController();

  // final TextEditingController _userAddress = TextEditingController();
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
                Row(
                  children: [
                    customTextFieldLable(
                        lableText: 'Facebook', isRequired: true),
                    SizedBox(
                      width: 5.w,
                    ),
                    if (creaditials.lienFacebook == "aucun lien")
                      InfoPopupWidget(
                        contentTitle:"""Veuillez ajouter le lien de votre profil ou page Facebook afin que les autres utilisateurs puissent facilement vous contacter.""",

                        child: Icon(
                          Icons.info,
                          color: Colors.red,
                        ),
                        contentTheme: InfoPopupContentTheme(
                  infoContainerBackgroundColor: Colors.brown.shade400,
                  infoTextStyle: TextStyle(color: Colors.white),
                  contentPadding: const EdgeInsets.all(8),
                  contentBorderRadius: BorderRadius.all(Radius.circular(10)),
                  infoTextAlign: TextAlign.center,
                ),
                      ),
                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
                TextFormField(
                  controller: reseaufacebook,
                  validator: requiredField,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: creaditials.lienFacebook ??
                        "entrez le lien de votre profil/page facebook",
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
                              name: creaditials.fullname ?? '',
                              country: creaditials.country ?? '',
                              age: creaditials.age ?? '',
                              phoneNo: _userPhone.text,
                              address: creaditials.address ?? '',
                              gender: creaditials.gender ?? '',
                              uid: FirebaseAuth.instance.currentUser!.uid,
                              //  cnic: creaditials.cnic??'',
                              email: creaditials.email ?? '',
                              lastName: creaditials.lastName ?? '',
                              profilePic: creaditials.profilePic ?? '',
                              lienFacebook: reseaufacebook.text,
                              estcertifie: creaditials.estcertifie??false,
                              certification: creaditials.certification,
                            );
                            if (res == "success") {
                              showSnakeBar(
                                  "Modification Effectuée avec Succès.",
                                  context);
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
