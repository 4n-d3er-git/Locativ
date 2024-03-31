import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/storage_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart'; 
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/users.dart';
import '../ui/widgets/customSnakeBar.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<UserCreaditials> getUserDetails() async {
    log("Ander Locative");
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snapshot = await _firebaseFirestore
        .collection("utilisateurs")
        .doc(currentUser.uid)
        .get()
        .catchError(
      (onError) {
        throw Exception(onError);
      },
    );

    return UserCreaditials.fromSnap(snapshot);
  }
  // Creating the function which is responsible for the auth related work

  // creating the function to create the user
  Future<String> createUser({
    required String email,
    required String password, 
    required BuildContext context,
  }) async {
    String res = "Some error Occured";
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(userCredential.user!.uid);
      // Si la création du compte réussit, mettez à jour la valeur de res
    res = "success";
    print(userCredential.user!.uid);
    
    } on FirebaseAuthException catch (err) {
      if (err.code == 'weak-password') {
        showSnakeBar("Ce mot de pass est failble.", context);
      } else if (err.code == 'email-already-in-use') {
        showSnakeBar("Un compte existe déjà avec cet email.", context);
      }
    }
    return res;
  }



  // complete profile
  Future<String> completeProfile({
    required Uint8List profilePic,
    required String fullname,
    required String lastName,
    required String phoneNumber,
    required String address, 
    required String country,
    required String age,
    required String gender,
    required BuildContext context,
    required bool estcertifie,
    // required List? cart,
  }) async {
    String res = "Some error occured";
    try {
      String photoUrl = await StorageMethods()
          .uploadImageToStorage("ProfilPhoto", profilePic, false);
      UserCreaditials userCreaditials = UserCreaditials(
        email: _auth.currentUser!.email!,
        uid: _auth.currentUser!.uid,
        profilePic: photoUrl,
        fullname: fullname,
        lastName: lastName,
        address: address,
        age: age,
        gender: gender,
        country: country,
        phoneNo: phoneNumber,
        // cart: cart!,
        estcertifie: false,
        certification: "non",
        // membre: DateTime.now(),
        lienFacebook: 'aucun lien',

      );
      _firebaseFirestore
          .collection("utilisateurs")
          .doc(_auth.currentUser!.uid)
          .set(userCreaditials.toJson());
      res = "success";
    } on FirebaseAuthException catch (err) {
      showSnakeBar(err.message!, context);
    }
    return res;
  }

  // login
  Future<String> userLogin({ 
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    String res = "Some error occured.";
    // checking the values are empty or not
    try {
      // now checking and login the user
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
          if(credential.user !=null){
            res ='success';
          } else{

          }
      
    } on FirebaseAuthException catch (err) {
      if (err.code == "wrong-password") {
        showSnakeBar("Information d'identification invalide", context);
      }
    } catch (err) {
      showSnakeBar(err.toString(), context);
    }
    return res;
  }
 
  // forgot password
  Future<String> forgotPassword(
      {required BuildContext context, required String email}) async {
    String res = "Some error occred";
    try {
      await _auth.sendPasswordResetEmail(email: email);
      res = 'success';
    } on FirebaseException catch (e) {
      showSnakeBar(e.message!, context);
    }
    return res;
  }

  // signout
  Future<String> signOut() async {
    String res = "Some error Occured";
    try {
      await _auth.signOut();
      res = "Logout Done.";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  
}
