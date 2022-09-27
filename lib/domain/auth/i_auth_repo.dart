import 'package:clean_api/clean_api.dart';
import 'package:e_commerce_app_with_firebase_riverpod/domain/auth/user_data.dart';

abstract class IAuthRepo {
  Future<Either<CleanFailure, Unit>> registration(
      {required String email, required String password});

  Future<Either<CleanFailure, UserData>> logIn(
      {required String email, required String password});

  Future<Either<CleanFailure, UserData>> tryLogin();

  // Future<Either<CleanFailure, UserData>> collectUserData(
  //     {required UserData userData});

  // Future<Either<CleanFailure, UserData>> getUserData();

  // Future<Either<CleanFailure, UserData>> updateUserData({required UserData userData});
}
