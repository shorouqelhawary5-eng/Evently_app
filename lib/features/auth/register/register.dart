import 'package:evently_app/core/dialogUtils/dialog_utils.dart';
import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/core/routes_manager/routes_manager.dart';
import 'package:evently_app/core/utils/validation.dart';
import 'package:evently_app/core/widgets/custom_text_from_field.dart';
import 'package:evently_app/core/widgets/elevated_button.dart';
import 'package:evently_app/core/widgets/text_button_widget.dart';
import 'package:evently_app/features/auth/login/login.dart';
import 'package:evently_app/firebase/firebase_services.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                crossAxisAlignment: CrossAxisAlignment.stretch,

                children: [
                  Image.asset(ImageManager.logo),
                  SizedBox(height: 40.h),
                  Text(
                    AppLocalizations.of(context)!.createYourAccount,

                    style: GoogleFonts.poppins(
                      textStyle: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),

                  SizedBox(height: 23.h),

                  CustomTextFromField(
                    hintText: AppLocalizations.of(context)!.enterYourName,
                    prefixIcon: Icon(Icons.person),
                    controller: _nameController,
                    validator: (input) => Validator.nameValidation(input!),
                  ),
                  SizedBox(height: 14.h),
                  CustomTextFromField(
                    hintText: AppLocalizations.of(context)!.enterYourEmail,
                    prefixIcon: Icon(Icons.email),
                    controller: _emailController,
                    validator: (input) => Validator.emailValidation(input!),
                  ),
                  SizedBox(height: 14.h),
                  CustomTextFromField(
                    hintText: AppLocalizations.of(context)!.enterYourPassword,
                    prefixIcon: Icon(Icons.lock),
                    controller: _passwordController,
                    validator: (input) => Validator.passwordValidation(input!),
                  ),
                  SizedBox(height: 14.h),
                  CustomTextFromField(
                    hintText: AppLocalizations.of(context)!.confirmYourPassword,
                    prefixIcon: Icon(Icons.lock),
                    controller: _confirmPasswordController,
                    validator: (input) => Validator.confirmPasswordValidation(
                      input!,
                      _passwordController,
                    ),
                  ),

                  SizedBox(height: 47.h),

                  ElevatedButtonWidget(
                    buttonText: AppLocalizations.of(context)!.signUp,
                    onClick: _register,
                  ),
                  SizedBox(height: 22.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.alreadyHaveAnAccount,
                        style: GoogleFonts.poppins(
                          textStyle: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),

                      TextButtonWidget(
                        buttonText: AppLocalizations.of(context)!.signIn,
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
                    AppLocalizations.of(context)!.or,
                    style: GoogleFonts.poppins(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24.h),
                  ElevatedButtonWidget(
                    buttonText: AppLocalizations.of(context)!.loginWithGoogle,
                    buttonColor: ColorsManager.whiteFF,
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

  void _register() async {
    try {
      DialogUtils.showLoading(context, false);
      final user = await FirebaseServices.register(
        email: _emailController.text,
        password: _passwordController.text,
      );
      UserModel userModel = UserModel(
        id: user.user!.uid,
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        favoriteEventId: [],
      );
      await FirebaseServices.addUserinFirebase(userModel);
      DialogUtils.hideShowDialog(context);
      DialogUtils.showToastMessage(
        'Sucssesfully Regesteration',
        ColorsManager.green,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } on FirebaseAuthException catch (e) {
      DialogUtils.hideShowDialog(context);

      if (e.code == 'weak-password') {
        DialogUtils.showToastMessage(
          'The password provided is too weak.',
          ColorsManager.red,
        );
      } else if (e.code == 'email-already-in-use') {
        DialogUtils.showToastMessage(
          'The account already exists for that email',
          ColorsManager.red,
        );
      }
    } catch (e) {
      DialogUtils.showToastMessage('$e', ColorsManager.red);
    }
  }
}
