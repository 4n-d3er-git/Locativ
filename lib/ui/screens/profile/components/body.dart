import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_picker/image_picker.dart';
import 'package:locative/ad_helper/ad_helper.dart';
import 'package:locative/services/storage_methods.dart';
import 'package:locative/ui/screens/aides/aides.dart';
import 'package:locative/ui/screens/edit/components/liste_modif.dart';
import 'package:locative/ui/screens/profile/components/mes_posts.dart';
import 'package:locative/ui/screens/profile/profile.dart';
import 'package:locative/ui/screens/signinscreen/signin.dart';
import 'package:locative/ui/widgets/customSnakeBar.dart';
import 'package:locative/ui/widgets/default.dart';
import 'package:locative/ui/widgets/imagepicker.dart';
import 'package:photo_view/photo_view.dart';

import 'package:provider/provider.dart';
import '../../../../models/users.dart';
import '../../../../provider/userProviders.dart';
import '../../../../services/firebase_auth_methods.dart';
import '../../edit/editProfile.dart';
import '../../signupscreen/signup.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }

  late BannerAd _bannerAd2;
  bool _isBannerAdReady2 = false;

  InterstitialAd? interstitialAd;
  bool isInterstitialAdLoaded = false;

  void loadInterstitial() {
    InterstitialAd.load(
      adUnitId:
          // "ca-app-pub-7229654893754092/8002622210",
          //test
          "ca-app-pub-3940256099942544/1033173712",
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          print("InterstitialAd Loaded");
          setState(() {
            interstitialAd = ad;
            isInterstitialAdLoaded = true;
          });
        },
        onAdFailedToLoad: (error) {
          print("InterstitialAd Failed to Load");
        },
      ),
    );
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    loadInterstitial();
  }

  @override
  void initState() {
    super.initState();
    // Load ads.
    print('initstate called');
    MobileAds.instance.initialize();

    _bannerAd2 = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady2 = true;
            print('banner 2 loaded');
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady2 = false;
          ad.dispose();
        },
      ),
    );
    _bannerAd2.load();
  }

  @override
  Widget build(BuildContext context) {
    var creaditials = Provider.of<UserProviders>(context).getUser;

    UserCreaditials userCreaditials =
        Provider.of<UserProviders>(context).getUser;
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 10.w, right: 16.w, top: 8.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Profil",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // Container(
                  //   width: 34.w,
                  //   height: 44.h,
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(4.r),
                  //       color: Colors.green.withOpacity(0.04)),
                  //   child: const Icon(
                  //     Icons.settings,
                  //     color: Colors.green,
                  //   ),
                  // ),
                ],
              ),
              SizedBox(
                height: 24.h,
              ),
              Row(
                children: [
                  GestureDetector(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        userCreaditials.profilePic == null
                            ? SizedBox()
                            : CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                    NetworkImage(userCreaditials.profilePic!),
                              ),
                        Positioned(
                          bottom: -4,
                          right: -1,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Icon(
                              CupertinoIcons.camera_fill,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (BuildContext context) => CupertinoActionSheet(
                            title: Text("Choisissez une option"),
                            actions: [
                              CupertinoActionSheetAction(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ImageZooom(
                                          texte: userCreaditials.lastName! +
                                              " " +
                                              userCreaditials.fullname!,
                                          image: userCreaditials.profilePic!,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Voir la photo de profil",
                                    style: TextStyle(color: Colors.black),
                                  )),
                              CupertinoActionSheetAction(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ChangrPhotoDeProfil()));
                                  },
                                  child: Text(
                                    "Changer la photo de profil",
                                    style: TextStyle(color: Colors.black),
                                  )),
                            ]),
                      );
                    },
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            userCreaditials.fullname ?? '',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 21.sp,
                              fontFamily: "arial",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          userCreaditials.afficherIconeCertification(),
                        ],
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        userCreaditials.email ?? '',
                        style: TextStyle(fontSize: 13),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.green[900],
                            size: 18,
                          ),
                          Text(userCreaditials.country ?? ''),
                          SizedBox(
                            width: 18,
                          ),
                          Icon(
                            Icons.phone,
                            color: Colors.green[900],
                            size: 18,
                          ),
                          Text(userCreaditials.phoneNo ?? ''),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 16.h,
              ),
              const Divider(),
              if (_isBannerAdReady2)
                showBannerAds(
                    height: _bannerAd2.size.height.toDouble(),
                    width: _bannerAd2.size.width.toDouble(),
                    bannerAd: _bannerAd2),
              SizedBox(
                height: 24.h,
              ),
               //?-----------------------
          creaditials.lienFacebook == "aucun lien" ?
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ListeModifications(),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 14.h),
                child: ListTile(
                  leading: Container(
                    width: 54.w,
                    height: 54.h,
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.04),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.info,
                      color: Colors.red,
                    ),
                  ),
                  title: Text(
                    "Modifier le Profil",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.red,
                  ),
                ),
              ),
            ):
              customListTIle(
                press: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ListeModifications(),
                    ),
                  );
                },
                leading: Icons.person,
                text: "Modifier le Profil",
                trailing: Icons.arrow_forward_ios_outlined,
              ),
              const Divider(),
              customListTIle(
                press: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MesLocations(),
                    ),
                  );
                },
                leading: Icons.publish,
                text: "Mes Mises en Location", 
                trailing: Icons.arrow_forward_ios_outlined,
              ),
              const Divider(),
              customListTIle(
                press: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Aides(),
                    ),
                  );
                },
                leading: Icons.help,
                text: "Centre D'aides", 
                trailing: Icons.arrow_forward_ios_outlined,
              ),
              

              const Divider(),
              const Divider(),
              customListTIle(
                press: () {
                  showCupertinoDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                      title: Text('Déconnexion ?'),
                      content: Text('Voulez-vous vous déconnecter ?'),
                      actions: [
                        CupertinoDialogAction(
                          child: Text(
                            'Oui',
                            style: TextStyle(color: Colors.red),
                          ),
                          onPressed: () {
                            FirebaseAuthMethods().signOut();
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => Signin(),
                              ),
                            );
                          },
                        ),
                        CupertinoDialogAction(
                          child: Text(
                            'Non',
                            style: TextStyle(color: Colors.brown),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  );
                  // FirebaseAuthMethods().signOut();
                  // Navigator.of(context).pushReplacement(
                  //   MaterialPageRoute(
                  //     builder: (context) => Signin(),
                  //   ),
                  // );
                },
                leading: Icons.logout,
                text: "Déconnexion",
                trailing: null,
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }

  Widget customListTIle({
    required IconData leading,
    required String text,
    required IconData? trailing,
    required VoidCallback press,
  }) {
    return InkWell(
      onTap: press,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 14.h),
        child: ListTile(
          leading: Container(
            width: 54.w,
            height: 54.h,
            decoration: BoxDecoration(
              color: text == "Déconnexion"
                  ? Colors.red[300]
                  : Colors.brown.withOpacity(0.04),
              shape: BoxShape.circle,
            ),
            child: Icon(
              leading,
              color: text == "Déconnexion" ? Colors.white : Colors.brown,
            ),
          ),
          title: Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
            ),
          ),
          trailing: Icon(
            trailing,
            color: Colors.brown,
          ),
        ),
      ),
    );
  }
}

