import 'package:flutter/material.dart';
import 'package:movies_app/services/auth.dart';
import 'package:movies_app/services/init.dart';
import 'package:movies_app/view_models/pages/dashboard.dart';
import 'package:movies_app/view_models/pages/otp.dart';
import 'package:movies_app/view_models/pages/register.dart';

import 'package:movies_app/views/pages/dashboard.dart';
import 'package:movies_app/views/pages/register.dart';
import 'package:movies_app/views/theme.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RegisterViewModel()),
        ChangeNotifierProvider(create: (_) => OTPViewModel()),
        ChangeNotifierProvider(create: (_) => DashboardViewModel()),
      ],
      child: MaterialApp(
        title: 'Movies App',
        theme: theme,
        home: FutureBuilder(
          future: init(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return const AuthCheck();
            } else {
              return const Scaffold(
                body: Center(
                  child: Text("Loading"),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class AuthCheck extends StatelessWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return AuthService.instance.isLoggedIn() ? const DashboardPage() : const RegisterPage();
  }
}
