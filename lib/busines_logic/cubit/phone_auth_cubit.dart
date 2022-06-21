import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'phone_auth_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  late String verficationId;

  PhoneAuthCubit() : super(PhoneAuthInitial());

  Future<void> submitPhoneNumber(String phoneNumber) async {
    emit(Loading());

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+222$phoneNumber',
      timeout: const Duration(seconds: 14),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  void verificationCompleted(PhoneAuthCredential credential) async {
    print('vérificationComplété');

    await signIn(credential);
  }

  void verificationFailed(FirebaseAuthException error) {
    print('échec de la vérification : ${error.toString()}');

    emit(ErrorOccured(errorMsg: error.toString()));
  }

  void codeSent(String verficiationId, int? ressendToken) {
    print('code envoyé');
    this.verficationId = verficiationId;
    emit(PhoneNumberSubmited());
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    print(' codeAutoRetrievalTimeout');
  }

  Future<void> submitOTP(String otpCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: this.verficationId, smsCode: otpCode);

    await signIn(credential);
  }

  Future<void> signIn(PhoneAuthCredential credential) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(PhoneOTPVerified());
    } catch (error) {
      emit(ErrorOccured(errorMsg: error.toString()));
    }
  }

  Future<void> LogOut() async {
    await FirebaseAuth.instance.signOut();
  }

  User getLoggesInUser() {
    User firebaseUser = FirebaseAuth.instance.currentUser!;
    
    return firebaseUser;
  }
}
