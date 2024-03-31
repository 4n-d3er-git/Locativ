import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locative/ui/screens/house/components/card.dart';


class MesLocations extends StatefulWidget {
  @override
  _MesLocationsState createState() => _MesLocationsState();
}

class _MesLocationsState extends State<MesLocations> {
  late final User user;
  late final String uid;

  late final FirebaseFirestore firestore;
  late final CollectionReference<Map<String, dynamic>> publications;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    user = FirebaseAuth.instance.currentUser!;
    uid = user.uid;
    firestore = FirebaseFirestore.instance;
    publications = firestore.collection('posts').withConverter<Map<String, dynamic>>(
      fromFirestore: (snapshot, _) => snapshot.data()!,
      toFirestore: (data, _) => data,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Publications de l\'utilisateur'),
      ),
      body: StreamBuilder(
        stream: publications.where('uid', isEqualTo: uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final docs = snapshot.data!.docs;
            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                final publication = docs[index].data();
                return customHouseCard(snap: publication);
              },
            );
          } else {
            return Center(child: CupertinoActivityIndicator(
                          radius: 25.r,
                          color: Colors.brown,
                        ),);
          }
        },
      ),
    );
  }
}

