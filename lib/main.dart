import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/api/services.dart';
import 'package:whatsapp_clone/bloc/bloc/users_bloc.dart';
import 'package:whatsapp_clone/screens/main_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: BlocProvider(
        create: (context) => UsersBloc(usersRepo: UserServices()),
        child:  const MainScreen(),
      ),
    );
  }
}
