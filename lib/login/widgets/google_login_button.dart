import 'package:bloc_firebase_login/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GoogleLoginButton extends StatelessWidget {
  const GoogleLoginButton({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ElevatedButton.icon(
      key: const Key('googleLogin_button'),
      onPressed: onPressed,
      icon: const Icon(FontAwesomeIcons.google, color: Colors.white),
      label: Text(l10n.loginFormGoogleLoginButtonText),
    );
  }
}
