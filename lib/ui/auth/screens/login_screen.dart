import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notesapp/components/custom_button.dart';
import 'package:notesapp/components/custom_textfield.dart';
import 'package:notesapp/config/asset_paths.dart';
import 'package:notesapp/ui/auth/repository/auth_repository.dart';
import 'package:notesapp/ui/auth/screens/sign_up_screen.dart';
import 'package:notesapp/utils/validation.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController()..text = "suma@gmail.com";
    final passwordController = useTextEditingController()..text = "sumann";

    final formKey = useMemoized(() => GlobalKey<FormState>());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Image.asset(
                AssetPaths.notesImage,
              )),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Log in to use Notes App",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextField(
                labelText: "Email",
                validator: (p0) => Validators.email(p0),
                showRequired: true,
                controller: emailController,
                hintText: "Enter email here",
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextField(
                controller: passwordController,
                labelText: "Password",
                validator: (p0) => Validators.isRequired(p0),
                showRequired: true,
                hintText: "Enter password here",
              ),
              const SizedBox(
                height: 25,
              ),
              CustomButton(
                label: "Login ",
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    ref.read(authProvider).login(
                        email: emailController.text,
                        password: passwordController.text,
                        context: context);
                  }
                },
              ),
              const SizedBox(
                height: 15,
              ),
              const Center(
                  child: Text(
                "---- OR ----",
                textAlign: TextAlign.center,
              )),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const SignUpScreen(),
                    ));
                  },
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(text: "Don't have an Account  ",style:const TextStyle(color: Colors.black), children: [
                      const WidgetSpan(
                          alignment: PlaceholderAlignment.baseline,
                          baseline: TextBaseline.alphabetic,
                          child: SizedBox(width: 5),
                          style: TextStyle(color: Colors.black)),
                      TextSpan(
                          text: "Sign Up",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              decoration: TextDecoration.underline)),
                    ]),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
