import 'package:flutter/material.dart';
import 'package:taxi_app_in_flutter/pages/auth/auth_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    
    return const Scaffold(
      resizeToAvoidBottomInset: true,
      body: AuthPage(),
    );
  }
}
