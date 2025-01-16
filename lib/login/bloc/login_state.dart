part of 'login_bloc.dart';

final class LoginState extends Equatable {
  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.enableValidation = false,
    this.errorMessage,
  });

  final Email email;
  final Password password;
  final FormzSubmissionStatus status;
  final bool isValid;
  final bool enableValidation;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        email,
        password,
        status,
        isValid,
        enableValidation,
        errorMessage,
      ];

  LoginState copyWith({
    Email? email,
    Password? password,
    FormzSubmissionStatus? status,
    bool? isValid,
    bool? enableValidation,
    String? errorMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      enableValidation: enableValidation ?? this.enableValidation,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