class showBannerAds extends StatelessWidget {
  final double width;
  final double height;
  final BannerAd bannerAd;

  const showBannerAds(
      {Key? key,
      required this.width,
      required this.height,
      required this.bannerAd})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: width,
        height: height,
        child: AdWidget(ad: bannerAd),
      ),
    );
  }
}

class ImageZooom extends StatelessWidget {
  final String? image;
  final String? texte;

  const ImageZooom({super.key, this.image, this.texte});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => PostDetailedPage(),
            //   ),
            // );
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.brown,
          ),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          texte!,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
          ),
        ),
      ),
      body: Center(
        child: PhotoView(
          imageProvider: NetworkImage(image!),
        ),
      ),
    );
  }
}

class ChangrPhotoDeProfil extends StatefulWidget {
  const ChangrPhotoDeProfil({super.key});

  @override
  State<ChangrPhotoDeProfil> createState() => _ChangrPhotoDeProfilState();
}

class _ChangrPhotoDeProfilState extends State<ChangrPhotoDeProfil> {
  // bool isLoading = false;
  // Uint8List? _imageURL;
  // selectedImage() async {
  //   Uint8List imageURL = await pickImage(
  //     ImageSource.gallery,
  //   );
  //   setState(() {
  //     _imageURL = imageURL;
  //   });
  // }
  File? _imageFile;
  bool isLoading = false;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _updateProfilePicture() async {
    if (_imageFile != null) {
      setState(() {
        isLoading = true;
      });
      try {
        // Upload the image to Firebase Storage
        final ref = FirebaseStorage.instance.ref().child(
            'profile_pictures/${FirebaseAuth.instance.currentUser!.uid}.jpg');
        await ref.putFile(_imageFile!);

        // Get the download URL of the uploaded image
        final downloadURL = await ref.getDownloadURL();

        // Update Firestore document with the image URL
        await FirebaseFirestore.instance
            .collection('utilisateurs')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          'profilPhoto': downloadURL,
        });

        
      } catch (e) {
        showSnakeBar(
            "Désolé la photo de profil n'a pas pu être changée, veuillez récommencer",
            context);
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.brown,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Changer votre photo de profil",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
          ),
        ),
      ),
      body: ListView(
        children: [
          Center(
            child: InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: () => _pickImage(),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    child: _imageFile != null
                        ? CircleAvatar(
                            key: UniqueKey(),
                            backgroundImage: Image.file(_imageFile!).image,
                            // _imageFile! as ImageProvider,
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
          ),
          SizedBox(
            height: 50.h,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: isLoading
                ? Center(
                    child: CupertinoActivityIndicator(
                      color: Colors.brown,
                    ),
                  )
                : defaultButton(
                    text: "Mettre à jour",
                    press: () async {
                      if (_imageFile == null) {
                        showSnakeBar(
                            "Vous devez ajouter une photo de profil", context);
                      } else {
                        showSnakeBar(
                            "Photo de profil Changée avec succès", context);
                        _updateProfilePicture();
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
                      }
                    }),
          )
        ],
      ),
    );
  }
}





