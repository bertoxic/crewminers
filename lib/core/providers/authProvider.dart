import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:minner/core/models/Response_models.dart';
import 'package:minner/core/services/authService/auth_service.dart';
import 'package:minner/core/utils/shared_preference.dart';
import 'package:minner/core/widgets/custom_pop_up.dart';
import 'package:minner/features/login/models/login_model.dart';
import 'package:minner/core/models/auth_models.dart';
class AuthProvider extends ChangeNotifier {
  String? _token;
  final AuthService _authService;
  bool _isLoading = false;
  String? _errorMessage;
  SharedPreferencesUtil prefs=  SharedPreferencesUtil();

  // Private constructor for dependency injection
  AuthProvider._(this._authService);

  // Factory method for creating an instance
  static AuthProvider create(AuthService authService) {
    return AuthProvider._(authService);
  }

  // Getters for UI consumption
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Method to handle login
  Future<ResponseResult> login(BuildContext context, LoginDetails loginDetails) async {
    // Start loading
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Call AuthService's login method
      Response response = await _authService.login(context, loginDetails.email, loginDetails.password);
      SharedPreferencesUtil.remove("auth_token");
      print("removed token>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");

      final data = Map<String, dynamic>.from(response.data as Map<String, dynamic>);
      _token = data['token'];

      SharedPreferencesUtil.saveString("auth_token",_token??"");
      notifyListeners();
      String? tokenstored = await SharedPreferencesUtil.getString("auth_token") ;
      print("obtained token>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> as ${tokenstored}");
      // Check for HTTP status and handle responses
      if (response.statusCode == 200) {
        // Parse and store the token or any relevant data
        final data = Map<String, dynamic>.from(response.data as Map<String, dynamic>);
        _token = data['token']; // Assuming the response contains a 'token'

        notifyListeners();
        return ResponseResult(
          status: ResponseStatus.success,
          message: 'Login Successful',
          data: data,
        );
      } else {
        // Handle unexpected status codes
        _errorMessage = response.data['message'] ?? 'Login failed. Please try again.';
        notifyListeners();
        return ResponseResult(
          status: ResponseStatus.failed,
          message: _errorMessage!,
        );
      }
    } on DioException catch (dioError) {
      // Handle Dio-specific errors
      if (dioError.response != null) {
        // Server responded with an error
        _errorMessage = dioError.response?.data['message'] ?? 'An error occurred during login.';
      } else {
        // Connection error or other issues
        _errorMessage = 'Unable to connect to the server. Please check your internet connection.';
      }
      notifyListeners();
      return ResponseResult(
        status: ResponseStatus.failed,
        message: _errorMessage!,
      );
    } catch (e) {
      // Handle any other errors
      _errorMessage = '';
      CustomPopup.show(type:PopupType.error,title: "title", message: "An unexpected error occurred. Please try again later.", context: context);
      notifyListeners();
      return ResponseResult(
        status: ResponseStatus.failed,
        message: _errorMessage!,
      );
    } finally {
      // Stop loading
      _isLoading = false;
      notifyListeners();
    }
  }
  Future<ResponseResult> register(BuildContext context, RegisterDetails registerDetails) async {
    // Start loading
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Call AuthService's login method
      Response response = await _authService.register(context, registerDetails);
      // Check for HTTP status and handle responses
      if (response.statusCode == 200) {
        // Parse and store the token or any relevant data
        final data = Map<String, dynamic>.from(response.data as Map<String, dynamic>);

        _token = data['token'];
          SharedPreferencesUtil.saveString("auth_token",_token??"");
        notifyListeners();
        return ResponseResult(
          status: ResponseStatus.success,
          message: 'Login Successful',
          data: data,
        );
      } else {
        // Handle unexpected status codes
        _errorMessage = response.data['message'] ?? 'registering failed. Please try again.';
        notifyListeners();
        return ResponseResult(
          status: ResponseStatus.failed,
          message: _errorMessage!,
        );
      }
    } on DioException catch (dioError) {
      // Handle Dio-specific errors
      if (dioError.response != null) {
        // Server responded with an error
        _errorMessage = dioError.response?.data['message'] ?? 'An error occurred during login.';
      } else {
        // Connection error or other issues
        _errorMessage = 'Unable to connect to the server. Please check your internet connection.';
      }
      notifyListeners();
      return ResponseResult(
        status: ResponseStatus.failed,
        message: _errorMessage!,
      );
    } catch (e) {
      // Handle any other errors
      _errorMessage = '';
      CustomPopup.show(type:PopupType.error,title: "title", message: "An unexpected error occurred. Please try again later.", context: context);
      notifyListeners();
      return ResponseResult(
        status: ResponseStatus.failed,
        message: _errorMessage!,
      );
    } finally {
      // Stop loading
      _isLoading = false;
      notifyListeners();
    }
  }
}
