import 'package:bloc_firebase_login/l10n/l10n.dart';
import 'package:flutter/material.dart';

class PasswordInputField extends StatelessWidget {
  const PasswordInputField({
    super.key,
    this.onChanged,
    this.showErrorText = false,
  });

  final void Function(String)? onChanged;
  final bool showErrorText;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return TextField(
      key: const Key('loginForm_passwordInput_textField'),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: l10n.loginFormPasswordInputLabel,
        hintText: '',
        errorText: showErrorText ? l10n.loginFormPasswordInputErrorText : null,
      ),
    );
  }
}