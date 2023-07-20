import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_block_demo/injection_container.dart';
import 'package:social_media_block_demo/presentation/bloc/login/login_bloc.dart';

import '../../../core/route/route_names.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator.get<LoginBloc>(),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final loginBloc = context.read<LoginBloc>();

    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginStateException) {
            if (state.message != null) {
              final snackBar = SnackBar(content: Text(state.message!));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          } else if (state is LoginStateSuccess) {
            String userName = "Kapil R Singh";
            String id = "101";
            context.goNamed(RouteNames.home, queryParameters: {'id': id, "userName": userName});
          }
        },
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Form(
                    key: loginBloc.formData,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 100),
                        Text(
                          "Hello Again!",
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Welcome back you've \nbeen missed!",
                          style: Theme.of(context).textTheme.titleLarge,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 60),
                        TextFormField(
                          controller: loginBloc.txtUserName,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelText: "Enter username",
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.red, width: 2.0),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2.0),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white, width: 2.0),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Please enter some value';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: loginBloc.txtPassword,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            labelText: "Password",
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.red, width: 2.0),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2.0),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white, width: 2.0),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Please enter some value';
                            } else {
                              return null;
                            }
                          },
                        ),
                        if (state is LoginStateFailed && state.message != null)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Text(
                                state.message!,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: Theme.of(context).colorScheme.error,
                                    ),
                              ),
                            ),
                          ),
                        const SizedBox(height: 40),
                        FilledButton(
                          onPressed: () {
                            if (loginBloc.formData.currentState!.validate()) {
                              context.read<LoginBloc>().add(
                                    LoginClick(
                                      loginBloc.txtUserName.text,
                                      loginBloc.txtPassword.text,
                                    ),
                                  );
                            }
                          },
                          style: FilledButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            minimumSize: const Size.fromHeight(50),
                          ),
                          child: const Text('Sign In'),
                        ),
                      ],
                    ),
                  ),
                ),
                if (state is LoginStateLoading)
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const CircularProgressIndicator(),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
