import 'package:ecommerce_flutter/src/presentation/pages/auth/login/login_bloc_cubit.dart';
import 'package:ecommerce_flutter/src/presentation/widgets/default_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBlocCubit? _loginBlocCubit;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _loginBlocCubit?.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    _loginBlocCubit = BlocProvider.of<LoginBlocCubit>(context, listen: false);

    return Scaffold(
        body: SizedBox(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/image/background2.jpg',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
            color: Colors.black54,
            colorBlendMode: BlendMode.darken,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            height: MediaQuery.of(context).size.height * 0.75,
            decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.3),
                borderRadius: BorderRadius.all(Radius.circular(25))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 125,
                ),
                Text(
                  'LOGIN',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.only(left: 25, right: 25),
                  child: StreamBuilder(
                      stream: _loginBlocCubit?.emailStream,
                      builder: (context, snapshot) {
                        return DefaultTextField(
                          label: 'Your email',
                          icon: Icons.email,
                          errorText: snapshot.error?.toString(),
                          onChanged: (text) {
                            _loginBlocCubit?.changeEmail(text);
                          },
                        );
                      }),
                ),
                Container(
                  margin: EdgeInsets.only(left: 25, right: 25),
                  child: StreamBuilder(
                      stream: _loginBlocCubit?.passwordStream,
                      builder: (context, snapshot) {
                        return DefaultTextField(
                          label: 'Password',
                          icon: Icons.lock,
                          errorText: snapshot.error?.toString(),
                          onChanged: (text) {
                            _loginBlocCubit?.changePassword(text);
                          },
                          obscureText: true,
                        );
                      }),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  margin:
                      EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 15),
                  child: StreamBuilder(
                      stream: _loginBlocCubit?.validateForm,
                      builder: (context, snapshot) {
                        return ElevatedButton(
                          onPressed: () {
                            if (snapshot.hasData) {
                              _loginBlocCubit?.login();
                            } else {
                              Fluttertoast.showToast(
                                  msg: 'Not valid form.',
                                  toastLength: Toast.LENGTH_LONG);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: snapshot.hasData
                                  ? Colors.green
                                  : Colors.grey),
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 30,
                      height: 1,
                      color: Colors.white,
                      margin: EdgeInsets.only(right: 5),
                    ),
                    Text(
                      "Don't you have an account?",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    Container(
                      width: 30,
                      height: 1,
                      color: Colors.white,
                      margin: EdgeInsets.only(left: 5),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  margin: EdgeInsets.only(left: 25, right: 25, top: 15),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'register');
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
