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
    final success = await repo.singInUser(event.authModel);
    success ? emit(AuthSuccess()) : emit(AuthError());
    // if (success) {
    //   NavigationService.pushNamed(routeName: AppRoutes.home);
    // }
  }

  Future<void> _onLogin(LogingEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final success = await repo.logInUser(event.useremail, event.passCode);
    success ? emit(AuthSuccess()) : emit(AuthError());
  }
}
