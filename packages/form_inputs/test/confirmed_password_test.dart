import 'package:form_inputs/form_inputs.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('ConfirmedPassword', () {
    const password = Password.dirty(
      r"Password1234567890~`!@#$%^&*()_-+={}[];;'<,>.?/",
    );
    const invalidPassword = Password.dirty('IncorrectPassword123!');
    group('validator', () {
      test('validates incorrect password correctly', () {
        final confirmedPassword = ConfirmedPassword.dirty(
          password: password.value,
          value: invalidPassword.value,
        );
        expect(
          confirmedPassword.isValid,
          isFalse,
        );
        expect(
          confirmedPassword.error,
          isA<ConfirmedPasswordValidationError>(),
        );
      });
      test('validates correct password correctly', () {
        final confirmedPassword = ConfirmedPassword.dirty(
          password: password.value,
          value: password.value,
        );
        expect(
          confirmedPassword.isValid,
          isTrue,
        );
        expect(
          confirmedPassword.error,
          isNull,
        );
      });
    });
  });
}
