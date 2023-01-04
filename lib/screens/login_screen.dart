import 'package:document_editor/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../colors.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  void signInWithGoogle(WidgetRef ref){
    ref.read(authRepositoryProvider).signInWithGoogle();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
            onPressed: () => signInWithGoogle(ref),
            icon: Image.asset(
              'assets/images/g-logo-2.png',
              height: 20,
            ),
            label: const Text("Login with Google", style: TextStyle( color: kBlackColor),),
        style: ElevatedButton.styleFrom(
          backgroundColor: kWhiteColor,
          minimumSize: const Size(150, 50)
        ),),
      ),
    );
  }
}
