import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:taabo/services/auth_service.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthService _authService = AuthService();
  LoginCubit() : super(LoginInitial());

  void onEmailChanged(String? email) {
    var lastState = state as LoginInitial;
    emit(lastState.copyWith(email: email));
  }

  void onPasswordChanged(String? password) {
    var lastState = state as LoginInitial;
    emit(lastState.copyWith(password: password));
  }

  void onIsPasswordObscureChanged() {
    var lastState = state as LoginInitial;
    emit(lastState.copyWith(isPasswordObscure: !lastState.isPasswordObscure));
  }

  Future<void> onLogin() async {
    final currentState = state as LoginInitial;
    emit(LoginLoading());

    try {
      final response = await _authService.login(
        currentState.email!,
        currentState.password!,
      );
      emit(LoginSuccess(token: response['token']));
    } catch (e) {
      emit(LoginFailure(errorMessage: e.toString()));
    }
  }
}
