import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gh_desktop_app/features/home/bloc/home_state.dart';
import 'package:github/github.dart';

const _initialState = HomeState();

class HomeBloc extends Cubit<HomeState> {
  HomeBloc() : super(_initialState);

  Future<void> onGetDataUser(String accessToken) async {
    emit(_initialState.copyWith(loading: true));
    try {
      final github = GitHub(
        auth: Authentication.withToken(accessToken),
      );
      final currentUser = await github.users.getCurrentUser();
      emit(
        _initialState.copyWith(
          loading: false,
          user: currentUser,
          github: github,
        ),
      );
    } catch (e) {
      emit(_initialState.copyWith(loading: false, error: 'Ocurrió un error'));
    }
  }
}
