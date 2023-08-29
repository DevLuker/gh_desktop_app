import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gh_desktop_app/app/utils/credentials.dart';
import 'package:gh_desktop_app/features/home/screen/home_screen.dart';
import 'package:gh_desktop_app/features/login/bloc/login_bloc.dart';
import 'package:gh_desktop_app/features/login/bloc/login_state.dart';
import 'package:gh_desktop_app/features/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login to GitHub'),
      ),
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.client != null) {
            final accessToken = state.client!.credentials.accessToken;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => HomeScreen(
                  accessToken: accessToken,
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.loading) {
            return const LoadingIndicator();
          }
          if (state.error.isNotEmpty) {
            return TextError(error: state.error);
          }
          return Center(
            child: ElevatedButton(
              onPressed: () {
                context.read<LoginBloc>().onLoginToGithub(
                      ghClientId,
                      ghClientSecret,
                    );
              },
              child: const Text(
                'Login to Github',
              ),
            ),
          );
        },
      ),
    );
  }
}
