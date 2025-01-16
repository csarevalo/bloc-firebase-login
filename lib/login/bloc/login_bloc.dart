import 'dart:async';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' show droppable;
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:rxdart/transformers.dart'
    show DebounceExtensions, FlatMapExtension;
import 'package:stream_transform/stream_transform.dart' show RateLimit;

part 'login_event.dart';
part 'login_state.dart';

const throttleDuration = Duration(milliseconds: 150);
const debounceDuration = Duration(milliseconds: 250);

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._authenticationRepository) : super(const LoginState()) {
    on<LoginEmailChanged>(
      _onLoginEmailChanged,
      transformer: debounce(debounceDuration),
    );
    on<LoginPasswordChanged>(
      _onLoginPasswordChanged,
      transformer: debounce(debounceDuration),
    );
    on<LoginWithCredentialsRequested>(
      _onLoginWithCredentialsRequested,
      transformer: throttleDroppable(throttleDuration),
    );
    on<LoginWithGoogleRequested>(
      _onLoginWithGoogleRequested,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final AuthenticationRepository _authenticationRepository;

  void _onLoginEmailChanged(
    LoginEmailChanged event,
    Emitter<LoginState> emit,
  ) {
    final email = Email.dirty(event.email);
    if (state.enableValidation) {
      emit(
        state.copyWith(
          email: email,
          isValid: Formz.validate([email, state.password]),
        ),
      );
    } else {
      emit(state.copyWith(email: email));
    }
  }

  void _onLoginPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);
    if (state.enableValidation) {
      emit(
        state.copyWith(
          password: password,
          isValid: Formz.validate([state.email, password]),
        ),
      );
    } else {
      emit(state.copyWith(password: password));
    }
  }

  Future<void> _onLoginWithCredentialsRequested(
    LoginWithCredentialsRequested event,
    Emitter<LoginState> emit,
  ) async {
    if (!state.enableValidation) {
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.initial,
          enableValidation: true,
          isValid: Formz.validate([state.email, state.password]),
        ),
      );
    }

    if (!state.isValid) {
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.failure,
          enableValidation: true,
          isValid: Formz.validate([state.email, state.password]),
        ),
      );
      return;
    }

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _authenticationRepository.logInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on LogInWithEmailAndPasswordFailure catch (e) {
      //TODO: Handle special exceptions:
      // user-token-expired,
      // user-disabled, and
      // operation-not-allowed.
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzSubmissionStatus.failure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }

  Future<void> _onLoginWithGoogleRequested(
    LoginWithGoogleRequested event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _authenticationRepository.logInWithGoogle();
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on LogInWithGoogleFailure catch (e) {
      //TODO: Handle special exceptions if needed.
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzSubmissionStatus.failure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }
}

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
