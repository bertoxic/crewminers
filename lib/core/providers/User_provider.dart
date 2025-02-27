
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:minner/core/models/Response_models.dart';
import 'package:minner/core/models/user_details.dart';
import 'package:minner/core/services/api_service.dart';
class UserProvider extends ChangeNotifier {
  UserDetails? userDetails; // Make nullable
  final ApiService apiService;
  bool isLoading = false;
  String? error;

  UserProvider({ApiService? apiService})
      : apiService = apiService ?? ApiService(config: AppApiConfig());

  Future<ResponseResult> getUserDetails(BuildContext context) async {
    if (!context.mounted) {
      return ResponseResult(
          status: ResponseStatus.failed,
          message: "Context is not mounted",
          data: null
      );
    }

    try {
      isLoading = true;
      notifyListeners();

      final Response resp = await apiService.get(context, "getUserDetails.php");

      if (!context.mounted) {
        return ResponseResult(
            status: ResponseStatus.failed,
            message: "Context was disposed during request",
            data: null
        );
      }

      if (resp.statusCode != 200 || resp.data == null) {
        error = resp.statusMessage ?? "Failed to get user details";
        return ResponseResult(
            status: ResponseStatus.failed,
            message: error!,
            data: resp.data
        );
      }

      if (resp.data?["data"] == null) {
        error = "Invalid data format received";
        return ResponseResult(
            status: ResponseStatus.failed,
            message: error!,
            data: null
        );
      }

      userDetails = UserDetails.fromJSON(resp.data!["data"]);
      error = null;

      return ResponseResult(
          status: ResponseStatus.success,
          message: resp.statusMessage ?? "Success",
          data: resp.data
      );

    } catch (e) {
      error = e.toString();
      return ResponseResult(
          status: ResponseStatus.failed,
          message: error!,
          data: null
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    // Clean up any resources here
    super.dispose();
  }
}