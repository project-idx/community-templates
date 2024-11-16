import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

typedef AuthState = ({User? user, String? token});

class Auth extends ValueNotifier<AuthState> {
  bool get isLoggedIn => value.user != null && value.token != null;
  User? get currentUser => value.user;
  String? get token => value.token;

  StreamSubscription? _cleanup;

  Future<void> init() async {
    final user = FirebaseAuth.instance.currentUser;
    final token = await user?.token;
    value = (user: user, token: token);
    _cleanup = FirebaseAuth.instance.authStateChanges().listen((user) async {
      final token = await user?.token;
      value = (user: user, token: token);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _cleanup?.cancel();
  }

  static Auth instance = Auth((user: null, token: null));

  Auth(super.value);
}

extension on User {
  Future<String?> get token async {
    try {
      return await getIdToken();
    } catch (_) {
      return null;
    }
  }
}
