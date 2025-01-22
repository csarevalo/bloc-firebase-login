import 'package:flutter/material.dart';

///{@template filled_text_button}
/// An custom filled button with text
///
/// See also:
/// * [TextButton], which is incorporated into [FilledTextButton]
/// {@endtemplate}
class FilledTextButton extends StatelessWidget {
  ///{@macro filled_text_button}
  const FilledTextButton({
    super.key,
    required this.labelText,
    this.onPressed,
    this.onLongPress,
  });

  /// Text shown at the center of the button.
  final String labelText;

  ///  The callback that is called when the button is tapped or
  ///  otherwise activated.
  ///
  /// If this callback and [onLongPress] are null, then
  /// the button will be disabled.
  final VoidCallback? onPressed;

  ///  The callback that is called when the button is long-pressed or
  ///  otherwise activated.
  ///
  /// If this callback and [onLongPress] are null, then
  /// the button will be disabled.
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: const Key('button'),
      onPressed: onPressed,
      onLongPress: onLongPress,
      child: Text(labelText),
    );
  }
}
