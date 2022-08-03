import 'package:flutter/material.dart';
import 'package:flutter_sample/utils/extensions.dart';

class Validators {
  Validators._();

  static String? phoneNumber(
    BuildContext context,
    String? value,
    String? error,
  ) {
    if (value == null || value.isEmpty) {
      return context.localizations.requiredField;
    }

    if (value.length < 9) {
      return context.localizations.phoneNumberMinimum;
    }

    return error;
  }
}
