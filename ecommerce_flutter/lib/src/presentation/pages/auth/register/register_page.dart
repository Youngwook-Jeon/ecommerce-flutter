import 'package:ecommerce_flutter/src/presentation/pages/auth/register/register_bloc_cubit.dart';
import 'package:ecommerce_flutter/src/presentation/widgets/default_button.dart';
import 'package:ecommerce_flutter/src/presentation/widgets/default_icon_back.dart';
import 'package:ecommerce_flutter/src/presentation/widgets/default_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterBlocCubit? _registerBlocCubit;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _registerBlocCubit?.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    _registerBlocCubit =
        BlocProvider.of<RegisterBlocCubit>(context, listen: false);

    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // color: Colors.black,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/image/background3.jpg',
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
              color: Color.fromRGBO(0, 0, 0, 0.7),
              colorBlendMode: BlendMode.darken,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.75,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 0.3),
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 100,
                    ),
                    Text(
                      'REGISTRATION',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 25, right: 25),
                      child: StreamBuilder(
                          stream: _registerBlocCubit?.firstnameStream,
                          builder: (context, snapshot) {
                            return DefaultTextField(
                                label: 'First name',
                                errorText: snapshot.error?.toString(),
                                icon: Icons.person,
                                onChanged: (firstname) {
                                  _registerBlocCubit
                                      ?.changeFirstname(firstname);
                                });
                          }),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 25, right: 25),
                      child: StreamBuilder(
                          stream: _registerBlocCubit?.lastnameStream,
                          builder: (context, snapshot) {
                            return DefaultTextField(
                                label: 'Last name',
                                errorText: snapshot.error?.toString(),
                                icon: Icons.person_outline,
                                onChanged: (lastname) {
                                  _registerBlocCubit?.changeLastname(lastname);
                                });
                          }),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 25, right: 25),
                      child: StreamBuilder(
                          stream: _registerBlocCubit?.emailStream,
                          builder: (context, snapshot) {
                            return DefaultTextField(
                                label: 'Email',
                                errorText: snapshot.error?.toString(),
                                icon: Icons.email,
                                onChanged: (email) {
                                  _registerBlocCubit?.changeEmail(email);
                                });
                          }),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 25, right: 25),
                      child: StreamBuilder(
                          stream: _registerBlocCubit?.phoneStream,
                          builder: (context, snapshot) {
                            return DefaultTextField(
                                label: 'Phone number',
                                errorText: snapshot.error?.toString(),
                                icon: Icons.phone,
                                onChanged: (phone) {
                                  _registerBlocCubit?.changePhone(phone);
                                });
                          }),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 25, right: 25),
                      child: StreamBuilder(
                          stream: _registerBlocCubit?.passwordStream,
                          builder: (context, snapshot) {
                            return DefaultTextField(
                              label: 'Password',
                              errorText: snapshot.error?.toString(),
                              icon: Icons.lock,
                              onChanged: (password) {
                                _registerBlocCubit?.changePassword(password);
                              },
                              obscureText: true,
                            );
                          }),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 25, right: 25),
                      child: StreamBuilder(
                          stream: _registerBlocCubit?.confirmPasswordStream,
                          builder: (context, snapshot) {
                            return DefaultTextField(
                              label: 'Confirm password',
                              errorText: snapshot.error?.toString(),
                              icon: Icons.lock_outline,
                              onChanged: (confirmPassword) {
                                _registerBlocCubit
                                    ?.changeConfirmPassword(confirmPassword);
                              },
                              obscureText: true,
                            );
                          }),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 25, right: 25, top: 10),
                        child: StreamBuilder(
                            stream: _registerBlocCubit?.validateForm,
                            builder: (context, snapshot) {
                              return DefaultButton(
                                  text: 'Register',
                                  color: snapshot.hasData
                                      ? Colors.black
                                      : Colors.grey,
                                  onPressed: () {
                                    if (snapshot.hasData) {
                                      _registerBlocCubit?.register();
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: 'Not valid form.',
                                          toastLength: Toast.LENGTH_LONG);
                                    }
                                  });
                            }))
                  ],
                ),
              ),
            ),
            DefaultIconBack(left: 45, top: 125)
          ],
        ),
      ),
    );
  }
}
