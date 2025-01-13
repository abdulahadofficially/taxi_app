import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService._();

  static AuthService? _instance;

  static AuthService get instance {
    return _instance ?? AuthService._();
  }

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<void> verifyPhoneSendOtp({
    required String phone,
    required void Function(PhoneAuthCredential) completed,
    required void Function(FirebaseAuthException) failed,
    required void Function(String, int?) codeSent,
    required void Function(String) codeAutoRetrievalTimeout,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: completed,
      verificationFailed: failed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  static Future<String> verifyAndLogin({required String verificationId, required String smsCode, required String phone}) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
    final authCredential = await _auth.signInWithCredential(credential);
    if (authCredential.user != null) {
      final uuid = authCredential.user?.uid;
      await FirebaseFirestore.instance.collection('users').doc(uuid).set({'uid': uuid, 'phone': phone});
      return uuid!;
    } else {
      return '';
    }
  }

  static Future<String> getCredential(PhoneAuthCredential credential) async {
    final authCredential = await _auth.signInWithCredential(credential);
    return authCredential.user != null ? authCredential.user!.uid : '';
  }
}
