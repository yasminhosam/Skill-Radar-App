import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/auth_service.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService;

  AuthCubit(this._authService) : super(const AuthInitial());

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
    String? name,
  }) async {
    emit(const AuthLoading());
    try {
      final credential = await _authService.register(
        email: email,
        password: password,
        name: name,
      );
      if (credential.user != null) {
        emit(Authenticated(credential.user!));
      } else {
        emit(const AuthError('Registration failed. Please try again.'));
      }
    } catch (e) {
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
