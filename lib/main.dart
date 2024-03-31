import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ngo_app/features/auth/controller/auth_controller.dart';
import 'package:ngo_app/features/auth/screens/login_screen.dart';
import 'package:ngo_app/features/widgets/custom_bottom_bar.dart';
import 'package:ngo_app/firebase_options.dart';
import 'package:ngo_app/models/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

// ignore: must_be_immutable
class MyApp extends ConsumerWidget {
  MyApp({super.key});

  UserModel? userModel;

  void getData(WidgetRef ref, User data) async {
    userModel = await ref
        .watch(authControllerProvider.notifier)
        .getUserData(data.uid)
        .first;
    ref.read(userProvider.notifier).update((state) => userModel);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(authStateChangeProvider).when(
          data: (data) {
            if (data != null) {
              getData(ref, data);
              return const MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'NGO App',
                home: CustomBottomNavigationBar(currentPage: 0));
            } else {
              return const MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'NGO App',
                // theme: ThemeData(appBarTheme: AppBarTheme(color: Colors.black), scaffoldBackgroundColor: Colors.black),
                home: LoginScreen(),
              );
            }
          },
          error: (error, stackTrace) => const Text("Error"),
          loading: () => const CircularProgressIndicator(),
        );
    // );
  }
}
