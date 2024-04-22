import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CloudFireStoreClass {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<void> uploadUserDataToDatabase({
    required String userName,
    required String userEmail,
    required String userPassword,
  }) async {
    firebaseFirestore
        .collection("admindata")
        .doc(firebaseAuth.currentUser!.uid)
        .set(
      {
        "adminname": userName,
        "email": userEmail,
        "password": userPassword,
      },
    );
  }

  //upload google sign in data to database
}
