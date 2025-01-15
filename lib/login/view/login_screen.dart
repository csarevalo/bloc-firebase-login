import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_firebase_login/l10n/l10n.dart';
import 'package:bloc_firebase_login/login/bloc/login_bloc.dart';
import 'package:bloc_firebase_login/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.loginScreenTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocProvider(
          create: (_) => LoginBloc(context.read<AuthenticationRepository>()),
          child: const LoginForm(),
        ),
      ),
    );
  }
}
