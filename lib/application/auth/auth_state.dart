import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';

import 'package:e_commerce_app_with_firebase_riverpod/domain/auth/user_data.dart';

class AuthState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final bool loggedIn;
  final bool isRegistration;
  final UserData userData;
  const AuthState({
    required this.loading,
    required this.failure,
    required this.loggedIn,
    required this.isRegistration,
    required this.userData,
  });

  AuthState copyWith({
    bool? loading,
    CleanFailure? failure,
    bool? loggedIn,
    bool? isRegistration,
    UserData? userData,
  }) {
    return AuthState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      loggedIn: loggedIn ?? this.loggedIn,
      isRegistration: isRegistration ?? this.isRegistration,
      userData: userData ?? this.userData,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      loading,
      failure,
      loggedIn,
      isRegistration,
      userData,
    ];
  }

  factory AuthState.init() => AuthState(
      loading: false,
      failure: CleanFailure.none(),
      loggedIn: false,
      isRegistration: false,
      userData: UserData.init());
}

  


// class AuthState extends Equatable {
//   final bool loading;
//   final CleanFailure failure;
//   const AuthState({
//     required this.loading,
//     required this.failure,
//   });

//   AuthState copyWith({
//     bool? loading,
//     CleanFailure? failure,
//   }) {
//     return AuthState(
//       loading: loading ?? this.loading,
//       failure: failure ?? this.failure,
//     );
//   }

//   @override
//   bool get stringify => true;

//   @override
//   List<Object> get props => [loading, failure];

//   factory AuthState.init() =>
//       AuthState(loading: false, failure: CleanFailure.none());
// }
