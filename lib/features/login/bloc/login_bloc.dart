// ignore_for_file: depend_on_referenced_packages
import 'dart:io';
import 'package:gh_desktop_app/app/utils/credentials.dart';
import 'package:gh_desktop_app/features/login/bloc/login_state.dart';
import 'package:http/http.dart' as http;
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:window_to_front/window_to_front.dart';

const _initialState = LoginState();

class LoginBloc extends Cubit<LoginState> {
  LoginBloc() : super(_initialState);

  HttpServer? _redirectServer;

  Future<void> onLoginToGithub(String clientId, String clientSecret) async {
    try {
      emit(state.copyWith(loading: true));
      await _redirectServer?.close();
      _redirectServer = await HttpServer.bind('localhost', 0);
      final grant = oauth2.AuthorizationCodeGrant(
        clientId,
        authorizationEndpoint,
        tokenEndpoint,
        secret: clientSecret,
        httpClient: _JsonAcceptingHttpClient(),
      );

      final redirectUrl = Uri.parse(
        'http://localhost:${_redirectServer!.port}/auth',
      );

      final authorizationUrl = grant.getAuthorizationUrl(
        redirectUrl,
        scopes: githubScopes,
      );

      await _toRedirect(authorizationUrl);
      final responseQuery = await _listerQuery();
      final responseClient = await grant.handleAuthorizationResponse(
        responseQuery,
      );

      WindowToFront.activate();

      emit(
        state.copyWith(
          loading: false,
          client: responseClient,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          error: 'Ocurrió un error',
          loading: false,
        ),
      );
    }
  }

  Future<void> _toRedirect(Uri authorizationUrl) async {
    if (await canLaunchUrl(authorizationUrl)) {
      await launchUrl(authorizationUrl);
    } else {
      emit(state.copyWith(loading: false, error: 'Could not launch'));
    }
  }

  Future<Map<String, String>> _listerQuery() async {
    var request = await _redirectServer!.first;
    var params = request.uri.queryParameters;
    request.response.statusCode = 200;
    request.response.headers.set('content-type', 'text/plain');
    request.response.writeln('Authenticated! You can close this tab.');
    await request.response.close();
    await _redirectServer!.close();
    _redirectServer = null;
    return params;
  }
}

class _JsonAcceptingHttpClient extends http.BaseClient {
  final _httpClient = http.Client();
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['Accept'] = 'application/json';
    return _httpClient.send(request);
  }
}
