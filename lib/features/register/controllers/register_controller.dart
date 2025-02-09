

import 'package:flutter/cupertino.dart';
import 'package:minner/core/models/Response_models.dart';
import 'package:minner/core/models/auth_models.dart';
import 'package:minner/core/providers/authProvider.dart';
import 'package:minner/core/services/authService/auth_service.dart';
import 'package:minner/core/widgets/custom_pop_up.dart';

class RegisterController extends ChangeNotifier{
  final TextEditingController emailController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late final AuthService authService;
  late final AuthProvider authProvider;

  RegisterController(){
    authService = AuthService(); // Initialize AuthService
    authProvider = authProvider;
  }

  void dispose(){
    emailController.dispose();
    confirmPasswordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    userNameController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
  }

  Future<ResponseResult> register(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final first_name = firstNameController.text.trim();
    final last_name = lastNameController.text.trim();
    final phone = phoneNumberController.text.trim();
    final user_name = userNameController.text.trim();

    // Create a LoginDetails instance
    final user = RegisterDetails(email: email, password: password, firstname: first_name,phone: phone,lastname: last_name,username: user_name);

    if (user.validateCredentials()) {
      // Call AuthProvider's login method
      ResponseResult response = await authProvider.register(context, user);

      if (response.status == ResponseStatus.success) {
        CustomPopup.show(context: context, type: PopupType.success, title: "Login Successful", message: response.message);

        return response;      } else {
        // Show error popup or snack bar

        CustomPopup.show(context: context,type: PopupType.error, title: "Login failed", message: response.message);
        return ResponseResult(status: response.status, message: response.message, data: response.data);
      }
    } else {
      // Show invalid credentials message

      CustomPopup.show(context: context, type:PopupType.error ,title: "Login failed", message: "invalid details");

      return  ResponseResult(status: ResponseStatus.failed, message:"invalid details",);
    }
  }
}


