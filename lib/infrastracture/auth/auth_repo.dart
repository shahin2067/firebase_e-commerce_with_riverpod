import 'package:cherry_toast/cherry_toast.dart';
import 'package:clean_api/clean_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app_with_firebase_riverpod/domain/auth/i_auth_repo.dart';
import 'package:e_commerce_app_with_firebase_riverpod/domain/auth/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthRepo extends IAuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<Either<CleanFailure, Unit>> registration(
      {required String email, required String password}) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      var authCredential = credential.user;
      print(authCredential!.uid);
      // if (authCredential.uid.isNotEmpty) {
      //   // ignore: use_build_context_synchronously
      //   Navigator.push(context, CupertinoPageRoute(builder: (_) => UserForm()));
      // } else {
      //   Fluttertoast.showToast(msg: "Something is wrong");
      // }
      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        CherryToast.warning(
            title: const Text('The password provided is too weak.'));
        //Fluttertoast.showToast(msg: "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        return left(const CleanFailure(
            tag: "Email used",
            error: "The account already exists for that email."));
      }
      return left(CleanFailure(tag: "Registration", error: e.toString()));
    } catch (e) {
      Logger.e(e);
      return left(CleanFailure(tag: "Registration", error: e.toString()));
    }
  }

  @override
  Future<Either<CleanFailure, UserData>> logIn(
      {required String email, required String password}) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      // var authCredential = credential.user;
      //Logger.i("Auth: $authCredential");
      //print(authCredential!.uid);
      final user = await _db
          .collection('user-data')
          .doc(credential.user!.email)
          .get()
          .then(
            (value) => UserData.fromMap(value.data()!),
          );
      //Logger.i("User: $user");

      return right(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return left(const CleanFailure(
            tag: "Login", error: "User not found for that email"));
      } else if (e.code == 'wrong-password') {
        return left(const CleanFailure(tag: "Login", error: "Wrong Password"));
      }
      return left(CleanFailure(tag: "Login", error: e.toString()));
    } on FirebaseException catch (e) {
      return left(CleanFailure(error: e.toString(), tag: 'Login'));
    } catch (e) {
      Logger.e(e);
      return left(CleanFailure(tag: "Login", error: e.toString()));
    }
  }

  @override
  Future<Either<CleanFailure, UserData>> tryLogin() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final userId = _auth.currentUser?.uid;
    try {
      if (userId != null) {
        final user = await _db.collection('User').doc(userId).get().then(
              (value) => UserData.fromMap(value.data()!),
            );
        return right(user);
      } else {
        return left(
            const CleanFailure(error: "User not loggedIn", tag: 'Try Signin'));
      }
    } on FirebaseException catch (e) {
      Logger.e(e);
      return left(CleanFailure(error: e.toString(), tag: 'Try Login'));
    } catch (e) {
      Logger.e(e);
      return left(CleanFailure(error: e.toString(), tag: 'Try Login'));
    }
  }

  // @override
  // Future<Either<CleanFailure, UserData>> collectUserData(
  //     {required UserData userData}) async {
  //   try {
  //     var currentUser = _auth.currentUser;

  //     final user = UserData(
  //         name: userData.name,
  //         phone: userData.phone,
  //         dateOfBirth: userData.dateOfBirth,
  //         age: userData.age,
  //         gender: userData.gender);
  //     _db.collection("user-data").doc(currentUser!.email).set(user.toMap());
  //     return right(user);
  //   } on FirebaseException catch (e) {
  //     return left(CleanFailure(error: e.toString(), tag: 'User Data'));
  //   } catch (e) {
  //     return left(CleanFailure(error: e.toString(), tag: 'User Data'));
  //   }
  // }

  // @override
  // Future<Either<CleanFailure, UserData>> getUserData() async {
  //   try {
  //     final data =
  //         await _db.collection("user-data").doc(_auth.currentUser!.email).get();
  //     final user = UserData(
  //         name: data['name'],
  //         phone: data['phone'],
  //         dateOfBirth: data['dateOfBirth'],
  //         age: data['age'],
  //         gender: data['gender']);

  //     Logger.i(data['name']);

  //     return right(user);
  //   } catch (e) {
  //     return left(CleanFailure(error: e.toString(), tag: 'Get UserData'));
  //   }
  // }

  // @override
  // Future<Either<CleanFailure, UserData>> updateUserData(
  //     {required UserData userData}) async {
  //   try {

  //   } catch (e) {}
  // }

}
