import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_firebase_login/l10n/l10n.dart';
import 'package:bloc_firebase_login/sign_up/cubit/sign_up_cubit.dart';
import 'package:bloc_firebase_login/sign_up/view/sign_up_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  static const String routeName = '/signUp';

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.signUpScreenTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocProvider(
          create: (_) => SignUpCubit(context.read<AuthenticationRepository>()),
          child: const SignUpForm(),
        ),
      ),
    );
  }
}
