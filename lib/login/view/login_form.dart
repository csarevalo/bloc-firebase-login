import 'dart:io';

import 'package:bloc_firebase_login/l10n/l10n.dart';
import 'package:bloc_firebase_login/login/login.dart';
import 'package:bloc_firebase_login/login/widgets/widgets.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb;
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
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) => previous.status != current.status,
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
        } else if (state.status.isSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                behavior: SnackBarBehavior.fixed,
                content: Text(
                  'SUCCESSFULLY LOGIN',
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
            const _EmailInput(),
            const SizedBox(height: 8),
            const _PasswordInput(),
            const SizedBox(height: 8),
            const _LoginButton(),
            if (kIsWeb || Platform.isAndroid || Platform.isIOS) ...[
              const SizedBox(height: 8),
              const _GoogleLoginButton(),
            ],
          ],
        ),
      ),
    );
  }
}

class _GoogleLoginButton extends StatelessWidget {
  const _GoogleLoginButton();

  @override
  Widget build(BuildContext context) {
    return GoogleLoginButton(
      onPressed: context.read<LoginCubit>().logInWithGoogle,
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton();

  @override
  Widget build(BuildContext context) {
    final isValid = context.select(
      (LoginCubit cubit) => cubit.state.isValid,
    );
    return LoginButton(
      onPressed: isValid
          ? () => context.read<LoginCubit>().logInWithCredentials()
          : null,
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput();

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
  const _EmailInput();

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
