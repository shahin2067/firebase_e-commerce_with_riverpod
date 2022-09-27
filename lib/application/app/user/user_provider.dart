import 'package:e_commerce_app_with_firebase_riverpod/application/app/user/user_state.dart';
import 'package:e_commerce_app_with_firebase_riverpod/domain/app/user/i_user_repo.dart';
import 'package:e_commerce_app_with_firebase_riverpod/domain/auth/user_data.dart';
import 'package:e_commerce_app_with_firebase_riverpod/infrastracture/app/user/user_repo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  return UserNotifier(UserRepo());
});

class UserNotifier extends StateNotifier<UserState> {
  final IUserRepo userRepo;
  UserNotifier(this.userRepo) : super(UserState.init());

  collectUserData({required UserData userData}) async {
    state = state.copyWith(loading: true);
    final data = await userRepo.collectUserData(userData: userData);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false));
  }

  getUserData() async {
    state = state.copyWith(loading: true);
    final data = await userRepo.getUserData();
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, userData: r));
  }

  updateUserData({required UserData userData}) async {
    state = state.copyWith(loading: true);
    final data = await userRepo.updateUserData(userData: userData);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false));
    getUserData();
  }
}
