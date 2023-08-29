import 'package:equatable/equatable.dart';
import 'package:oauth2/oauth2.dart';

class LoginState extends Equatable {
  const LoginState({
    this.client,
    this.loading = false,
    this.error = '',
  });
  final Client? client;
  final bool loading;
  final String error;

  LoginState copyWith({
    Client? client,
    bool? loading,
    String? error,
  }) =>
      LoginState(
        client: client ?? this.client,
        error: error ?? this.error,
        loading: loading ?? this.loading,
      );

  @override
  List<Object?> get props => [
        client,
        loading,
        error,
      ];
}
