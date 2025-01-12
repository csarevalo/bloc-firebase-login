import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_firebase_login/bloc/app_bloc.dart';
import 'package:bloc_firebase_login/counter/counter.dart';
import 'package:bloc_firebase_login/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:flow_builder/flow_builder.dart';

class App extends StatelessWidget {
  const App({
    required AuthenticationRepository authenticationRepository,
    super.key,
  }) : _authenticationRepository = authenticationRepository;

  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider(
        lazy: false,
        create: (_) => AppBloc(
          authenticationRepository: _authenticationRepository,
        )..add(const AppUserSubscriptionRequested()),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark(useMaterial3: true).copyWith(
          appBarTheme: AppBarTheme(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const CounterPage()
        // TODO: home: FlowBuilder<AppStatus>
        // (
        //   state: context.select((AppBloc bloc) => bloc.state.status),
        //   onGeneratePages: onGenerateAppViewPages,
        // ),
        );
  }

  // TODO: List<Page<dynamic>> onGenerateAppViewPages
  // (
  //   AppStatus state,
  //   List<Page<dynamic>> pages,
  // ) {
  //   switch (state) {
  //     case AppStatus.authenticate:
  //       break;
  //     case AppStatus.unathenticated:
  //       break;
  //   }
  // }
}
