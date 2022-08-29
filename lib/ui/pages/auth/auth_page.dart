import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proweb_presentations_web/domain/providers/auth_provider.dart';
import 'package:proweb_presentations_web/ui/router/app_navigator.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authModel = context.read<AuthProvider>();
    
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 450, maxHeight: 100),
          child: Ink(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () async {
                final _hasEmail = await authModel.googleLogIn();
                _hasEmail
                    ? Navigator.pushNamed(context, AppRoutes.settings)
                    : Navigator.pop(context);
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 38),
                child: Center(
                  child: Text(
                    'ВХОД ЧЕРЕЗ GOOGLE',
                    style: TextStyle(
                      fontSize: 20,
                      height: 1.2,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
