import 'package:flutter/material.dart';
import 'package:gh_desktop_app/features/home/bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gh_desktop_app/features/home/bloc/home_state.dart';
import 'package:gh_desktop_app/features/home/screen/widgets/git_hub_summary.dart';
import 'package:gh_desktop_app/features/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.accessToken,
  });
  final String accessToken;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()
        ..onGetDataUser(
          accessToken,
        ),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('My GitHub'),
            ),
            body: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state.github != null) {
                  return GitHubSummary(gitHub: state.github!);
                }

                if (state.error.isNotEmpty) {
                  return TextError(error: state.error);
                }

                return const SizedBox();
              },
            ),
          );
        },
      ),
    );
  }
}



/* class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Github Home'),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.user != null) {
            return Center(
              child: Text('Welcome: ${state.user?.login}'),
            );
          }

          if (state.error.isNotEmpty) {
            return TextError(error: state.error);
          }

          return const LoadingIndicator();
        },
      ),
    );
  }
}
 */