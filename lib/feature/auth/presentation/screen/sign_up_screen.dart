import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanager/app/validators/app_fields_validators.dart';
import 'package:taskmanager/feature/auth/presentation/screen/sign_in_screen.dart';
import '../../../data/provider/auth_provider.dart';
import '../widgets/app_back_image.dart';
import '../widgets/custom_filled_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const String name="/sign_up";
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          AppBackGroundImage(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Join With Us",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const SizedBox(height: 12,),
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
                  const SizedBox(height: 12,),
                  TextFormField(
                    controller: _passwordTEController,
                    decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: const Icon(Icons.password, color: Colors.blue),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (value)=> AppFieldsValidators.validatePassword(value),
                  ),
                  const SizedBox(height: 12),
                 authProvider.isLoading
                  ? CircularProgressIndicator()
                  : CustomFilledButton(onPressed:_onTapSignUpButton,),
                  const SizedBox(height: 12,),
                  Center(
                    child: TextButton(
                      onPressed: _onTapSignInButton,
                      child: const Text("Already have an account? SignIn"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
  void _onTapSignUpButton() async {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final success = await authProvider.signUp(
      _emailTEController.text.trim(),
      _passwordTEController.text.trim(),
    );

    if (success) {
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          SignInScreen.name,
          (_) => false,
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Something went wrong")),
        );
      }
    }
  }

  void _onTapSignInButton() {
    Navigator.pop(context);
  }
}
