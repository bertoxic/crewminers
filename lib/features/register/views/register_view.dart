// login_screen.dart
import 'package:flutter/material.dart';
import 'package:minner/core/widgets/custom_textfield.dart';
import 'package:minner/features/register/controllers/register_controller.dart';

class RegisterScreen extends StatelessWidget {
   RegisterScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
   final RegisterController _registerController = RegisterController();

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
              child: Column(
                children:  [
                  const LogoHeader(),
                  SizedBox(height: 40),
                  SignUpCard(controllerReg: _registerController, formKey: _formKey,),
                  const SizedBox(height: 24),
                  SignInLink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GradientBackground extends StatelessWidget {
  final Widget child;
  const GradientBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xFFFF7B54),
            Colors.white,
          ],
        ),
      ),
      child: child,
    );
  }
}

class LogoHeader extends StatelessWidget {
  const LogoHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'LOGO',
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

class SignUpCard extends StatelessWidget {
  final RegisterController controllerReg;
  final GlobalKey<FormState> formKey;
   SignUpCard({Key? key, required this.controllerReg, required this.formKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: CardDecoration.defaultDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          SignUpHeader(),
          SizedBox(height: 32),
          SignUpForm(registerController: controllerReg, formKey: formKey,),
        ],
      ),
    );
  }
}

class CardDecoration {
  static BoxDecoration get defaultDecoration => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 10,
        offset: const Offset(0, 5),
      ),
    ],
  );
}

class SignUpHeader extends StatelessWidget {
  const SignUpHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Create Account',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Create an account so you can explore all the existing offers',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

class SignUpForm extends StatelessWidget {
  final RegisterController registerController;
  final GlobalKey<FormState> formKey;
   SignUpForm({Key? key, required this.registerController, required this.formKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(

        children: [
          FormInput(
            registerController: registerController.firstNameController,
            hintText: 'First Name',
            icon: Icons.person_outline,
            fieldName: 'first_name',
          ),
          const SizedBox(height: 16),
          FormInput(
            registerController: registerController.lastNameController,
            hintText: 'Last Name',
            icon: Icons.email_outlined,
            fieldName: 'last_name',
          ),  const SizedBox(height: 16),
          FormInput(
            registerController: registerController.userNameController,
            hintText: 'User Name',
            icon: Icons.email_outlined,
            fieldName: 'Use_name',
          ),  const SizedBox(height: 16),
          FormInput(
            registerController: registerController.phoneNumberController,
            hintText: 'Phone',
            icon: Icons.email_outlined,
            fieldName: 'phone',
          ),  const SizedBox(height: 16),
          FormInput(
            registerController: registerController.emailController,
            hintText: 'Email',
            icon: Icons.email_outlined,
            fieldName: 'email',
          ),
          const SizedBox(height: 16),
          FormInput(
            registerController: registerController.passwordController,
            hintText: 'Password',
            icon: Icons.lock_outline,
            fieldName: 'password',
            isPassword: true,
          ),
          const SizedBox(height: 16),
          FormInput(
            registerController: registerController.confirmPasswordController,

            hintText: 'Confirm Password',
            icon: Icons.lock_outline,
            fieldName: 'confirm_password',
            isPassword: true,
          ),
          const SizedBox(height: 32),
          SignUpButton(
            regController: registerController,
            formKey: formKey,
          ),
        ],
      ),
    );
  }
}

class FormInput extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final String fieldName;
  final bool isPassword;
  final TextEditingController registerController;

  const FormInput({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.fieldName,
    required this.registerController,
    this.isPassword = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: registerController,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
        prefixIcon: Icon(icon, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      fieldName: fieldName,
    );
  }
}

class SignUpButton extends StatelessWidget {
  final RegisterController regController;
  const SignUpButton({super.key, required  this.regController, required GlobalKey<FormState> formKey});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          regController.register(context,);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF7B54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: const Text(
          'Sign up',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class SignInLink extends StatelessWidget {
  const SignInLink({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already have an account? ',
          style: TextStyle(color: Colors.black54),
        ),
        GestureDetector(
          onTap: () {},
          child: const Text(
            'Sign in',
            style: TextStyle(
              color: Color(0xFFFF7B54),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}