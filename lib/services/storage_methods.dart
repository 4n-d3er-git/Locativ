import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // adding image to firebase storage
  Future<String> uploadImageToStorage(
    String childName, 
    Uint8List file,
    bool ispost, 
  ) async {
    // creating location to our firebase storage
 
    Reference ref =
        _storage.ref().child(childName).child(//_auth.currentUser!.uid//
        "images/${DateTime.now().toString()}"
        );
    // putting in uint8list format -> Upload task like a future but not future
 /*   if (ispost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }*/
    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snapshot = await uploadTask;

    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
