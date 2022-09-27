import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';

import 'package:e_commerce_app_with_firebase_riverpod/domain/auth/user_data.dart';

class UserState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  final UserData userData;
  const UserState({
    required this.loading,
    required this.failure,
    required this.userData,
  });

  UserState copyWith({
    bool? loading,
    CleanFailure? failure,
    UserData? userData,
  }) {
    return UserState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
      userData: userData ?? this.userData,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [loading, failure, userData];
  factory UserState.init() => UserState(
      loading: false, failure: CleanFailure.none(), userData: UserData.init());
}
