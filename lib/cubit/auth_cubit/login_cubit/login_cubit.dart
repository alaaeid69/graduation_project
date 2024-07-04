import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradproj/core/network/network_info.dart';

import '../../../repos/auth_repo.dart';
import 'login_state.dart';


// Events
abstract class LoginEvent {}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;

  LoginButtonPressed({required this.email, required this.password});
}

// Cubit
class LoginCubit extends Cubit<LoginState> {
  final AuthRepo authRepo;
  final NetworkInfo networkInfo;

  LoginCubit({required this.authRepo, required this.networkInfo}) : super(LoginInitial());

  void loginUser({required String email, required String password}) async {
    emit(LoginLoading());

    // Check for internet connection
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      emit(LoginFailure(error: "please check the internet connection!"));
      return;
    }

    final result = await authRepo.loginUser(email, password);

    result.fold(
          (error) => emit(LoginFailure(error: error)),
          (success) => emit(LoginSuccess()),
    );
  }
}
