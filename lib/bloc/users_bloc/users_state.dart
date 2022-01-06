part of 'users_bloc.dart';

abstract class UsersState {}

class UsersInitial extends UsersState {}

class UsersLoading extends UsersState {}

class UsersLoaded extends UsersState {
  final List<User> user;
  UsersLoaded(this.user);
}

class UsersError extends UsersState {
  dynamic error;
  UsersError({required this.error});
}
