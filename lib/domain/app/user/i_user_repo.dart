import 'package:clean_api/clean_api.dart';
import 'package:e_commerce_app_with_firebase_riverpod/domain/auth/user_data.dart';

abstract class IUserRepo {
  Future<Either<CleanFailure, UserData>> collectUserData(
      {required UserData userData});

  Future<Either<CleanFailure, UserData>> getUserData();

  Future<Either<CleanFailure, Unit>> updateUserData(
      {required UserData userData});
}
