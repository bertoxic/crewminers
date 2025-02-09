import 'package:flutter/material.dart';
import 'package:minner/core/models/Response_models.dart';
import 'package:minner/core/providers/authProvider.dart';
import 'package:minner/core/services/authService/auth_service.dart';
import 'package:minner/features/login/models/login_model.dart';
import 'package:minner/core/widgets/custom_pop_up.dart';

class LoginController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late final AuthService authService;
  late final AuthProvider authProvider;

  LoginController() {
    authService = AuthService(); // Initialize AuthService
    authProvider = AuthProvider.create(authService); // Pass to AuthProvider
  }

  void dispose(){
  emailController.dispose();
  passwordController.dispose();

  }

  Future<ResponseResult> login(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // Create a LoginDetails instance
    final user = LoginDetails(email: email, password: password);

    if (user.validateCredentials()) {
      // Call AuthProvider's login method
      ResponseResult response = await authProvider.login(context, user);

      if (response.status == ResponseStatus.success) {
        CustomPopup.show(context: context, type: PopupType.success, title: "Login Successful", message: response.message);

        return response;      } else {
        // Show error popup or snack bar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.message)),
        );
        CustomPopup.show(context: context,type: PopupType.error, title: "Login failed", message: response.message);
        return ResponseResult(status: response.status, message: response.message, data: response.data);
      }
    } else {
      // Show invalid credentials message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid Credentials')),
      );
      CustomPopup.show(context: context, type:PopupType.error ,title: "Login failed", message: "invalid details");

      return  ResponseResult(status: ResponseStatus.failed, message:"invalid details",);
    }
  }
}
