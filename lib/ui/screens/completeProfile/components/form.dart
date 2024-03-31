import 'dart:typed_data';
import '../../../screens/feed/feedScreen.dart';
import '../../../widgets/imagepicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../services/firebase_auth_methods.dart';
import '../../../widgets/customSnakeBar.dart';
import '../../../widgets/customTextFormLable.dart';
import '../../../widgets/default.dart';
import '../../../widgets/inputDecoration.dart';
import '../../../widgets/validator.dart';

class form extends StatefulWidget {
  const form({
    Key? key,
  }) : super(key: key);

  @override
  State<form> createState() => _formState();
}

class _formState extends State<form> {
  TextEditingController _userFirstNameController = TextEditingController();
  TextEditingController _userLastNameController = TextEditingController();

  TextEditingController _userPhoneNumberController = TextEditingController();
  TextEditingController _userAddressController = TextEditingController();
  TextEditingController _userCNICController = TextEditingController();
  //!
  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _userPasswordController = TextEditingController();
  TextEditingController _userConfirmPasswordController =
      TextEditingController();
  bool isObscure = true;
  bool isCObscure = true;
  bool isChecked = true;
  //!FIN
  @override
  void dispose() {
    super.dispose();
    _userEmailController.dispose();
    _userPasswordController.dispose();
    _userConfirmPasswordController.dispose();
    _userFirstNameController.dispose();
    _userLastNameController.dispose();

    _userPhoneNumberController.dispose();
    _userAddressController.dispose();
    _userCNICController.dispose();
  }

  Uint8List? _imageURL;
  selectedImage() async {
    Uint8List imageURL = await pickImage(
      ImageSource.gallery,
    );
    setState(() {
      _imageURL = imageURL;
    });
  }

  final _formKey = GlobalKey<FormState>();
  String _genderMale = "homme";
  double _age = 0;

