import 'package:bloc_firebase_login/app/bloc/app_bloc.dart';
import 'package:bloc_firebase_login/home/view/home_screen.dart';
import 'package:bloc_firebase_login/login/view/login_screen.dart';
import 'package:bloc_firebase_login/sign_up/view/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  return PageRouteBuilder(
    pageBuilder: (context, __, ___) {
      switch (settings.name) {
        case HomeScreen.route:
          return const HomeScreen();
        case LoginScreen.route:
          return const LoginScreen();
        case SignUpScreen.route:
          return const SignUpScreen();
        case '/':
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        default:
          return const Scaffold(
            body: Center(
              child: Text('404: Missing Route'),
            ),
          );
      }
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(-1, 1);
      const end = Offset.zero;
      const curve = Curves.ease;
      final tween = Tween(begin: begin, end: end).chain(
        CurveTween(curve: curve),
      );
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
    transitionDuration: kThemeAnimationDuration, // 300 milliseconds
    reverseTransitionDuration: kThemeAnimationDuration, // 300 milliseconds
  );
}

Widget get generateHomeScreen => onGenerateHomeScreen();

Widget onGenerateHomeScreen() {
  return BlocBuilder<AppBloc, AppState>(
    buildWhen: (previous, current) => previous.status != current.status,
    builder: (context, state) {
      return switch (state.status) {
        AppStatus.authenticated => const HomeScreen(),
        AppStatus.unauthenticated => const LoginScreen(),
      };
    },
  );
}

// To be used with FlowBuilder...
// can't use MaterialApp onGenerateRoute (named parameters)
List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [
        const MaterialPage<void>(child: HomeScreen()),
      ];
    case AppStatus.unauthenticated:
      return [
        const MaterialPage<void>(child: LoginScreen()),
      ];
  }
}
