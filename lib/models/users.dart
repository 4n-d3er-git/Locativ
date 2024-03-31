import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserCreaditials {
  final String? fullname;
  final String?lastName;
  final String? uid;
  final String?email;
  final String?phoneNo;
  final String?address;
  final String?gender;
  final String?age;
  final String?country;
  final String?profilePic;
  final bool? estcertifie;
  // creating the constructor here...
  final String certification;
  // final DateTime membre;
  final String? lienFacebook;
  UserCreaditials({
    required this.profilePic,
    required this.email,
    required this.uid,
    required this.fullname,
    required this.lastName,
    required this.phoneNo,
    required this.address,
    required this.gender,
    required this.age,
    required this.country,
    //required this.cart,
    required this.estcertifie,
      this.certification ="non",
      // required this.membre,
      this.lienFacebook= "aucun lien",
  });
  // converting it to the map object
  
  Map<String, dynamic> toJson() => {
        "profilPhoto": profilePic,
        "nomComplet": fullname,
        "nomFamille": lastName,
        "email": email,
        "uid": uid,
        "adresse": address,
        "numero": phoneNo,
        "genre": gender,
        "age": age,
        "ville": country,
        "carte": [],
        // "estcertifie": estcertifie,
        "certification": certification,
        // "membre": DateTime.now(),
        "lienFacebook": lienFacebook
      };
      
  static UserCreaditials fromSnap(DocumentSnapshot documentSnapshot) {
    
    var snapshot = documentSnapshot.data() as Map<String, dynamic>;
    return UserCreaditials(
      profilePic: snapshot['profilPhoto'],
      uid: snapshot['uid'],
      email: snapshot['email'],
      fullname: snapshot['nomComplet'], 
      lastName: snapshot['nomFamille'],
      address: snapshot['adresse'],
      age: snapshot['age'],
      country: snapshot['ville'],
      gender: snapshot['genre'],
      phoneNo: snapshot['numero'],
      // cart: snapshot['cart'],
       estcertifie: snapshot['estcertifie'] ?? false, 
       certification: snapshot["certification"] ?? "non",
      //  membre: snapshot['membre'],
       lienFacebook: snapshot['lienFacebook'] ??'aucun lien'
    );
  }
  // Méthode pour afficher l'icône en fonction de estcertifie
  Widget afficherIconeCertification() {
    return estcertifie!
        ? Icon( 
                  Icons.verified, color: Colors.blue[500],) // Icône pour la certification réussie.
        :  SizedBox(); // Icône pour la non-certification.
  }

  afficherIconeCertifications() {}
}
