import 'package:flutter/widgets.dart';
import 'package:new_project/screens/home_screens/widgets/generic_dialogue.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialoge(
      context: context,
      titile: 'Password Reset',
      content: 'We have sent you a password reset link',
      optionsBuilder: () => {'OK': false});
}
