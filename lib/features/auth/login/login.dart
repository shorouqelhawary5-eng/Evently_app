import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/core/routes_manager/routes_manager.dart';
import 'package:evently_app/core/utils/validation.dart';
import 'package:evently_app/core/widgets/custom_text_from_field.dart';
import 'package:evently_app/core/widgets/elevated_button.dart';
import 'package:evently_app/core/widgets/text_button_widget.dart';
import 'package:evently_app/features/auth/register/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void initState() {
    // TODO: implement initState
    super.initState();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,

                children: [
                  Image.asset(ImageManager.logo),
                  SizedBox(height: 47.h),
                  Text(
                    'Login to your account',
                    style: GoogleFonts.poppins(
                      textStyle: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),

                  SizedBox(height: 24.h),

                  CustomTextFromField(
                    hintText: 'Enter your email',
                    prefixIcon: Icon(Icons.email),
                    validator: (input) => Validator.emailValidation(input!),
                  ),
                  SizedBox(height: 16.h),
                  CustomTextFromField(
                    hintText: 'Enter your password',
                    prefixIcon: Icon(Icons.lock),
                    validator: (input) => Validator.passwordValidation(input!),
                  ),

                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButtonWidget(buttonText: 'forget password?'),
                    ],
                  ),

                  SizedBox(height: 50.h),

                  ElevatedButtonWidget(buttonText: 'Login', onClick: _login),
                  SizedBox(height: 24.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don’t have an account ?',
                        style: GoogleFonts.poppins(
                          textStyle: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),

                      TextButtonWidget(
                        buttonText: 'Sign up',
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            RoutesManager.register,
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
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

  void _login() {
    if (_formKey.currentState!.validate() == false) return;
  }
}
