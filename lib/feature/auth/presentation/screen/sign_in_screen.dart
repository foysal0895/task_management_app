import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanager/app/validators/app_fields_validators.dart';
import 'package:taskmanager/feature/auth/presentation/screen/sign_up_screen.dart';
import 'package:taskmanager/feature/auth/presentation/widgets/app_back_image.dart';
import 'package:taskmanager/feature/controller/main_nav_holder.dart';


import '../../../data/provider/auth_provider.dart';
import '../widgets/custom_filled_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String name = "/sign_in";

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  
  final TextEditingController _emailTEController =  TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final textSize = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          const AppBackGroundImage(),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _fromKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Get Started With",
                      style: textSize.textTheme.displaySmall,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _emailTEController,
                      decoration: InputDecoration(
                        hintText: "Email",
                        prefixIcon: const Icon(Icons.email, color: Colors.blue),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value)=>AppFieldsValidators.validateEmail(value),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordTEController,
                      decoration: InputDecoration(
                        hintText: "Password", // Fixed typo "PassWord"
                        prefixIcon: const Icon(
                          Icons.password,
                          color: Colors.blue,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value)=>AppFieldsValidators.validatePassword(value),
                    ),
                    const SizedBox(height: 16),
                    authProvider.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : CustomFilledButton(onPressed: _onTapSignInButton),
                    const SizedBox(height: 8),
                    Center(
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: _onTapForgotPassword,
                            child: const Text("Forgot Password?"),
                          ),
                          TextButton(
                            onPressed: _onTapSignUpButton,
                            child: const Text("Don't have an account? SignUp"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onTapSignInButton() async {
    if (!_fromKey.currentState!.validate()) return;
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final isSuccess = await authProvider.signIn(
      _emailTEController.text.trim(),
      _passwordTEController.text.trim(),
    );

    if (isSuccess) {
      if (mounted) {
        Navigator.pushReplacementNamed(context, MainNavHolder.name);
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Sign in failed. Please check your credentials.")),
        );
      }
    }
  }

  void _onTapForgotPassword() {}

  void _onTapSignUpButton() {
    Navigator.pushNamed(context, SignUpScreen.name);
  }
}




