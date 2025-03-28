import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:taabo/authentication/auth_provider.dart';
import 'package:taabo/components/app_button.dart';
import 'package:taabo/components/app_text_form_field.dart';
import 'package:taabo/cubits/login/login_cubit.dart';
import 'package:taabo/utils/text_validators.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Color(0xFF1e78c1),
      body: BlocProvider(
        create: (context) => LoginCubit(authProvider),
        child: BlocListener<LoginCubit, LoginState>(
          listener: _getLoginFailureListener,
          child: BlocBuilder<LoginCubit, LoginState>(
            builder: _mapStateToWidget,
          ),
        ),
      ),
    );
  }

  Widget _mapStateToWidget(context, state) {
    if (state is LoginInitial) {
      return _buildLoginForm(context, state);
    }
    if (state is LoginLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: Color(0xFF1e78c1),
          ),
        ),
      );
    }
    return SizedBox.shrink();
  }

  Widget _buildLoginForm(BuildContext context, LoginInitial state) {
    LoginCubit cubit = BlocProvider.of<LoginCubit>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildTopContainer(context),
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildLoginText(),
                    _buildUsernameTextField(cubit),
                    _buildPasswordTextField(state, cubit),
                    Spacer(),
                    _buildLoginButton(cubit)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildTopContainer(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: _buildTopContainerDecoration(),
      child: _buildLogo(),
    );
  }

  BoxDecoration _buildTopContainerDecoration() {
    return BoxDecoration(
      color: const Color.fromARGB(255, 232, 241, 249),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(60),
        bottomRight: Radius.circular(60),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    );
  }

  Image _buildLogo() {
    return Image.asset(
      "assets/images/logo.png",
      scale: 2,
    );
  }

  Padding _buildLoginText() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        "Login",
        style: TextStyle(
          color: Colors.white,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  AppTextFormField _buildUsernameTextField(LoginCubit cubit) {
    return AppTextFormField(
      label: "Username",
      prefixIcon: Icons.person,
      onChanged: cubit.onUsernameChanged,
      validator: TextValidators.required,
    );
  }

  AppTextFormField _buildPasswordTextField(
      LoginInitial state, LoginCubit cubit) {
    return AppTextFormField(
      label: "Password",
      prefixIcon: Icons.lock,
      isObscure: state.isPasswordObscure,
      suffixWidget: GestureDetector(
        onTap: cubit.onIsPasswordObscureChanged,
        child: Icon(
            state.isPasswordObscure ? Icons.visibility_off : Icons.visibility,
            color: const Color(0xFF1e78c1)),
      ),
      onChanged: cubit.onPasswordChanged,
      validator: TextValidators.required,
    );
  }

  AppButton _buildLoginButton(LoginCubit cubit) {
    return AppButton(
      text: "Login",
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          cubit.onLogin();
        }
      },
      color: Colors.white,
      fontColor: Color(0xFF1e78c1),
    );
  }

  _getLoginFailureListener(context, state) {
    String? error;
    if (state is LoginFailure) {
      if (state.errorMessage == "Exception: user not found") {
        error = "Invalid Email or Password!";
      }
      Fluttertoast.showToast(
          msg: error ?? state.errorMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
