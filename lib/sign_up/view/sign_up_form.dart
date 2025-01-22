import 'package:bloc_firebase_login/l10n/l10n.dart';
import 'package:bloc_firebase_login/sign_up/bloc/sign_up_bloc.dart';
import 'package:custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          Navigator.of(context).pop();
        } else if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.fixed,
                content: Text(
                  state.errorMessage ?? l10n.signUpFormErrorSnackbarText,
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
            const _ConfirmedPasswordInput(),
            const SizedBox(height: 8),
            const _SignUpButton(),
          ],
        ),
      ),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton();

  @override
  Widget build(BuildContext context) {
    final isEnabled = context.select(
      (SignUpBloc bloc) => bloc.state.isValid,
    );

    final labelText = context.l10n.signUpFormSignUpButtonText;
    return SimpleTextButton(
      labelText: labelText,
      onPressed: () => isEnabled
          ? () => context.read<SignUpBloc>().add(const SignUpFormSubmitted())
          : null,
    );
  }
}

class _ConfirmedPasswordInput extends StatelessWidget {
  const _ConfirmedPasswordInput();

  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (SignUpBloc bloc) => bloc.state.confirmedPassword.displayError,
    );

    final l10n = context.l10n;
    return PasswordInputField(
      onChanged: (password) => context
          .read<SignUpBloc>()
          .add(SignUpConfirmedPasswordChanged(password)),
      labelText: l10n.signUpFormConfirmedPasswordInputLabel,
      hintText: '',
      errorText: l10n.signUpFormConfirmedPasswordInputErrorText,
      showErrorText: displayError != null,
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (SignUpBloc bloc) => bloc.state.password.displayError,
    );

    final l10n = context.l10n;
    return PasswordInputField(
      onChanged: (password) =>
          context.read<SignUpBloc>().add(SignUpPasswordChanged(password)),
      labelText: l10n.signUpFormPasswordInputLabel,
      hintText: '',
      errorText: l10n.signUpFormPasswordInputErrorText,
      showErrorText: displayError != null,
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (SignUpBloc bloc) => bloc.state.email.displayError,
    );

    final l10n = context.l10n;
    return EmailInputField(
      onChanged: (email) =>
          context.read<SignUpBloc>().add(SignUpEmailChanged(email)),
      labelText: l10n.signUpFormEmailInputLabel,
      hintText: '',
      errorText: l10n.signUpFormEmailInputErrorText,
      showErrorText: displayError != null,
    );
  }
}
