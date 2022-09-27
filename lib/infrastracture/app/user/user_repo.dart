import 'package:clean_api/clean_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app_with_firebase_riverpod/domain/app/user/i_user_repo.dart';
import 'package:e_commerce_app_with_firebase_riverpod/domain/auth/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepo extends IUserRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<Either<CleanFailure, UserData>> collectUserData(
      {required UserData userData}) async {
    try {
      var currentUser = _auth.currentUser;

      final user = UserData(
          name: userData.name,
          phone: userData.phone,
          dateOfBirth: userData.dateOfBirth,
          age: userData.age,
          gender: userData.gender);
      _db.collection("user-data").doc(currentUser!.email).set(user.toMap());
      return right(user);
    } on FirebaseException catch (e) {
      return left(CleanFailure(error: e.toString(), tag: 'User Data'));
    } catch (e) {
      return left(CleanFailure(error: e.toString(), tag: 'User Data'));
    }
  }

  @override
  Future<Either<CleanFailure, UserData>> getUserData() async {
    try {
      final data =
          await _db.collection("user-data").doc(_auth.currentUser!.email).get();
      final user = UserData(
          name: data['name'],
          phone: data['phone'],
          dateOfBirth: data['dateOfBirth'],
          age: data['age'],
          gender: data['gender']);

      Logger.i(data['name']);
      Logger.i(user);

      return right(user);
    } catch (e) {
      return left(CleanFailure(error: e.toString(), tag: 'Get UserData'));
    }
  }

  @override
  Future<Either<CleanFailure, Unit>> updateUserData(
      {required UserData userData}) async {
    try {
      _db
          .collection("user-data")
          .doc(_auth.currentUser!.email)
          .update({
            "name": userData.name,
            "phone": userData.phone,
            "dateOfBirth": userData.dateOfBirth,
            "age": userData.age,
            "gender": userData.gender
          })
          .then((value) => print("Updated Sucessfully"))
          .catchError((error) => print("Updated Failed"));
      return right(unit);
    } on FirebaseAuthException catch (e) {
      return left(CleanFailure(error: e.toString(), tag: 'Update User'));
    } on FirebaseException catch (e) {
      return left(CleanFailure(error: e.toString(), tag: 'Update User'));
    } catch (e) {
      return left(CleanFailure(error: e.toString(), tag: 'Update User'));
    }
  }
}
