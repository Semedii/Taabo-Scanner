part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {
  final String? username;
  final String? password;
  final bool isPasswordObscure;

  LoginInitial({
    this.username,
    this.password,
    this.isPasswordObscure = true,
  });

  LoginInitial copyWith({
    String? username,
    String? password,
    bool? isPasswordObscure,
  }) {
    return LoginInitial(
      username: username ?? this.username,
      password: password ?? this.password,
      isPasswordObscure: isPasswordObscure ?? this.isPasswordObscure,
    );
  }
}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final String token;

  LoginSuccess({required this.token});
}

final class LoginFailure extends LoginState {
  final String errorMessage;

  LoginFailure({required this.errorMessage});
}
