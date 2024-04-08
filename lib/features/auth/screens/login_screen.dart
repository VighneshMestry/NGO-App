import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/user_model.dart';
import '../controller/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  void signIn(WidgetRef ref, bool isStaff) {
    ref.read(authControllerProvider.notifier).signInWithGoogle(context, isStaff);
    setState(() {});
  }

  Stream<UserModel> getUserData(String uid) {
    return ref.read(authControllerProvider.notifier).getUserData(uid);
  }

  void logOut() {
    ref.read(authControllerProvider.notifier).logOut();
    setState(() {});
  }

  bool isStaff = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Skip',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 4.5,
                  left: 16,
                ),
                child: RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Hello \nThere',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 60,
                            fontWeight: FontWeight.w900),
                      ),
                      TextSpan(
                        text: '.',
                        style: TextStyle(
                            color: Colors.blue.shade700,
                            fontSize: 70,
                            fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 4),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8, left: 16, bottom: 8, right: 16),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 11),
                      child: CheckboxListTile(
                        title: const Text("Are you a Staff member"),
                        value: isStaff,
                        onChanged: (newValue) {
                          setState(() {
                            isStaff = newValue!;
                          });
                        },
                        controlAffinity: ListTileControlAffinity
                            .leading, //  <-- leading Checkbox
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          !isStaff
                              ? showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Warning'),
                                      content: const Text(
                                          "You will be logging in as a civil user", style: TextStyle(fontSize: 16)),
                                      actions: [
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .labelLarge,
                                          ),
                                          child: const Text('Back'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .labelLarge,
                                          ),
                                          child: const Text('Okay'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            signIn(ref, isStaff);
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                )
                              : signIn(ref, isStaff);
                        },
                        icon: Image.asset(
                          "assets/google.png",
                          width: 35,
                        ),
                        label: Text(
                          'Continue with Google',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.blue.shade700,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Don't have an account? Click above",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
