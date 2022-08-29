import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proweb_presentations_web/domain/providers/auth_provider.dart';
import 'package:proweb_presentations_web/domain/providers/directions_provider.dart';
import 'package:proweb_presentations_web/domain/providers/settings_provider.dart';
import 'package:proweb_presentations_web/ui/router/app_navigator.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DirectionsProvider>(
          create: (_) => DirectionsProvider(),
        ),
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider<SettingsProvider>(
          create: (_) => SettingsProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            surfaceTintColor: Color.fromARGB(255, 237, 11, 11),
          ),
          cardTheme: const CardTheme(
            color: Colors.white,

          ),
          inputDecorationTheme: InputDecorationTheme(hintStyle: TextStyle(color:const Color(0xff454545) )),
          scaffoldBackgroundColor: const Color(0xff454545),
        ),
        initialRoute: AppNavigator.initRoute,
        routes: AppNavigator.routes,
        onGenerateRoute: AppNavigator.generate,
      ),
    );
  }
}
