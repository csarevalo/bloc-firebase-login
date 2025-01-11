// ignore_for_file: avoid_redundant_argument_values

import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:test/test.dart';

void main() {
  group('Email', () {
    const validEmails = <Email>[
      Email.dirty('fake@gmail.com'),
      Email.dirty('school@email.edu'),
    ];

    const invalidEmails = <Email>[
      Email.dirty(),
      Email.dirty(''),
      Email.dirty('incomplete@email'),
      Email.dirty('page.com'),
      Email.dirty('name'),
      Email.dirty('user@'),
      Email.dirty('@email.com'),
    ];

    test('validates valid emails correctly', () {
      expect(Formz.validate(validEmails), isTrue);
    });

    test('validates invalid emails correctly', () {
      expect(Formz.validate(invalidEmails), isFalse);
    });

    group('validator', () {
      test('works properly', () {
        expect(validEmails.first.isValid, isTrue);
        expect(validEmails.first.error, isNull);
        expect(invalidEmails.first.isValid, isFalse);
        expect(invalidEmails.first.error, isA<EmailValidationError>());
      });
    });
  });
}
