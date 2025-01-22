import 'package:flutter/material.dart';

///{@template simple_text_button}
/// An custom button with text
///
/// See also:
/// * [TextButton], which is incorporated into [SimpleTextButton]
/// {@endtemplate}
class SimpleTextButton extends StatelessWidget {
  ///{@macro simple_text_button}
  const SimpleTextButton({
    required this.labelText,
    super.key,
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
