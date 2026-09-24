import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_projects/features/profile/data/models/user_model.dart';
import 'package:flutter_projects/features/profile/data/repo/user_repo.dart';
import '../../data/auth_service.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService;
  final UserRepo _userRepo;

  AuthCubit(this._authService,this._userRepo) : super(const AuthInitial());

  void checkAuthState() {
    final user = _authService.currentUser;
    if (user != null) {
      emit(Authenticated(user));
    } else {
      emit(const Unauthenticated());
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading());
    try {
      final credential = await _authService.signIn(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        emit(Authenticated(credential.user!));
      } else {
        emit(const AuthError('Sign in failed. Please try again.'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> register({
    required String email,
    required String password,
    required String name,
  }) async {
    debugPrint('AuthCubit: register called for email: $email');
    emit(const AuthLoading());
    try {
      final credential = await _authService.register(
        email: email,
        password: password,
        name: name,
      );
      if (credential.user != null) {
        debugPrint('AuthCubit: user registered successfully, uid: ${credential.user!.uid}. Creating Firestore user doc...');
        try {
          await _userRepo.createUser(UserModel(
            uid: credential.user!.uid,
            email: email,
            name: name,
          )).timeout(const Duration(seconds: 5));
          debugPrint('AuthCubit: Firestore user doc created successfully.');
        } catch (e) {
          debugPrint('AuthCubit: Firestore user doc creation timed out or failed (non-fatal): $e');
        }
        debugPrint('AuthCubit: emitting Authenticated state for uid: ${credential.user!.uid}');
        emit(Authenticated(credential.user!));
      } else {
        debugPrint('AuthCubit: credential.user is null');
        emit(const AuthError('Registration failed. Please try again.'));
      }
    } catch (e) {
      debugPrint('AuthCubit: register exception: $e');
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signOut() async {
    emit(const AuthLoading());
    try {
      await _authService.signOut();
      emit(const Unauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
