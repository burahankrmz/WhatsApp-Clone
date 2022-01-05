import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/model/user_model.dart';

abstract class UsersRepo {
  Future<List<User>> getUserList();
}

class UserServices implements UsersRepo {
  @override
  Future<List<User>> getUserList() async {
    final response = await Dio().get('https://reqres.in/api/users');
    DataResponse itUsers = DataResponse.fromJson(response.data);
    List<User> users = itUsers.user;
    debugPrint(users.toString());
    return users;
  }
}
