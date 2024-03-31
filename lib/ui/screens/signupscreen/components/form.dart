import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../services/firebase_auth_methods.dart';
import '../../../widgets/customSnakeBar.dart';
import '../../../widgets/customTextFormLable.dart';
import '../../../widgets/default.dart';
import '../../../widgets/inputDecoration.dart';
import '../../../widgets/validator.dart';
import '../../completeProfile/completeProfile.dart';
import '../../feed/feedScreen.dart';

class SignFormFields extends StatefulWidget {
  const SignFormFields({Key? key}) : super(key: key);

  @override
  State<SignFormFields> createState() => _FormFieldsState();
}

class _FormFieldsState extends State<SignFormFields> {
  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _userPasswordController = TextEditingController();
  TextEditingController _userConfirmPasswordController =
      TextEditingController();
  bool isObscure = true;
  bool isCObscure = true;
  bool isChecked = true;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    _userEmailController.dispose();
    _userPasswordController.dispose();
    _userConfirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    signsubmitForm() async {
      setState(() {
        isLoading = true;
      });
      String res = await FirebaseAuthMethods().createUser(
        email: _userEmailController.text,
        password: _userPasswordController.text,
        context: context,
      );
      // Vérifiez la valeur retournée par la fonction createUser
      if (res == "success") {
        // Le compte a été créé avec succès, passez à l'écran suivant
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CompleteProfle(),
          ),
        );
      } else {
        // Affichez un message d'erreur approprié (par exemple, compte déjà existant)
        // Vous pouvez également ne rien faire ici si vous ne souhaitez pas passer à l'écran suivant en cas d'échec
        setState(() {
          isLoading = false;
        });
      }

      //? Navigator.of(context).push(
      //     MaterialPageRoute(
      //       builder: (context) => CompleteProfle(),
      //     ));
      // if (res == 'success') {
      //   setState(() {
      //     isLoading = false;
      //   });
      //   Navigator.of(context).push(
      //     MaterialPageRoute(
      //       builder: (context) => CompleteProfle(),
      //     ),
      //   );
      //   showSnakeBar("Verifiez votre boît mail", context);
      // } else {
      //   setState(() {
      //     isLoading = false;
      //   });
      //   showSnakeBar(res, context);
      // }
    }

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customTextFieldLable(
            lableText: "Email",
            isRequired: true,
          ),
          SizedBox(
            height: 8.h,
          ),
          TextFormField(
            controller: _userEmailController,
            validator: emailValidator,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: customInputDecoration(
              suffixIcon: null,
              hintText: "entrez votre adresse email ici",
              press: () {},
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          customTextFieldLable(isRequired: true, lableText: "Mot de Pass"),
          SizedBox(
            height: 8.h,
          ),
          TextFormField(
            controller: _userPasswordController,
            validator: passwordValidator,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.next,
            obscureText: isObscure,
            decoration: customInputDecoration(
                suffixIcon: Icons.remove_red_eye,
                hintText: "entrez un mot de pass ici",
                press: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                }),
          ),
          SizedBox(
            height: 8.h,
          ),
          customTextFieldLable(
              isRequired: true, lableText: "confirmez le mot de pass"),
          SizedBox(
            height: 8.h,
          ),
          TextFormField(
            controller: _userConfirmPasswordController,
            validator: passwordValidator,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.next,
            obscureText: isCObscure,
            decoration: customInputDecoration(
                suffixIcon: Icons.remove_red_eye,
                hintText: "confirmez le mot de pass ici",
                press: () {
                  setState(() {
                    isCObscure = !isCObscure;
                  });
                }),
          ),
          // Row(
          //   children: [
          //     Checkbox(
          //       value: isChecked,
          //       onChanged: (value) {
          //         setState(() {
          //           isChecked = !isChecked;
          //         });
          //       },
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(5.r),
          //       ),
          //       side: BorderSide(
          //         color: Colors.blue,
          //       ),
          //     ),
          //     SizedBox(
          //       width: 8.w,
          //     ),
          //     Text(
          //       "Se souvenir de moi",
          //       style: TextStyle(
          //         fontWeight: FontWeight.w500,
          //       ),
          //     ),
          //   ],
          // ),
          SizedBox(
            height: 18.h,
          ),
          isLoading
              ? Center(
                  child: CupertinoActivityIndicator(
                    color: Colors.brown,
                  ),
                )
              : AnimatedContainer(
                  duration: Duration(milliseconds: 600),
                  curve: Curves.bounceIn,
                  child: defaultButton(
                      text: "Créer un Compte",
                      press: () {
                        // if (!_formKey.currentState!.validate()) {
                        //   // Les champs du formulaire ne sont pas valides, ne faites rien
                        // } else {
                        //   // Les champs du formulaire sont valides, vérifions si le mot de passe est égal à la confirmation du mot de passe
                        //   if (_userPasswordController.text !=
                        //       _userConfirmPasswordController.text) {
                        //     // Affichez un message d'erreur car les mots de passe ne correspondent pas
                        //     showSnakeBar(
                        //         "Les mots de passe ne correspondent pas",
                        //         context);
                        //   } else {
                        //     // Les mots de passe correspondent, soumettez le formulaire
                        //     Navigator.push(context, MaterialPageRoute(builder: (context)=>CompleteProfle()));
                        //   }
                        // }

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CompleteProfle()));
                      }),
                ),
        ],
      ),
    );
  }
}
