// ignore_for_file: unnecessary_null_comparison, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_admin/resources/user_data_cloud_firestore.dart';

class AuthenticationMethods {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  CloudFireStoreClass cloudFireStoreClass = CloudFireStoreClass();

  // sign up
  Future<String> signUpUser({
    required String userName,
    required String userEmail,
    required String userPassword,
    required String confirmPassword,
  }) async {
    userName.trim();
    userEmail.trim();
    userPassword.trim();
    confirmPassword.trim();

    String output = "something went wrong";

    if (userName != "" &&
        userEmail != "" &&
        userPassword != "" &&
        confirmPassword != "") {
      try {
        await firebaseAuth
            .createUserWithEmailAndPassword(
              email: userEmail,
              password: userPassword,
            )
            .then(
              (value) => cloudFireStoreClass.uploadUserDataToDatabase(
                userName: userName,
                userEmail: userEmail,
                userPassword: userPassword,
              ),
            );

        // upload user data to firestore

        output = "success";
      } on FirebaseAuthException catch (e) {
        output = e.message.toString();
      }
    } else {
      output = "Please fill up everything";
    }
    return output;
  }

  // sign in
  Future<String> signInUser({
    required String userEmail,
    required String userPassword,
  }) async {
    userEmail.trim();
    userPassword.trim();

    String output = "something went wrong";
    bool flag = true;

    FirebaseFirestore.instance
        .collection('admindata')
        .get()
        .then((snapshot) => snapshot.docs.forEach((result) {
              if (result.data()['email'] == userEmail) {
                flag = true;
              }
            }));

    if (flag) {
      if (userEmail != "" && userPassword != "") {
        try {
          await firebaseAuth.signInWithEmailAndPassword(
            email: userEmail,
            password: userPassword,
          );
          output = "success";
        } on FirebaseAuthException catch (e) {
          output = e.message.toString();
        }
      } else {
        output = "Please fill up everything";
      }
    } else {
      output = "Invalied credentials";
    }
    return output;
  }

  // forgot password
  Future<String> userForgotPassword({required String userEmail}) async {
    userEmail.trim();

    String output = "Something went wrong..";

    if (userEmail != "") {
      try {
        await firebaseAuth.sendPasswordResetEmail(email: userEmail);
        output = "success";
      } on FirebaseAuthException catch (e) {
        output = e.message.toString();
      }
    } else {
      output = "Please fill up everything";
    }
    return output;
  }
}

/*
  checking if the user is valid or not
  result : failed to get those data from firebase
  because of it's security reasons.

  forgot password
  Future<String> userForgotPassword({required String userEmail}) async {
    userEmail.trim();

    String output = "Something went wrong..";

    if (userEmail != "") {
      bool isEmailValid = await doesEmailExistOrNot(userEmail: userEmail);
      print(isEmailValid);
      if (isEmailValid) {
          try {
          await firebaseAuth.sendPasswordResetEmail(email: userEmail);
          output = "success";
        } on FirebaseAuthException catch (e) {
          output = e.message.toString();
        }
        log("email is valid");
      } else {
        log("email is invalid...");
      }
    } else {
      output = "Please fill up everything";
    }
    return output;
  }

  check if the email is present or not in firebase
  Future<bool> doesEmailExistOrNot({required String userEmail}) async {
    try {
      var isEmailExists =
         // ignore: deprecated_member_use
          await firebaseAuth.fetchSignInMethodsForEmail(userEmail);

      List<String> toList = isEmailExists.toList();
      print(toList);

      print(isEmailExists);
      return isEmailExists.isNotEmpty;
    } catch (e) {
      // print error while cheking email

      log(e.toString());
      return false;
    }
  }
*/
