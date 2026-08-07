import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/core/routes_manager/routes_manager.dart';
import 'package:evently_app/core/utils/validation.dart';
import 'package:evently_app/core/widgets/custom_text_from_field.dart';
import 'package:evently_app/core/widgets/elevated_button.dart';
import 'package:evently_app/core/widgets/text_button_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _ConfirmPasswordController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _ConfirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _ConfirmPasswordController.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Image.asset(ImageManager.logo),
                  SizedBox(height: 40.h),
                  Text(
                    'Create your account',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                      textStyle: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),

                  SizedBox(height: 23.h),

                  CustomTextFromField(
                    hintText: 'Enter your name',
                    prefixIcon: Icon(Icons.person),
                    controller: _nameController,
                    validator: (input) => Validator.nameValidation(input!),
                  ),
                  SizedBox(height: 14.h),
                  CustomTextFromField(
                    hintText: 'Enter your email',
                    prefixIcon: Icon(Icons.email),
                    controller: _emailController,
                    validator: (input) => Validator.emailValidation(input!),
                  ),
                  SizedBox(height: 14.h),
                  CustomTextFromField(
                    hintText: 'Enter your password',
                    prefixIcon: Icon(Icons.lock),
                    controller: _passwordController,
                    validator: (input) => Validator.passwordValidation(input!),
                  ),
                  SizedBox(height: 14.h),
                  CustomTextFromField(
                    hintText: 'Confirm your password',
                    prefixIcon: Icon(Icons.lock),
                    controller: _ConfirmPasswordController,
                    validator: (input) => Validator.confirmPasswordValidation(
                      input!,
                      _passwordController,
                    ),
                  ),

                  SizedBox(height: 47.h),

                  ElevatedButtonWidget(
                    buttonText: 'Sign up',
                    onClick: _register,
                  ),
                  SizedBox(height: 22.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: GoogleFonts.poppins(
                          textStyle: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),

                      TextButtonWidget(
                        buttonText: 'Sign in',
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            RoutesManager.login,
                          );
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),
                  Text(
                    'Or',
                    style: GoogleFonts.poppins(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24.h),
                  ElevatedButtonWidget(
                    buttonText: 'Login with Google',
                    buttonColor: ColorsManager.white,
                    buttonTextColor: ColorsManager.blue,
                    icon: Image.asset(IconManager.google),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _register() {
    if (_formKey.currentState!.validate() == false) return;
  }
}
