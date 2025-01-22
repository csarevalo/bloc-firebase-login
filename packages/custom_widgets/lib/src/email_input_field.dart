/// @docImport 'package:flutter/material.dart';
library;

import 'package:flutter/material.dart';

/// {@template email_input_field}
/// Creates a widget for a email input.
///
/// See also:
/// * [TextField], which is incorporated into [EmailInputField].
/// {@endtemplate}
class EmailInputField extends StatelessWidget {
  /// {@macro email_input_field}
  const EmailInputField({
    super.key,
    this.onChanged,
    this.showErrorText = false,
    this.labelText,
    this.errorText,
    this.hintText,
  });

  /// {@macro flutter.widgets.editableText.onChanged}
  final void Function(String)? onChanged;

  /// Shows [errorText] when [showErrorText] is true.
  /// Otherwise, [showErrorText] is hidden
  final bool showErrorText;

  /// Optional text that describes the input field.
  ///
  /// {@macro flutter.material.inputDecoration.label}
  final String? labelText;

  /// Text that indicates an erroneous input and is shown only
  /// if [showErrorText] is true.
  ///
  /// See also:
  ///
  /// * [InputDecoration.errorText], which is used to show the errorText.
  final String? errorText;

  /// Text that suggests what sort of input the field accepts.
  ///
  /// See also:
  /// * [InputDecoration.hintText], which is used to show the hintText.
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        errorText: showErrorText ? errorText : null,
      ),
    );
  }
}
