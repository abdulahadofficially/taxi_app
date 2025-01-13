import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taxi_app_in_flutter/services/auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is PhoneNumberVerificationEvent) {
      yield* _phoneAuthVerificationToState(event as PhoneNumberVerificationEvent);
    } else if (event is PhoneAuthCodeVerificationEvent) {
      final uid = await AuthService.verifyAndLogin(
        verificationId: event.verificationId,
        smsCode: event.smsCode,
        phone: event.phone,
      );
      yield LoggedInState(uid: uid);
    } else if (event is CodeSentEvent) {
      yield CodeSentState(verificationId: event.verificationId, token: event.token);
    }
  }

  Stream<AuthState> _phoneAuthVerificationToState(PhoneNumberVerificationEvent event) async* {
    yield LoadingAuthState();
    await AuthService.verifyPhoneSendOtp(
      phone: event.phone,
      completed: (credential) {
        debugPrint('completed');
        add(CompleteAuthEvent(credential: credential));
      },
      failed: (error) {
        debugPrint('$error');
        add(ErrorOccureEvent(error: error.toString()));
      },
      codeSent: (String id, int? token) {
        debugPrint('code sent: $id');
        add(CodeSentEvent(token: token!, verificationId: id));
      },
      codeAutoRetrievalTimeout: (id) {
        debugPrint('timeout $id');
        add(CodeSentEvent(token: 0, verificationId: id));
      },
    );
  }
}
