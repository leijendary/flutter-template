import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sample/models/auth.dart';
import 'package:flutter_sample/pages/main_page.dart';
import 'package:flutter_sample/providers/auth_provider.dart';
import 'package:flutter_sample/states/auth_state.dart';
import 'package:flutter_sample/utils/constants.dart';
import 'package:flutter_sample/utils/extensions.dart';
import 'package:flutter_sample/utils/validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignInPage extends HookConsumerWidget {
  SignInPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  static const name = "sign-in";
  static const path = "/sign-in";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signInForm = useState(SignInForm());
    final error = useState(<Key, String>{});
    final isLoading = useState(false);

    ref.listen<AuthState>(authProvider, (previous, next) {
      isLoading.value = next.isLoading;
      error.value = next.error;

      if (next.isSignedIn) {
        context.goNamed(MainPage.name);
      }
    });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => context.router.pop(),
        ),
        title: const Text("Sign in"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: Keys.phoneNumber,
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
              ],
              keyboardType: TextInputType.number,
              autofillHints: const [
                AutofillHints.telephoneNumber,
              ],
              validator: (value) => Validators.phoneNumber(
                context,
                value,
                error.value[Keys.phoneNumber],
              ),
              onChanged: (value) {
                signInForm.value.phoneNumber = value;
              },
            ),
            OutlinedButton(
              style: const ButtonStyle(enableFeedback: false),
              onPressed: isLoading.value
                  ? null
                  : () => _signIn(signInForm, error, context, ref),
              child: const Text("Sign In"),
            )
          ],
        ),
      ),
    );
  }

  void _signIn(
    ValueNotifier<SignInForm> signInForm,
    ValueNotifier<Map<Key, String>> errors,
    BuildContext context,
    WidgetRef ref,
  ) {
    errors.value.clear();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    signInForm.value.countryCode = "+31";
    signInForm.value.phoneNumber = "647088038";
    signInForm.value.pin = "123456";

    ref.read(authProvider.notifier).signIn(context, signInForm.value);
  }
}
