

import 'package:flutter/cupertino.dart';
import 'package:minner/core/models/Response_models.dart';
import 'package:minner/core/models/user_details.dart';
import 'package:minner/core/providers/User_provider.dart';
import 'package:minner/core/widgets/custom_pop_up.dart';
// HomeViewController
class HomeViewController {
  final UserDetails userDetails;
  final UserProvider userDetailsProvider;

  HomeViewController._({
    required this.userDetails,
    required this.userDetailsProvider,
  });

  static Future<HomeViewController?> create({
    UserProvider? provider,
    required BuildContext context,
  }) async {
    if (!context.mounted) return null;

    final userDetailsProvider = provider ?? UserProvider();

    try {
      final respResult = await userDetailsProvider.getUserDetails(context);

      if (!context.mounted) return null;

      if (respResult.status == ResponseStatus.failed ||
          userDetailsProvider.userDetails == null) {
        if (context.mounted) {
          CustomPopup.show(
              context: context,
              title: "Failed to Load Page",
              message: respResult.message
          );
        }
        return null;
      }

      return HomeViewController._(
        userDetails: userDetailsProvider.userDetails!,
        userDetailsProvider: userDetailsProvider,
      );
    } catch (e) {
      if (context.mounted) {
        CustomPopup.show(
            context: context,
            title: "Failed to Load Page",
            message: e.toString()
        );
      }
      return null;
    }
  }

  void dispose() {
    userDetailsProvider.dispose();
  }
}