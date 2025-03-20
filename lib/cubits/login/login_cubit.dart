import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
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
}