  var countries = [
    "Conakry",
    "Beyla",
    "Boffa",
    "Boké",
    "Coyah",
    "Dabola",
    "Dalaba",
    "Dinguiraye",
    "Dubreka",
    "Faranah",
    "Forecariah",
    "Fria",
    "Gaoual",
    "Gueckedou",
    "Kamsar",
    "KanKan",
    "Kerouane",
    "Kindia",
    "Kissidougou",
    "Koubia",
    "Koundara",
    "Kouroussa",
    "Labé",
    "Lélouma",
    "Lola",
    "Macenta",
    "Mali",
    "Mamou",
    "Mandiana",
    "N'Zerekore",
    "Siguiri",
    "Télimélé",
    "Tougué",
    "Yomou"
  ];
  String? selectedCountry = "Conakry";
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    submitForm() async {
      setState(() {
        isLoading = true;
      });
      String res = await FirebaseAuthMethods().completeProfile(
        profilePic: _imageURL!,
        fullname: _userFirstNameController.text,
        lastName: _userLastNameController.text,
        phoneNumber: _userPhoneNumberController.text,
        address: _userAddressController.text,
        country: selectedCountry.toString(),
        age: _age.toString(),
        gender: _genderMale.toString(),
        context: context, estcertifie: false,
      );
      if (res == 'success') {
        setState(() {
          isLoading = false;
        });
        showSnakeBar("Compte créé avec succès.\nBienvenu dans Locative", context);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => FeedScreen(),
          ),
        );
      }
    }

    //!
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
      } else {
        // Affichez un message d'erreur approprié (par exemple, compte déjà existant)
        // Vous pouvez également ne rien faire ici si vous ne souhaitez pas passer à l'écran suivant en cas d'échec
        setState(() {
          isLoading = false;
        });
      }
    }
    //!

    return Form(
      key: _formKey,
      child: Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () => selectedImage(),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  child: _imageURL != null
                      ? CircleAvatar(
                          key: UniqueKey(),
                          backgroundImage: MemoryImage(
                            _imageURL!,
                          ),
                          backgroundColor: Colors.white.withOpacity(0.13),
                          radius: 50,
                        )
                      : Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(style: BorderStyle.solid)),
                          child: CircleAvatar(
                            key: UniqueKey(),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text("Photo de Profil"),
                            ),
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            radius: 50,
                          ),
                        ),
                ),
                Positioned(
                  bottom: -5,
                  right: -3,
                  child: Container(
                    padding: EdgeInsets.all(9),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Icon(CupertinoIcons.camera_fill),
                  ),
                ),
              ],
            ),
          ),
          // end of teh imamge
          // !SignFormFields(),
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
                suffixIcon: isObscure ? Icons.visibility : Icons.visibility_off,
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
                suffixIcon: isObscure ? Icons.visibility : Icons.visibility_off,
                hintText: "confirmez le mot de pass ici",
                press: () {
                  setState(() {
                    isCObscure = !isCObscure;
                  });
                }),
          ),
          //!FIN
          SizedBox(height: 24.h),
          customTextFieldLable(
            isRequired: true,
            lableText: "Prenom",
          ),
          SizedBox(
            height: 8.h,
          ),
          TextFormField(
            controller: _userFirstNameController,
            validator: requiredField,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            decoration: customInputDecoration(
              suffixIcon: null,
              hintText: "entrez votre prenom ici",
              press: () {},
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          customTextFieldLable(
            isRequired: true,
            lableText: "Nom",
          ),
          SizedBox(
            height: 8.h,
          ),
          TextFormField(
            controller: _userLastNameController,
            validator: requiredField,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            decoration: customInputDecoration(
              suffixIcon: null,
              hintText: "entrez votre nom ici",
              press: () {},
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          SizedBox(
            height: 8.h,
          ),
          customTextFieldLable(
              isRequired: true, lableText: "Numero de Téléphone"),
          SizedBox(
            height: 8.h,
          ),
          TextFormField(
            controller: _userPhoneNumberController,
            validator: numberValidator,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            decoration: customInputDecoration(
              suffixIcon: null,
              hintText: "entrez votre numero de téléphone ici",
              press: () {},
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          customTextFieldLable(
            isRequired: true,
            lableText: "Quartier/Commune",
          ),
          SizedBox(
            height: 8.h,
          ),
          TextFormField(
            controller: _userAddressController,
            validator: requiredField,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            decoration: customInputDecoration(
              suffixIcon: null,
              hintText: "entrez votre adresse",
              press: () {},
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          customTextFieldLable(
            lableText: "ville",
            isRequired: true,
          ),
          SizedBox(
            height: 8.h,
          ),
          DropdownButtonFormField(
            items: countries.map((String category) {
              return DropdownMenuItem(
                  value: category,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                    child: Row(
                      children: <Widget>[
                        Text(category),
                      ],
                    ),
                  ));
            }).toList(),
            onChanged: (String? newValue) {
              // do other stuff with _category
              setState(() => selectedCountry = newValue!);
            },
            value: selectedCountry,
            decoration: customInputDecoration(
              suffixIcon: Icons.location_city,
              hintText: "",
              press: () {},
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          // customTextFieldLable(
          //   isRequired: true,
          //   lableText: "Age",
          // ),
          // Slider(
          //   value: _age,
          //   min: 0.0,
          //   max: 100.0,
          //   divisions: 100,
          //   label: '${_age.round()}',
          //   onChanged: (double value) {
          //     setState(() {
          //       _age = value;
          //     });
          //   },
          // ),
          SizedBox(
            height: 8.h,
          ),
          customTextFieldLable(lableText: "Genre", isRequired: true),
          SizedBox(
            height: 8.h,
          ),
          Row(
            children: [
              Radio(
                autofocus: true,
                value: "homme",
                groupValue: _genderMale,
                onChanged: (String? value) {
                  setState(() {
                    _genderMale = value!;
                  });
                },
              ),
              SizedBox(
                width: 3.w,
              ),
              Text(
                "Masculin",
              ),
              SizedBox(
                width: 8.h,
              ),
              Radio(
                value: "femme",
                groupValue: _genderMale,
                onChanged: (String? value) {
                  setState(() {
                    _genderMale = value!;
                  });
                },
              ),
              SizedBox(
                width: 3.h,
              ),
              Text("Feminin"),
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          isLoading
              ? Center(
                  child: CupertinoActivityIndicator(
                    color: Colors.brown,
                  ),
                )
              : defaultButton(
                  text: "Enregistrer",
                  press: () {
                    if (!_formKey.currentState!.validate()) {
                      // If the form is not valid, display a snackbar. In the real world,

                      // Les champs du formulaire ne sont pas valides, ne faites rien
                    } else {
                      // Les champs du formulaire sont valides, vérifions si le mot de passe est égal à la confirmation du mot de passe
                      if (_userPasswordController.text !=
                          _userConfirmPasswordController.text) {
                        // Affichez un message d'erreur car les mots de passe ne correspondent pas
                        showSnakeBar(
                            "Les mots de passe ne correspondent pas", context);
                        
                      } else if (_imageURL == null) {
                          showSnakeBar("Vous devez ajouter une photo de profil",
                              context);
                        }
                      
                      else {
                        signsubmitForm();
                        submitForm();
                      }
                    }
                  }),
        ],
      ),
    );

  }
  
}
