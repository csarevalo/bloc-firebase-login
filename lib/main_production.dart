import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_firebase_login/app/app.dart';
import 'package:bloc_firebase_login/bootstrap.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;

  bootstrap(
    () => App(
      authenticationRepository: authenticationRepository,
    ),
  );
}
