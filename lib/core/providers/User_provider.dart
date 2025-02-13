
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:minner/core/models/Response_models.dart';
import 'package:minner/core/models/user_details.dart';
import 'package:minner/core/services/api_service.dart';
class UserDetailsProvider extends ChangeNotifier{
  late UserDetails userDetails;
  late ApiService apiService;
  late AppApiConfig appApiConfig;

  UserDetailsProvider(){
    appApiConfig = AppApiConfig();
    apiService = ApiService(config: appApiConfig);
  }

 Future <ResponseResult> getUserDetails(BuildContext context) async {
          Response resp =  await apiService.get(context, "getUserDetails.php");
          if (resp.statusCode != 200){
         ResponseResult  respResult= ResponseResult(
              status: ResponseStatus.failed,
              message: resp.statusMessage??"",
              data: resp.data
            );

         return respResult;
          }
          ResponseResult resResult = ResponseResult(status: ResponseStatus.failed, message: resp.statusMessage??"",data: resp.data);

   return resResult;
 }

}