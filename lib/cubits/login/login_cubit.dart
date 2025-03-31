import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:taabo/authentication/auth_provider.dart';
import 'package:taabo/services/auth_service.dart';
import 'package:taabo/utils/exception_handler.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthService _authService = AuthService();
  final AuthProvider _authProvider;
  LoginCubit(this._authProvider) : super(LoginInitial());

  void onUsernameChanged(String? username) {
    var lastState = state as LoginInitial;
    emit(lastState.copyWith(username: username));
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
        currentState.username!,
        currentState.password!,
      );
      await _authProvider.login(response["token"]);
      emit(LoginSuccess(token: response['token']));
    } catch (e) {
      emit(
        LoginFailure(
          errorMessage: ExceptionHandler.toUserFriendlyMessage(e),
        ),
      );
      emit(currentState);
    }
  }
}
