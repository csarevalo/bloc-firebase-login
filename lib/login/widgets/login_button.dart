import 'package:bloc_firebase_login/l10n/l10n.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return TextButton(
      key: const Key('login_button'),
      onPressed: onPressed,
      child: Text(
        l10n.loginFormLoginButtonText,
      ),
    );
  }
}
