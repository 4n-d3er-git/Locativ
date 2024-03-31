import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:locative/ui/widgets/customOutlineBorder.dart';
import 'package:locative/ui/widgets/customTextFormLable.dart';
import 'package:provider/provider.dart';

import '../../../../models/users.dart';
import '../../../../provider/userProviders.dart';
import '../../../../services/firestore_methods.dart';
import '../../../widgets/customSnakeBar.dart';
import '../../../widgets/default.dart';
import '../../../widgets/imagepicker.dart';
import '../../../widgets/validator.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart'; // Assurez-vous d'importer le package nécessaire.
import 'package:locative/ad_helper/ad_helper.dart';
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


  TextEditingController _userTitleController = TextEditingController();
  TextEditingController _userLocationController = TextEditingController();
  TextEditingController _userOverViewController = TextEditingController();
  TextEditingController _userPriceController = TextEditingController();
  
  final _formKey = GlobalKey<FormState>();

  double priceRangeValue = 0;
  RangeValues _currentRangeValues = const RangeValues(0, 100000);

  Uint8List? _file;

  bool _isloading = false;

// for adding post
  String _houseType = "immobilier";

  void addPost( 
      {
        
        required String profilePic,
        required final uid,
      required final userName,
      required final lastName,
      required final contactNumber,
      required final email,
      required bool estcertifie,
      required String certification,
      // required DateTime membre, 
      required String lienFacebook,  required String address,
      required int vue,
      required String country,
      required String gender,
      }) async {
    setState(() {
      _isloading = true;
    });
    try {
      String res = await FirestoreMethods().uploadPost(
          // houseStatus: _houseStatus,
          houseType: _houseType,
          file: _file!,
          title: _userTitleController.text,
          uid: uid,
          username: userName,
          lastName: lastName,
          location: _userLocationController.text,
          // beds: _userBedsController.text,
          overview: _userOverViewController.text,
          price: _userPriceController.text,
          
          contactNumber: contactNumber,
          email: email,
          
          estcertifie: estcertifie,
          certification: certification, profilePic:profilePic,
          // membre:membre, 
          lienFacebook: lienFacebook,
          gender:gender,
          vue: vue,
          country: country,
          address: address,
          );
      if (res == "success") {
        setState(() {
          _isloading = false;
        });
        showSnakeBar("Votre publication a été éffectuée.", context);
        clearPage();
      } else {
        setState(() {
          _isloading = false;
        });
        showSnakeBar(res, context);
      }
    } catch (e) {
      print("\n\n\n\tkoi error\r\r\r\r\r\n");
      print(e);
      showSnakeBar(e.toString(), context);
    }
  }

  clearPage() {
    setState(() {
      _file = null;
      _userTitleController.text = "";
      _userLocationController.text = "";
      _userOverViewController.text = "";
      _userPriceController.text = "";
     
    });
  }

  @override
  void dispose() {
    super.dispose();
    
    _userLocationController.dispose();
    _userOverViewController.dispose();
    _userPriceController.dispose();
    _userTitleController.dispose();
    ;
  }

  @override
  Widget build(BuildContext context) {
    // provider code for gettiing the data from the databsae
    UserCreaditials userCreaditials =
        Provider.of<UserProviders>(context).getUser;
    print(userCreaditials.email);
    print(userCreaditials.phoneNo);
    print(userCreaditials.lastName);
    print(userCreaditials.uid);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: SingleChildScrollView(
          child: Column(
        children: [
          Stack(
            children: [
              Container(
                  clipBehavior: Clip.antiAlias,
                  width: double.infinity,
                  height: 150.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: _file == null
                      ? Image.asset(
                          "assets/LOCATIVE.png",
                          fit: BoxFit.cover,
                        )
                      : CircleAvatar(
                          key: UniqueKey(),
                          backgroundImage: MemoryImage(
                            _file!,
                          ),
                          backgroundColor: Colors.white.withOpacity(0.13),
                          radius: 50,
                        )),
              InkWell(
                onTap: () async {
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
                child: Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 28.h),
                    width: 90.w,
                    height: 90.h,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      CupertinoIcons.camera_fill,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  children: [
                    Radio(
                      activeColor: Colors.brown,
                      autofocus: true,
                      value: "immobilier",
                      groupValue: _houseType,
                      onChanged: (String? value) {
                        setState(() {
                          _houseType = value!;
                        });
                      },
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    const Text(
                      "Immobilier",
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Radio(
                      activeColor: Colors.brown,
                      value: "enginsroulants",
                      groupValue: _houseType,
                      onChanged: (String? value) {
                        setState(() {
                          _houseType = value!;
                        });
                      },
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    const Text("Engins Roulants"),
                  ],
                ),

                Row(
                  children: [
                    Radio(
                      activeColor: Colors.brown,
                      value: "evenements",
                      groupValue: _houseType,
                      onChanged: (String? value) {
                        setState(() {
                          _houseType = value!;
                        });
                      },
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    const Text("Evènementiels"),
                    SizedBox(
                      width: 8.w,
                    ),
                    Radio(
                      activeColor: Colors.brown,
                      value: "pleinair",
                      groupValue: _houseType,
                      onChanged: (String? value) {
                        setState(() {
                          _houseType = value!;
                        });
                      },
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    const Text("Plein Air"),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      activeColor: Colors.brown,
                      value: "autres",
                      groupValue: _houseType,
                      onChanged: (String? value) {
                        setState(() {
                          _houseType = value!;
                        });
                      },
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    const Text("Autres"),
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),
                customTextFieldLable(lableText: 'Titre', isRequired: true),
                SizedBox(
                  height: 8.h,
                ),
                TextFormField(
                  validator: requiredField,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  controller: _userTitleController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.w, 0, 0, 0),
                    hintText: "entrez le titre",
                    border: customOutlineBorder(),
                    enabledBorder: customOutlineBorder(),
                    focusedBorder: customOutlineBorder(),
                  ),
                  maxLength: 20,
                ),
                SizedBox(
                  height: 8.h,
                ),
                customTextFieldLable(lableText: 'Lieux', isRequired: true),
                SizedBox(
                  height: 8.h,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  validator: requiredField,
                  controller: _userLocationController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.w, 0, 0, 0),
                    hintText: "entrez le lieu",
                    border: customOutlineBorder(),
                    enabledBorder: customOutlineBorder(),
                    focusedBorder: customOutlineBorder(),
                  ),),
                SizedBox(
                  height: 8.h,
                ),
                customTextFieldLable(lableText: 'Description', isRequired: true),
                SizedBox(
                  height: 8.h,
                ),
                TextFormField(
                  validator: requiredField,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  controller: _userOverViewController,

                  maxLines: 8,
                  //or null
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        gapPadding: 4,
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 3,
                        ),
                      ),
                      hintText: "entrez une description ici"),
                ),
                SizedBox(
                  height: 16.h,
                ),
                customTextFieldLable(lableText: 'Prix', isRequired: true),
                SizedBox(
                  height: 8.h,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  validator: requiredField,
                  controller: _userPriceController,
                  keyboardType: TextInputType.number,
                  decoration:
                      InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.w, 0, 0, 0),
                    hintText: "entrez le prix",
                    border: customOutlineBorder(),
                    enabledBorder: customOutlineBorder(),
                    focusedBorder: customOutlineBorder(),
                  ),),
                SizedBox(
                  height: 8.h,
                ),
                // TextFormField(
                //   validator: requiredField,
                //   textInputAction: TextInputAction.next,
                //   controller: _userBedsController,
                //   keyboardType: TextInputType.number,
                //   decoration: InputDecoration(hintText: "Beds"),
                // ),
                // SizedBox(
                //   height: 8.h,
                // ),
                // TextFormField(
                //   validator: requiredField,
                //   textInputAction: TextInputAction.next,
                //   controller: _userRoomsController,
                //   keyboardType: TextInputType.number,
                //   decoration: InputDecoration(hintText: "Room"),
                // ),
                // SizedBox(
                //   height: 8.h,
                // ),
                // TextFormField(
                //   validator: requiredField,
                //   textInputAction: TextInputAction.next,
                //   controller: _userSQrtController,
                //   keyboardType: TextInputType.number,
                //   decoration: InputDecoration(hintText: "métres carrés"),
                // ),
                // SizedBox(
                //   height: 16.h,
                // ),
                // TextFormField(
                //   validator: requiredField,
                //   textInputAction: TextInputAction.next,
                //   controller: _latitudeController,
                //   keyboardType: TextInputType.number,
                //   decoration: InputDecoration(hintText: "Latitude"),
                // ),
                // SizedBox(
                //   height: 16.h,
                // ),
                // TextFormField(
                //   validator: requiredField,
                //   textInputAction: TextInputAction.next,
                //   controller: _longitudeController,
                //   keyboardType: TextInputType.number,
                //   decoration: InputDecoration(hintText: "Longitude"),
                // ),
                SizedBox(
                  height: 16.h,
                ),
                _isloading
                    ? const CupertinoActivityIndicator(
                        color: Colors.brown,
                      )
                    : defaultButton(
                        text: "Publier",
                        press: () async {
                          if (isInterstitialAdLoaded) {
                          interstitialAd!.show();}
                          if (!_formKey.currentState!.validate()) {
                          } else if(_file==null){
                            return showSnakeBar("veuillez ajouter une photo de publication", context);
                          }
                          else {
                            print("button clicked");

                            addPost(
                              profilePic: userCreaditials.profilePic!,
                                uid: userCreaditials.uid,
                                email: userCreaditials.email,
                                userName: userCreaditials.fullname,
                                lastName: userCreaditials.lastName,
                                contactNumber: userCreaditials.phoneNo,
                                estcertifie: userCreaditials.estcertifie!,
                                certification: userCreaditials.certification,
                                // membre: userCreaditials.membre,
                                lienFacebook: userCreaditials.lienFacebook??"aucun lien",
                                vue: 0,
                                address: userCreaditials.address??"aucune adresse",
                                country: userCreaditials.country??"aucune ville",
                                gender: userCreaditials.gender??"le genre n'est pas defini",
                                
                                
                                );
                          }
                        }),
                SizedBox(
                  height: 16.h,
                ),
              ],
            ),
          ), 
        ],
      )),
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
