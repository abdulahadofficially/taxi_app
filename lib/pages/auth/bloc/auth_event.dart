part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignUpEvent extends AuthEvent {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;

  const SignUpEvent({required this.uid, required this.firstName, required this.lastName, required this.email, required this.phone});
}

class PhoneNumberVerificationEvent {
  final String phone;

  PhoneNumberVerificationEvent({required this.phone});
}

class PhoneAuthCodeVerificationEvent extends AuthEvent {
  final String phone;
  final String smsCode;
  final String verificationId;

  const PhoneAuthCodeVerificationEvent({required this.phone, required this.smsCode, required this.verificationId});
}

class CompleteAuthEvent extends AuthEvent {
  final AuthCredential credential;
  const CompleteAuthEvent({required this.credential});
}

class ErrorOccureEvent extends AuthEvent {
  final String error;
  const ErrorOccureEvent({required this.error});
}

class CodeSentEvent extends AuthEvent {
  final int token;
  final String verificationId;
  const CodeSentEvent({required this.token, required this.verificationId});
}
