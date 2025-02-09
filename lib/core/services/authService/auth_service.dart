
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:minner/core/models/auth_models.dart';
import 'package:minner/core/services/api_service.dart';

class AuthService {
  final AppApiConfig appApiConfig;
  late final ApiService apiService;

  AuthService({AppApiConfig? config}):appApiConfig = AppApiConfig(){
    apiService = ApiService(config: appApiConfig);
  }


  Future<Response> login(BuildContext context,String email, String password) async {
    Map<String, dynamic> data = {
      "email": email,
      "password": password,
    };
    final response = await apiService.post(context,"Authentication.php",data: data);
    return response;
  }


  Future<Response> register(BuildContext context,RegisterDetails registerDetails) async {
    Map<String, dynamic> data = {

        "firstname": registerDetails.firstname,
        "lastname": registerDetails.lastname,
        "username": registerDetails.username,
        "phone": registerDetails.phone,
        "email": registerDetails.email,
        "password": registerDetails.password
    };
    final response = await apiService.post(context,"createAccount.php",data: data);
    return response;
  }


}




