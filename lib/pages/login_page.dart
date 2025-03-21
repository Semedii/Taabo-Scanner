import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taabo/components/app_button.dart';
import 'package:taabo/components/app_text_form_field.dart';
import 'package:taabo/cubits/login/login_cubit.dart';
import 'package:taabo/pages/home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1e78c1),
      body: BlocProvider(
        create: (context) => LoginCubit(),
        child: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            state as LoginInitial;

            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.4,
                    decoration: BoxDecoration(
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
                    ),
                    child: Image.asset(
                      "assets/images/logo.png",
                      scale: 2,
                    ),
                  ),
                  SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _buildLoginForm(context, state),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context, LoginInitial state) {
    LoginCubit cubit = BlocProvider.of<LoginCubit>(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              "Login",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          AppTextFormField(
            label: "Email",
            prefixIcon: Icons.person,
            onChanged: cubit.onEmailChanged,
          ),
          AppTextFormField(
            label: "Password",
            prefixIcon: Icons.lock,
            isObscure: state.isPasswordObscure,
            suffixWidget: GestureDetector(
              onTap: cubit.onIsPasswordObscureChanged,
              child: Icon(
                  state.isPasswordObscure
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: const Color(0xFF1e78c1)),
            ),
            onChanged: cubit.onPasswordChanged,
          ),
          Spacer(),
          AppButton(
            text: "Login",
            onPressed: () => onLogin(context, state),
            color: Colors.white,
            fontColor: Color(0xFF1e78c1),
          )
        ],
      ),
    );
  }

  void onLogin(BuildContext context, LoginInitial state) {
    if (state.email == "abdi1122@gmail.com" && state.password == "112233") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    }
  }
}
