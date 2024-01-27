import 'package:ecommerce_flutter/src/presentation/pages/auth/login/login_bloc_cubit.dart';
import 'package:ecommerce_flutter/src/presentation/pages/auth/register/register_bloc_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<BlocProvider> blocProviders = [
  BlocProvider<LoginBlocCubit>(create: (context) => LoginBlocCubit()),
  BlocProvider<RegisterBlocCubit>(create: (context) => RegisterBlocCubit()),
];
