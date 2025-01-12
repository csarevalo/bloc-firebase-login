part of 'app_bloc.dart';

enum AppStatus { authenticate, unathenticated }

final class AppState extends Equatable {
  const AppState({User user = User.empty})
      : this._(
          status: user == User.empty
              ? AppStatus.unathenticated
              : AppStatus.authenticate,
          user: user,
        );

  const AppState._({
    required this.status,
    this.user = User.empty,
  });

  final AppStatus status;
  final User user;

  @override
  List<Object> get props => [user, status];
}