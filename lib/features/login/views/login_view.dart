import 'dart:math';

import 'package:flutter/material.dart';
import 'package:minner/core/models/Response_models.dart';
import 'package:minner/core/utils/responsive/responsivex_size.dart';
import 'package:minner/core/widgets/custom_textfield.dart';
import 'package:minner/features/login/controllers/login_controller.dart';
import 'package:minner/features/register/views/register_view.dart';
import 'package:minner/routes/routes.dart';

class SignInScreen extends StatelessWidget {
   SignInScreen({Key? key}) : super(key: key);
final LoginController _loginController = LoginController();
   final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundDecoration(),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const WelcomeHeader(),
                     SizedBox(height: 40.h),
                    SignInCard(loginController: _loginController, formKey: _formKey,),
                     SizedBox(height: 24.h),
                    const SignUpLink(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BackgroundDecoration extends StatelessWidget {
  const BackgroundDecoration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFFF7B54),
                Color(0xFFFFB26B),
              ],
            ),
          ),
        ),
        Positioned(
          top: -100.h,
          right: -100.w,
          child: Container(
            width: 200.w,
            height: 200.h,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0x1AFFFFFF),
            ),
          ),
        ),
        Positioned(
          bottom: -50.w,
          left: -50.h,
          child: Container(
            width: 150.w,
            height: 150.h,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0x1AFFFFFF),
            ),
          ),
        ),
      ],
    );
  }
}

class WelcomeHeader extends StatelessWidget {
  const WelcomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Welcome Back!',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.5,
          ),
        ),
         SizedBox(height: 8.h),
        Container(
          padding:  EdgeInsets.symmetric(horizontal: SizeConfig.getResponsiveValue(
            mobile: 24.0,
            tablet: 30.0,
            desktop: 40.0,
          ), vertical: SizeConfig.getResponsiveValue(
            mobile: 8.0,
            tablet: 12.0,
            desktop: 16.0,
          )),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'Sign in to continue',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}

class SignInCard extends StatelessWidget {
  final LoginController loginController;
  final GlobalKey<FormState> formKey;

   SignInCard({
    Key? key,
    required this.loginController,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SignInForm(loginController: loginController),
             SizedBox(height: 24.h),
            const ForgotPasswordButton(),
             SizedBox(height: 32.h),
            SignInButton(
              loginController: loginController,
              formKey: formKey,
            ),
          ],
        ),
      ),
    );
  }
}

class SignInForm extends StatelessWidget {
  final LoginController loginController;

  const SignInForm({
    Key? key,
    required this.loginController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Email',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
         SizedBox(height: 8.h),
        TextFormField(
          controller: loginController.emailController,
          decoration: _buildInputDecoration(
            hintText: 'Enter your email',
            icon: Icons.email_outlined,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            return null;
          },
        ),
        const SizedBox(height: 24),
        const Text(
          'Password',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: loginController.passwordController,
          obscureText: true,
          decoration: _buildInputDecoration(
            hintText: 'Enter your password',
            icon: Icons.lock_outline,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            return null;
          },
        ),
      ],
    );
  }

  InputDecoration _buildInputDecoration({
    required String hintText,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.black38),
      filled: true,
      fillColor: const Color(0xFFF8F9FA),
      prefixIcon: Icon(icon, color: const Color(0xFFFF7B54)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFFF7B54), width: 2),
      ),
    );
  }
}

class SignInButton extends StatelessWidget {
  final LoginController loginController;
  final GlobalKey<FormState> formKey;

  const SignInButton({
    Key? key,
    required this.loginController,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [
            Color(0xFFFF7B54),
            Color(0xFFFFB26B),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF7B54).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () async {
          if (formKey.currentState?.validate() ?? false) {
            final success = await loginController.login(context);
            if (success.status == ResponseStatus.success && context.mounted) {
              // Navigate to home screen or dashboard
              Navigator.pushReplacementNamed(context, '/home');
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: const Text(
          'Sign In',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFFFF7B54),
        ),
        child: const Text(
          'Forgot Password?',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}


class SignUpLink extends StatelessWidget {
  const SignUpLink({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Don\'t have an account? ',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
          },
          child: const Text(
            'Sign Up',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}