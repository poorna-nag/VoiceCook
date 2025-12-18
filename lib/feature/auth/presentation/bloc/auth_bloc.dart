import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voicecook/core/navigation_service.dart';
import 'package:voicecook/feature/auth/data/repo/auth_repo_impl.dart';
import 'package:voicecook/feature/auth/presentation/bloc/auth_event.dart';
import 'package:voicecook/feature/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(LoadedState()) {
    on<SingInEvent>((event, emit) async {
      try {
        final success = await AuthRepoImpl().singInUser(event.authModel);

        if (success) {
          emit(LoadedState()); // Emit loaded before navigation
          NavigationService.pushNamed(routeName: AppRoutes.home);
        } else {
          emit(ErrorState());
        }
      } catch (e) {
        emit(ErrorState());
      }
    });
    on<LogingEvent>((event, emit) async {
      try {
        final userLogin = await AuthRepoImpl().logInUser(
          event.userName,
          event.passCode,
        );
        if (userLogin) {
          NavigationService.pushNamed(routeName: AppRoutes.home);
        } else {
          emit(ErrorState());
        }
      } catch (e) {
        emit(ErrorState());
      }
    });
    on<NavigateToSinginPageEvent>((event, emit) {
      NavigationService.pushNamed(routeName: AppRoutes.signin);
    });
    on<NavigateToLoginPageEvent>((event, emit) {
      NavigationService.pop();
    });
  }
}
