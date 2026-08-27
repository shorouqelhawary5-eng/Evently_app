import 'package:evently_app/core/dialogUtils/dialog_utils.dart';
import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/core/routes_manager/routes_manager.dart';
import 'package:evently_app/core/utils/validation.dart';
import 'package:evently_app/core/widgets/custom_text_from_field.dart';
import 'package:evently_app/core/widgets/elevated_button.dart';
import 'package:evently_app/core/widgets/text_button_widget.dart';
import 'package:evently_app/firebase/firebase_services.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/provider/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
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
                    AppLocalizations.of(context)!.loginToYourAccount,
                    style: GoogleFonts.poppins(
                      textStyle: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),

                  SizedBox(height: 24.h),

                  CustomTextFromField(
                    controller: _emailController,
                    hintText: AppLocalizations.of(context)!.enterYourEmail,
                    prefixIcon: Icon(Icons.email),
                    validator: (input) => Validator.emailValidation(input!),
                  ),
                  SizedBox(height: 16.h),
                  CustomTextFromField(
                    controller: _passwordController,
                    hintText: AppLocalizations.of(context)!.enterYourPassword,
                    prefixIcon: Icon(Icons.lock),
                    validator: (input) => Validator.passwordValidation(input!),
                  ),

                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButtonWidget(
                        buttonText: AppLocalizations.of(
                          context,
                        )!.forgetPassword,
                      ),
                    ],
                  ),

                  SizedBox(height: 50.h),

                  ElevatedButtonWidget(
                    buttonText: AppLocalizations.of(context)!.login,
                    onClick: _login,
                  ),
                  SizedBox(height: 24.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.dontHaveAnAccount,
                        style: GoogleFonts.poppins(
                          textStyle: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),

                      TextButtonWidget(
                        buttonText: AppLocalizations.of(context)!.signUp,
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

  void _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    try {
      DialogUtils.showLoading(context, false);

      final credential = await FirebaseServices.login(
        email: _emailController.text,
        password: _passwordController.text,
      );
      final user = await FirebaseServices.getUserFromFirebase(
        credential.user!.uid,
      );
      context.read<UserProvider>().updateUserData(user!);

      DialogUtils.hideShowDialog(context);

      Navigator.pushReplacementNamed(context, RoutesManager.home);
    } on FirebaseAuthException catch (e) {
      DialogUtils.hideShowDialog(context);

      DialogUtils.showToastMessage(
        'chek your email or password',
        ColorsManager.red,
      );
    }
  }
}