// class ChangrPhotoDeProfi extends StatefulWidget {
//   @override
//   _ChangrPhotoDeProfiState createState() => _ChangrPhotoDeProfiState();
// }

// class _ChangrPhotoDeProfiState extends State<ChangrPhotoDeProfil> {
//   File? _imageFile;
//   bool _isUploading = false;

//   Future<void> _pickImage() async {
//     final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path);
//       });
//     }
//   }

//   Future<void> _updateProfilePicture() async {
//     if (_imageFile != null) {
//       setState(() {
//         _isUploading = true;
//       });
//       try {
//         // Upload the image to Firebase Storage
//         final ref = FirebaseStorage.instance.ref().child('profile_pictures/${FirebaseAuth.instance.currentUser!.uid}.jpg');
//         await ref.putFile(_imageFile!);

//         // Get the download URL of the uploaded image
//         final downloadURL = await ref.getDownloadURL();

//         // Update Firestore document with the image URL
//         await FirebaseFirestore.instance.collection('utilisateurs').doc(FirebaseAuth.instance.currentUser!.uid).update({
//           'profilPhoto': downloadURL,
//         });

//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile picture updated successfully in Firestore')));
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error updating profile picture in Firestore: $e')));
//       } finally {
//         setState(() {
//           _isUploading = false;
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile Picture Upload'),
//       ),
//       body: Center(
//         child: ListView(
//           children: [
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 if (_imageFile != null)
//                   Image.file(_imageFile!),
//                 SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: _pickImage,
//                   child: Text('Pick Image'),
//                 ),
//                 SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: _updateProfilePicture,
//                   child: Text('Update Profile Picture'),
//                   style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.all<Color>(_isUploading ? Colors.grey : Colors.blue),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }