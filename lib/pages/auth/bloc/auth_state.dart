part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class LoadingAuthState extends AuthState {}

final class LoggedInState extends AuthState {
  final String uid;

  const LoggedInState({required this.uid});
}

final class AutoLoggedInState extends LoggedInState {
  const AutoLoggedInState(String uid) : super(uid: uid);
}

class StateErrorSignup extends AuthState {
  final String message;

  const StateErrorSignup({required this.message});
}

class CodeSentState extends AuthState {
  final String verificationId;
  final int token;

  const CodeSentState({required this.verificationId, required this.token});
}
