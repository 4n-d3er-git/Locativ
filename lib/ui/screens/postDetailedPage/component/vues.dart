import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
export 'vues.dart';

class PosteVue extends StatelessWidget {
  PosteVue({
    Key? key,
    required this.vues,
    required this.id,
  }) : super(key: key);

  final int vues;
  final String id;
  final userId = FirebaseAuth.instance.currentUser!.uid;

  Future<void> incrementVue() async {
    try {
      await FirebaseFirestore.instance.collection('posts').doc(id).update(
        {
          'vue': FieldValue.increment(1),
        },
      );
    } on FirebaseException {
      print('Error incrementing view count');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        incrementVue();
      },
      child: Row(
        children: [
          Text(
            vues.toString(),
            style: const TextStyle(
              color: Colors.red,
            ),
          ),
          // ... other widgets
        ],
      ),
    );
  }
}