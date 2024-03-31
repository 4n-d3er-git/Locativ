import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/storage_methods.dart';
import 'package:uuid/uuid.dart';

import '../models/posts.dart';
 
class FirestoreMethods {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  
  Future<String> uploadPost({
    required String profilePic,
    required Uint8List file,
    required String houseType,
    required final uid ,
    required final contactNumber, 
    required final email,
    required String username,
    required String lastName,
    required String title,
    required String location,
    required String overview,
    required String price,
    
    required bool estcertifie, 
    required String certification,
    // required  DateTime membre,
    required String lienFacebook,
    required int vue,
    required String gender,
    required String country,
    required String address,
  }) async {
    String res = "Some error occured";
    try {
      String imageURL = await StorageMethods().uploadImageToStorage(
        "posts",
        file,
        true,
      );

      String postId = const Uuid().v1();
      UserPost userPost = UserPost(
        profilePic: profilePic,
        houseType: houseType,
        title: title,
        uid: uid,
        userName: username,
        lastName: lastName,
        contactnumber: contactNumber,
        email: email,
        postId: postId,
        datePublished: DateTime.now() ,
        postURL: imageURL,
        likes: [],
        location: location,
        overview: overview,
        price: price,
        
        estcertifie: estcertifie,
        certification: certification,
        // membre: membre,
        lienFacebook: lienFacebook,
        vue: vue,
        gender: gender,
        country: country,
        address: address,
      );
      _firebaseFirestore.collection("posts").doc(postId).set(userPost.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // for liking the post
  Future<void> likePost({
    required String postId,
    required String uid,
    required List like,
  }) async {
    try {
      if (like.contains(uid)) {
        await _firebaseFirestore.collection("posts").doc(postId).update(
          {
            "likes": FieldValue.arrayRemove([uid]),
          },
        );
      } 
      else {
        await _firebaseFirestore.collection("posts").doc(postId).update(
          { 
            "likes": FieldValue.arrayUnion([uid]),
          },
        );
      }
    } catch (e) { 
      print(e);
    }
  }

  // deleting the post
  Future<String> deletePost({required String postId}) async {
    String res = "Some error occured";
    try {
      await _firebaseFirestore.collection('posts').doc(postId).delete();
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // editin
  Future<String> updateUserData(
      {required String name,
      required String country,
      required String age, 
      required String phoneNo,
      required String address,
      //required String cnic,
      required String email,
      required String gender,
      required String lastName,
      required String profilePic,
      required String uid,
      required String lienFacebook,
      required bool estcertifie,
      required String certification
      }) async {
    String res = "Some error occured";
    // this is the function that has to edit the username
    try {
      
      await _firebaseFirestore.collection('utilisateurs').doc(uid).set({
        'nomComplet': name,
        "ville": country,
        "age": age,
        "numero": phoneNo,
        "adresse": address, 
        "nomFamille": lastName,
        "email": email,
        "profilPhoto": profilePic,
        "uid": uid,
        "lienFacebook": lienFacebook,
        "certification": certification,
        "estcertifie": estcertifie,
        "genre": gender
      });
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

Future<String> updatePost(
  {
    required String postId,
  
  required String profilePic,
  required String houseType,
  required String title,
  required String uid,
  required String userName,
  required String lastName,
  required String contactnumber,
  required String email,
  required DateTime datePublished,
 required  String postURL,
 required List likes,
 required String location,
 required String overview,
 required String price,
  
 required bool estcertifie,
 required String certification,
  // DateTime membre,
 required String lienFacebook,
required  int vue,
required  String gender,
required  String country,
required  String address,
  }) async {
  String res = "Some error occured";
  try {
    await _firebaseFirestore.collection('posts').doc(postId).set({
      'photoProfil': profilePic,
      'locationType': houseType,
      'titre': title,
      'uid': uid,
      'userName': userName,
      'nom': lastName,
      'contact': contactnumber,
      'useremail': email,
      'postId': postId,
      'datePublication': datePublished,
      'postURL': postURL,
      'likes': likes,
      'localite': location,
      'description': overview,
      'prix': price,
      
      'estcertifie': estcertifie,
      'certification': certification,
      // 'membre': membre,
      'lienfacebook': lienFacebook,
      'vue': vue,
      'genre': gender,
      'ville': country,
      'adresse': address,

    }
);
    res = "success";
  } catch (e) {
    res = e.toString();
  }
  return res; 
}}
