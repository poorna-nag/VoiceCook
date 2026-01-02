import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voicecook/core/navigation_service.dart';
import 'package:voicecook/feature/auth/data/repo/auth_repo_impl.dart';
import 'package:voicecook/feature/auth/presentation/bloc/auth_event.dart';
import 'package:voicecook/feature/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepoImpl repo;

  AuthBloc(this.repo) : super(AuthInitial()) {
    on<SingInEvent>(_onSignIn);
    on<LogingEvent>(_onLogin);
  }

  Future<void> _onSignIn(SingInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final success = await repo.singInUser(event.authModel);
      if (success) {
        emit(AuthSuccess());
        NavigationService.pushReplacementNamed(routeName: AppRoutes.home);
      } else {
        emit(
          AuthError(message: 'Sign up failed. Please check your credentials.'),
        );
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onLogin(LogingEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final success = await repo.logInUser(event.useremail, event.passCode);
      if (success) {
        emit(AuthSuccess());
        NavigationService.pushReplacementNamed(routeName: AppRoutes.home);
      } else {
        emit(
          AuthError(
            message: 'Login failed. Please check your email and password.',
          ),
        );
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}
