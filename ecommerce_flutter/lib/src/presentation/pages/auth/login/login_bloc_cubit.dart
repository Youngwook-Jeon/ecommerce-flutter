import 'package:ecommerce_flutter/src/presentation/pages/auth/login/login_bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class LoginBlocCubit extends Cubit<LoginBlocState> {
  LoginBlocCubit() : super(LoginInitial());

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Stream<String> get emailStream => _emailController.stream;
  Stream<String> get passwordStream => _passwordController.stream;

  void changeEmail(String email) {
    if (email.length < 3) {
      _emailController.sink.addError('Enter your email.');
    } else {
      _emailController.sink.add(email);
    }
  }

  void changePassword(String password) {
    if (password.length < 8) {
      _passwordController.sink.addError('The length of a password >= 8');
    } else {
      _passwordController.sink.add(password);
    }
  }

  Stream<bool> get validateForm =>
      Rx.combineLatest2(emailStream, passwordStream, (a, b) => true);

  void dispose() {
    changeEmail('');
    changePassword('');
  }

  void login() {
    print('Email: ${_emailController.value}');
    print('Password: ${_passwordController.value}');
  }
}
