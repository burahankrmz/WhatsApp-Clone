import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/api/services.dart';
import 'package:whatsapp_clone/bloc/users_bloc/users_bloc.dart';
import 'package:whatsapp_clone/screens/main_screen.dart';
import 'bloc/users_bloc/users_bloc.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UsersBloc>(
          create: (context) => UsersBloc(usersRepo: UserServices()),
          child: const MainScreen(),
        ),
      ],
      child: const MaterialApp(
        title: 'Material App',
        home: MainScreen(),
      ),
    );
  }
}
