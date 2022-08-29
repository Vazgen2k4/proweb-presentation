import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proweb_presentations_web/domain/providers/auth_provider.dart';
import 'package:proweb_presentations_web/ui/router/app_navigator.dart';

class AppTitleWidget extends StatelessWidget {
  const AppTitleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasAuth = context.watch<AuthProvider>().hasAuth;
    final _icon = hasAuth ? Icons.settings : Icons.login;
    final _nextRoute = hasAuth ? AppRoutes.settings : AppRoutes.auth;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                height: 1.23,
                fontFamily: 'Inter',
                fontSize: 22,
              ),
              text: 'PROWEB '.toUpperCase(),
              children: const <TextSpan>[
                TextSpan(
                  text: 'ОТКРЫТЫЕ УРОКИ',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, _nextRoute),
            icon: Icon(_icon),
          ),
        ],
      ),
    );
  }
}
