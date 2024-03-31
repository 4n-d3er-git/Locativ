// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserPost {
  final profilePic;
  final title; 
  // final houseStatus;
  final houseType; 
  final email;
  final contactnumber;
  final location;
  final overview;
  final price;
  // final beds;
  // final rooms;
  // final sqft; 
  final uid;
  final userName;
  final lastName;
  final postId;
  final datePublished;
  final postURL;
//  final latitude;
//  final longitude;
  final likes;
  bool estcertifie;
  // creating the constructor here...
  final certification;
  // final membre;
  final lienFacebook;
  final vue;
  final gender;
  final country;
  final address;
  UserPost({
    // required this.houseStatus,
    required this.houseType,
    required this.title,
    required this.contactnumber,
    required this.email,
    required this.uid,
    required this.userName,
    required this.lastName,
    required this.postId,
    required this.datePublished,
    required this.postURL,
    required this.likes,
    // required this.beds,
    required this.location,
    required this.overview,
    required this.price,
    // required this.rooms,
    // required this.latitude,
    // required this.longitude,
    // required this.sqft,
    required this.estcertifie, required this.certification, required this.profilePic,
    //  required this.membre,
    required this.lienFacebook,
    required this.vue,
    required this.gender,
    required this.country,
    required this.address,
  });
  // converting it to the map object
  Map<String, dynamic> toJson() => {
        // "houseStatus": houseStatus,
        "locationType": houseType,
        "postId": postId,
        "contact": contactnumber,
        "useremail": email,
        "titre": title,
        "userName": userName,
        "nom": lastName,
        "localite": location,
        "prix": price,
        // "beds": beds,
        // "rooms": rooms,
        // "sqft": sqft,
        "description": overview,
        "datePublication": datePublished,
        "likes": likes,
        "postURL": postURL,
    // "lat":latitude,
    // "long":longitude,
        "uid": FirebaseAuth.instance.currentUser!.uid,
        'estcertifie': estcertifie,
        "certification": certification,
        "photoProfil": profilePic,
        "lienfacebook": lienFacebook,
        // "membre": membre,
        'vue': vue,
        'genre':gender,
        'ville': country,
        'adresse': address,
      };
  static UserPost fromSnap(DocumentSnapshot documentSnapshot) {
    var snapshot = documentSnapshot.data() as Map<String, dynamic>;
    return UserPost(
      uid: snapshot['uid'],
      // houseStatus: snapshot['houseStatus'],
      houseType: snapshot['locationType'],
      email: snapshot['email'],
      contactnumber: snapshot['contact'],
      userName: snapshot['userName'],
      lastName: snapshot['nom'],
      likes: snapshot['likes'],
      datePublished: snapshot['datePublication'],
      postURL: snapshot['postURL'],
      postId: snapshot['postId'],
      // sqft: snapshot['sqft'],
      // beds: snapshot['beds'], 
      location: snapshot['localite'],
      overview: snapshot['description'], 
      price: snapshot['prix'],
      // rooms: snapshot['rooms'],
      title: snapshot['titre'],
      // latitude:snapshot['lat'],
      // longitude: snapshot['long'] ,
      estcertifie: snapshot['estcertifie'] ?? false,
      certification: snapshot["certification"] ?? "non", profilePic: snapshot["photoProfil"],
      lienFacebook: snapshot['lienfacebook']?? "aucun lien",
      // membre: snapshot['membre'],
      vue: snapshot['vue'],
      gender: snapshot['genre'],
      country: snapshot['ville'],
      address: snapshot['adresse'],
    );
  }
  // Méthode pour afficher l'icône en fonction de estcertifie
  Widget afficherIconeCertifications() {
    return estcertifie
        ? Icon( 
                  Icons.verified, color: Colors.blue[500],) // Icône pour la certification réussie.
        :  SizedBox(); // Icône pour la non-certification.
  }
}
