import 'package:clean_api/clean_api.dart';
import 'package:e_commerce_app_with_firebase_riverpod/application/auth/auth_state.dart';
import 'package:e_commerce_app_with_firebase_riverpod/domain/auth/i_auth_repo.dart';
import 'package:e_commerce_app_with_firebase_riverpod/infrastracture/auth/auth_repo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(AuthRepo());
});

class AuthNotifier extends StateNotifier<AuthState> {
  final IAuthRepo authRepo;
  AuthNotifier(this.authRepo) : super(AuthState.init());

  registration({required String email, required String password}) async {
    state = state.copyWith(loading: true);
    final data = await authRepo.registration(email: email, password: password);
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            failure: CleanFailure.none(),
            loading: false,
            loggedIn: false,
            isRegistration: true));
  }

  login({required String email, required String password}) async {
    state = state.copyWith(loading: true);
    final data = await authRepo.logIn(email: email, password: password);
    state = data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
            loading: false, failure: CleanFailure.none(), loggedIn: true));
  }

  tryLogin() async {
    state = state.copyWith(loading: true);
    final data = await authRepo.tryLogin();

    state = data.fold((l) => state.copyWith(loading: false),
        (r) => state.copyWith(loading: false, userData: r));
  }

  // collectUserData({required UserData userData}) async {
  //   state = state.copyWith(loading: true);
  //   final data = await authRepo.collectUserData(userData: userData);
  //   state = data.fold((l) => state.copyWith(loading: false, failure: l),
  //       (r) => state.copyWith(loading: false));
  // }

  // getUserData() async {
  //   state = state.copyWith(loading: true);
  //   final data = await authRepo.getUserData();
  //   state = data.fold((l) => state.copyWith(loading: false, failure: l),
  //       (r) => state.copyWith(loading: false, userData: r));
  // }

}
