import 'package:equatable/equatable.dart';
import 'package:github/github.dart';

class HomeState extends Equatable {
  const HomeState({
    this.github,
    this.user,
    this.loading = false,
    this.error = '',
  });
  final GitHub? github;
  final CurrentUser? user;
  final bool loading;
  final String error;

  HomeState copyWith({
    GitHub? github,
    CurrentUser? user,
    bool? loading,
    String? error,
  }) =>
      HomeState(
        github: github ?? this.github,
        user: user ?? this.user,
        error: error ?? this.error,
        loading: loading ?? this.loading,
      );

  @override
  List<Object?> get props => [
        github,
        user,
        loading,
        error,
      ];
}
