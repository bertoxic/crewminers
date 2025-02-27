import 'package:flutter/material.dart';
import 'package:minner/app/themes/dark_theme.dart';
import 'package:minner/app/themes/light_theme.dart';
import 'package:minner/core/providers/User_provider.dart';
import 'package:minner/core/providers/utility_provider.dart';
import 'package:minner/core/services/authService/auth_service.dart';
//import 'package:minner/core/utils/responsive/responsive_sizes.dart';
import 'package:minner/core/utils/responsive/responsivex_size.dart';
import 'package:minner/core/utils/shared_preference.dart';
import 'package:minner/routes/routes.dart';
import 'package:provider/provider.dart';
import 'core/providers/authProvider.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  final authService = AuthService();
  await SharedPreferencesUtil.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider.create(authService)),
        ChangeNotifierProvider(create: (_) => UtilityProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();


}

class _MyAppState extends State<MyApp> with ResponsiveStateMixin {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        // Initialize SizeConfig here if needed
        SizeConfig().init(context);

        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: "MinnerApp",
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.system,
          routerConfig: route,
        ).responsive(  // Using responsive builder
          mobile: (context, child) => child!,
          tablet: (context, child) => Center(child: child),
          desktop: (context, child) => Align(child: child),
        );
      },
    );
  }
}


