

import 'package:flutter/cupertino.dart';
import 'package:minner/core/models/user_details.dart';
import 'package:minner/core/providers/User_provider.dart';
import 'package:minner/core/widgets/custom_pop_up.dart';

class HomeViewController {
  final UserDetails userDetails;
  final UserDetailsProvider? userDetailsProvider;

  // Private constructor
  HomeViewController._({
    required this.userDetails,
    required this.userDetailsProvider,
  });

  // Factory constructor that handles async initialization
  static Future<HomeViewController> create({
    UserDetailsProvider? provider,
    required BuildContext context,
  }) async {
    final userDetailsProvider = provider ?? UserDetailsProvider();

    try {
      final respResult = await userDetailsProvider.getUserDetails(context);

      return HomeViewController._(
        userDetails: UserDetails.fromJSON(respResult.data),
        userDetailsProvider: userDetailsProvider,
      );
    } catch (e) {
      CustomPopup.show(context: context, title: "Failed to Load Page", message: "Something went wrong");
      print('Error creating HomeViewController: $e');
      rethrow;
    }
  }
}