import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ngo_app/features/auth/repository/auth_repository.dart';
import 'package:ngo_app/features/widgets/custom_bottom_bar.dart';
import 'package:ngo_app/models/user_model.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
    authRepository: ref.watch(authRepositoryProvider),
    ref: ref,
  ),
);

final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChange;
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;

  AuthController({required AuthRepository authRepository, required Ref ref})
      : _ref = ref,
        _authRepository = authRepository,
        super(false);

  Stream<User?> get authStateChange => _authRepository.authStateChange;

  void signInWithGoogle(BuildContext context, bool isNgo) async {
    state = true;
    final user = await _authRepository.signInWithGoogle(isNgo);
    state = false;
    _ref.read(userProvider.notifier).update((state) => user);

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const CustomBottomNavigationBar()),
        (Route<dynamic> route) => false);
  }

  Stream<UserModel> getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }

  void logOut() async {
    _authRepository.logOut();
    _ref.read(userProvider.notifier).update((state) => null);
  }
}