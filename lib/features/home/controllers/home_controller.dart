

import 'package:minner/core/models/user_details.dart';
import 'package:minner/core/providers/User_provider.dart';

class HomeViewController {
  late UserDetails userDetails;
  UserDetailsProvider userDetailsProvider;

  HomeViewController():userDetailsProvider = UserDetailsProvider()async{
    userDetails = await userDetailsProvider.getUserDetails(context);
  }


}