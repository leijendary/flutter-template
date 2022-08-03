import 'package:flutter/material.dart';

class AuthState {
  AuthState({
    this.isSignedIn = false,
    this.isLoading = false,
    this.shouldConfirm = false,
    this.error = const {},
  });

  bool isSignedIn;
  bool isLoading;
  bool shouldConfirm;
  Map<Key, String> error;
}
