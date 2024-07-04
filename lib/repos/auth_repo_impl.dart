import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'auth_repo.dart';



class AuthRepoImplementation implements AuthRepo {
  @override
  Future<Either<String, Unit>> loginUser(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return left('this email is not found');
      } else if (e.code == 'wrong-password') {
        return left('wrong password!');
      } else if (e.code == 'invalid-email') {
        return left('this email is not correct!');
      } else {
        return left('please enter the correct data');
      }
    } catch (e) {
      return left('unexpected error');
    }
  }

  Future<Either<String, Unit>> storeUserDetailsInFirestore(User user) async {
    try {
      final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

      // Check if the user already exists in Firestore
      final DocumentSnapshot userSnapshot = await usersCollection.doc(user.uid).get();
      if (!userSnapshot.exists) {
        // If the user doesn't exist, add their details to Firestore
        await usersCollection.doc(user.uid).set({
          'email': user.email,
          'username': user.displayName ?? '', // You may need to adjust this based on your user data
          'phoneNumber': user.phoneNumber ?? '', // You may need to adjust this based on your user data
        });
      }

      return right(unit);
    } catch (e) {
      if (kDebugMode) {
        print("Error storing user details in Firestore: $e");
      }
      return left("Error storing user details in Firestore");
    }
  }
  @override
  Future<Either<String, Unit>> registerUser(String email, String password ,String userName,String phoneNumber) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String userId = userCredential.user!.uid;
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'email': email,
        'username': userName,

      });

      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return left('this email is already in use, try again');
      } else if (e.code == 'invalid-email') {
        return left('this email is not correct!');
      } else if (e.code == 'weak-password') {
        return left('week password');
      } else {
        return left('error:login failed');
      }
    } catch (e) {
      return left('unexpected error');
    }
  }


}
