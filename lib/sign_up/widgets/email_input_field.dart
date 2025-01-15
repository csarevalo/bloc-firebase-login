import 'package:bloc_firebase_login/l10n/l10n.dart';
import 'package:flutter/material.dart';

class EmailInputField extends StatelessWidget {
  const EmailInputField({
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
      key: const Key('loginForm_emailInput_textField'),
      onChanged: onChanged,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: l10n.loginFormEmailInputLabel,
        hintText: '',
        errorText: showErrorText ? l10n.loginFormEmailInputErrorText : null,
      ),
    );
  }
}
