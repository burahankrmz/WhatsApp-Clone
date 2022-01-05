import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:whatsapp_clone/model/user_model.dart';

abstract class UsersRepo {
  Future<List<User>> getUserList();
}

class UserServices implements UsersRepo {
  @override
  Future<List<User>> getUserList() async {
    final response = await Dio().get('https://reqres.in/api/users/');
    List<User> users = userFromJson(response.data);
    return users;
  }
}
