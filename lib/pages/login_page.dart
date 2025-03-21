import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:taabo/authentication/auth_provider.dart';
import 'package:taabo/components/app_button.dart';
import 'package:taabo/components/app_text_form_field.dart';
import 'package:taabo/cubits/login/login_cubit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Color(0xFF1e78c1),
      body: BlocProvider(
        create: (context) => LoginCubit(authProvider),
        child: BlocBuilder<LoginCubit, LoginState>(
          builder: _mapStateToWidget,
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
              child: Column(
                children: [
                  _buildLoginText(),
                  _buildEmailTextField(cubit),
                  _buildPasswordTextField(state, cubit),
                  Spacer(),
                  _buildLoginButton(cubit)
                ],
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

  AppTextFormField _buildEmailTextField(LoginCubit cubit) {
    return AppTextFormField(
      label: "Email",
      prefixIcon: Icons.person,
      onChanged: cubit.onEmailChanged,
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
    );
  }

  AppButton _buildLoginButton(LoginCubit cubit) {
    return AppButton(
      text: "Login",
      onPressed: cubit.onLogin,
      color: Colors.white,
      fontColor: Color(0xFF1e78c1),
    );
  }
}
