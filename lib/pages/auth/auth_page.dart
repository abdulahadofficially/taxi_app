import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/auth_bloc.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final PageController _controller = PageController();

  @override
  void initState() {
    super.initState();
  }

  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: context.watch<AuthBloc>(),
      listener: (context, state) {
        if (state is LoggedInState) {
          _controller.animateToPage(2, duration: const Duration(milliseconds: 400), curve: Curves.ease);
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Container(
              height: screenSize.height,
              width: screenSize.width,
              color: Colors.white,
              child: PageView(
                controller: _controller,
                physics: const NeverScrollableScrollPhysics(),
                children: const [],
              ),
            )
          ],
        );
      },
    );
  }
}
