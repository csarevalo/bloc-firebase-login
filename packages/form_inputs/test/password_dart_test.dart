import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('Password', () {
    const validPasswords = <Password>[
      Password.dirty(r"Password1234567890~`!@#$%^&*()_-+={}[];;'<,>.?/"),
      Password.dirty(r"Test123`!@#$%^&*()_-+={}[];;'<,>.?/"),
      Password.dirty(r"123Test`!@#$%^&*()_-+={}[];;'<,>.?/"),
    ];

    const invalidPasswords = <Password>[
      Password.dirty('short'),
      Password.dirty('onlylowercase'),
      Password.dirty('ONLYUPPERCASE'),
      Password.dirty('ONLYletters'),
      Password.dirty('Letters123NoSymbols'),
      Password.dirty('Letters!@#NoNums'),
      Password.dirty('CannotHaveSpaces! 123&'),
      Password.dirty('     Test1!     '),
      Password.dirty(r"Test123`!@#$%^&*()_-+={}[];;'<,>.? "),
      Password.dirty(r"Password1234567890~`!@#$%^&*()_-+={}[];;'<,>.?/ "),
    ];

    test('validates valid passwords correctly', () {
      expect(Formz.validate(validPasswords), isTrue);
    });

    test('validates invalid passwords correctly', () {
      expect(Formz.validate(invalidPasswords), isFalse);
    });

    group('validator', () {
      test('works properly', () {
        expect(validPasswords.first.isValid, isTrue);
        expect(validPasswords.first.error, isNull);
        expect(invalidPasswords.first.isValid, isFalse);
        expect(invalidPasswords.first.error, isA<PasswordValidationError>());
      });
    });
  });
}
