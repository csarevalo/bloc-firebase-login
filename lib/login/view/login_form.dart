import 'package:bloc_firebase_login/l10n/l10n.dart';
import 'package:bloc_firebase_login/login/login.dart';
import 'package:bloc_firebase_login/login/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    context.read<LoginCubit>().state.email.displayError;
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.fixed,
                content: Text(
                  state.errorMessage ?? l10n.loginFormAuthErrorSnackbarText,
                ),
              ),
            );
        }
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/images/bloc_logo_small.png',
              height: 120,
            ),
            const SizedBox(height: 16),
            _EmailInput(),
            const SizedBox(height: 8),
            _PasswordInput(),
            const SizedBox(height: 8),
            LoginButton(
              onPressed: context.read<LoginCubit>().logInWithEmailAndPassword,
            ),
            const SizedBox(height: 8),
            GoogleLoginButton(
              onPressed: context.read<LoginCubit>().logInWithGoogle,
            ),
          ],
        ),
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (LoginCubit cubit) => cubit.state.password.displayError,
    );
    return PasswordInputField(
      onChanged: context.read<LoginCubit>().passwordChange,
      showErrorText: displayError != null,
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (LoginCubit cubit) => cubit.state.email.displayError,
    );
    return EmailInputField(
      onChanged: context.read<LoginCubit>().emailChange,
      showErrorText: displayError != null,
    );
  }
}
