import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_block_demo/injection_container.dart';

import '../../bloc/login_with_otp/login_with_otp_bloc.dart';

class LoginWithOtpPage extends StatelessWidget {
  const LoginWithOtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator.get<LoginWithOtpBloc>(),
      child: const LoginWithOtpView(),
    );
  }
}

class LoginWithOtpView extends StatelessWidget {
  const LoginWithOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [],
      ),
    );
  }
}
