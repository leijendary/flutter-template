import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Validators {
  Validators._();

  static String? phoneNumber({
    required BuildContext context,
    String? value,
    String? error,
  }) {
    final localizations = AppLocalizations.of(context)!;

    if (value == null || value.isEmpty) {
      return localizations.requiredField;
    }

    if (value.length < 9) {
      return localizations.phoneNumberMinimum;
    }

    return error;
  }
}
