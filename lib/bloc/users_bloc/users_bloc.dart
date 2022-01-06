import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsapp_clone/api/exception.dart';
import 'package:whatsapp_clone/api/services.dart';
import 'package:whatsapp_clone/model/user_model.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc({required this.usersRepo}) : super(UsersInitial()) {
    on<FetchUsers>(_onFetchUsers);
  }
  List<User> users = [];
  final UsersRepo usersRepo;

  _onFetchUsers(FetchUsers event, Emitter<UsersState> emit) async {
    emit(UsersLoading());
    try {
      users = await usersRepo.getUserList();
      emit(UsersLoaded(users));
    } on SocketException {
      emit(UsersError(error: NoInternetException('No Internet')));
    } on HttpException {
      emit(UsersError(error: NoInternetException('No Service Found')));
    } on FormatException {
      emit(UsersError(error: NoInternetException('Invalid Response format')));
    } catch (e) {
      emit(
        UsersError(error: UnknownException('Unknown Error')),
      );
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
