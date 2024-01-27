import 'package:ecommerce_flutter/src/presentation/pages/auth/register/register_bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBlocCubit extends Cubit<RegisterBlocState> {
  RegisterBlocCubit() : super(RegisterInitial());

  final _firstnameController = BehaviorSubject<String>();
  final _lastnameController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _phoneController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _confirmPasswordController = BehaviorSubject<String>();

  Stream<String> get firstnameStream => _firstnameController.stream;
  Stream<String> get lastnameStream => _lastnameController.stream;
  Stream<String> get emailStream => _emailController.stream;
  Stream<String> get phoneStream => _phoneController.stream;
  Stream<String> get passwordStream => _passwordController.stream;
  Stream<String> get confirmPasswordStream => _confirmPasswordController.stream;

  Stream<bool> get validateForm => Rx.combineLatest6(
      firstnameStream,
      lastnameStream,
      emailStream,
      phoneStream,
      passwordStream,
      confirmPasswordStream,
      (a, b, c, d, e, f) => true);

  void register() {
    print('Firstname: ${_firstnameController.value}');
    print('Email: ${_emailController.value}');
    print('Password: ${_passwordController.value}');
  }

  void changeFirstname(String firstname) {
    if (firstname.runes.isEmpty) {
      _firstnameController.sink.addError('Enter your firstname.');
    } else {
      _firstnameController.sink.add(firstname);
    }
  }

  void changeLastname(String lastname) {
    if (lastname.runes.isEmpty) {
      _lastnameController.sink.addError('Enter your lastname.');
    } else {
      _lastnameController.sink.add(lastname);
    }
  }

  void changeEmail(String email) {
    final bool emailFormatValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (email.length < 5 || !emailFormatValid) {
      _emailController.sink.addError('Not a valid email.');
    } else {
      _emailController.sink.add(email);
    }
  }

  void changePhone(String phone) {
    if (phone.length < 8) {
      _phoneController.sink.addError('Enter your phone number.');
    } else {
      _phoneController.sink.add(phone);
    }
  }

  void changePassword(String password) {
    if (password.length < 8) {
      _passwordController.sink.addError('Password must have length >= 8.');
    } else {
      _passwordController.sink.add(password);
    }
  }

  void changeConfirmPassword(String confirmPassword) {
    if (confirmPassword.length < 8) {
      _confirmPasswordController.sink.addError('Confirm password must have length >= 8.');
    } else if (!_passwordController.hasValue || confirmPassword != _passwordController.value) {
      _confirmPasswordController.sink.addError('Passwords are not matched.');
    } else {
      _confirmPasswordController.sink.add(confirmPassword);
    }
  }

  void dispose() {
    changeFirstname('');
    changeLastname('');
    changeEmail('');
    changePhone('');
    changePassword('');
    changeConfirmPassword('');
  }
}
