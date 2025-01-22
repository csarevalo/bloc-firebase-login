import 'dart:io';

import 'package:bloc_firebase_login/l10n/l10n.dart';
import 'package:bloc_firebase_login/login/login.dart';
import 'package:bloc_firebase_login/login/widgets/widgets.dart';
import 'package:custom_widgets/custom_widgets.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
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
    return BlocListener<LoginBloc, LoginState>(
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
      onPressed: () =>
          context.read<LoginBloc>().add(const LoginWithGoogleRequested()),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton();

  @override
  Widget build(BuildContext context) {
    final isEnabled = context.select(
      (LoginBloc bloc) => bloc.state.isValid || !bloc.state.enableValidation,
    );

    final labelText = context.l10n.loginFormLoginButtonText;
    return FilledTextButton(
      labelText: labelText,
      onPressed: isEnabled
          ? () => context
              .read<LoginBloc>()
              .add(const LoginWithCredentialsRequested())
          : null,
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) {
    context.select((LoginBloc bloc) => bloc.state.enableValidation);
    final displayError = context.select(
      (LoginBloc bloc) =>
          bloc.state.enableValidation ? bloc.state.password.displayError : null,
    );

    final l10n = context.l10n;
    return PasswordInputField(
      onChanged: (password) =>
          context.read<LoginBloc>().add(LoginPasswordChanged(password)),
      labelText: l10n.loginFormPasswordInputLabel,
      hintText: '',
      errorText: l10n.loginFormPasswordInputErrorText,
      showErrorText: displayError != null,
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) {
    context.select((LoginBloc bloc) => bloc.state.enableValidation);
    final displayError = context.select(
      (LoginBloc bloc) =>
          bloc.state.enableValidation ? bloc.state.email.displayError : null,
    );

    final l10n = context.l10n;
    return EmailInputField(
      onChanged: (email) =>
          context.read<LoginBloc>().add(LoginEmailChanged(email)),
      labelText: l10n.loginFormEmailInputLabel,
      hintText: '',
      errorText: l10n.loginFormEmailInputErrorText,
      showErrorText: displayError != null,
    );
  }
}
