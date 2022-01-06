import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/bloc/users_bloc/users_bloc.dart';
import 'package:whatsapp_clone/constants/color_manager.dart';
import 'package:whatsapp_clone/model/user_model.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({Key? key}) : super(key: key);

  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  //late UsersBloc _usersBloc;
  @override
  void initState() {
    super.initState();
    //_usersBloc = BlocProvider.of<UsersBloc>(context);
    _loadUsers();
  }

  _loadUsers() async {
    BlocProvider.of<UsersBloc>(context).add(FetchUsers());
  }

  List<String> choices = <String>[
    'Invite a friend',
    'Contacts',
    'Refresh',
    'Help'
  ];

  final TextStyle _datesTextStyle = const TextStyle(
      fontSize: 14, color: Colors.black, fontWeight: FontWeight.w300);

  final TextStyle _contactCountStyle = TextStyle(
      color: ColorManager.white, fontWeight: FontWeight.w400, fontSize: 12);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _bodyBlocBuilder(),
    );
  }

  Widget _bodyBlocBuilder() {
    return SafeArea(
      child: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          if (state is UsersError) {
            final error = state.error;
            return Text(error);
          }
          if (state is UsersLoaded) {
            List<User> user = state.user;

            return _body(user);
          }
          if (state is UsersInitial) {
            _loadUsers();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _body(List<User> user) {
    return Column(
      children: [
        Expanded(flex: 1, child: _buildNewGroupTile()),
        Expanded(flex: 1, child: _buildNewContactTile()),
        Expanded(flex: 8, child: _buildContactsTile(user)),
      ],
    );
  }

  Widget _buildContactsTile(List<User> user) {
    return ListView.builder(
      itemCount: user.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(user[index].avatar),
          ),
          title: Text(user[index].firstName),
          subtitle: Text(user[index].email),
        );
      },
    );
  }

  Widget _buildNewContactTile() {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: ColorManager.tealGreen,
        child: Icon(
          Icons.person_add,
          color: ColorManager.white,
        ),
      ),
      title: const Text('New contact'),
      trailing: const Icon(Icons.bar_chart),
    );
  }

  Widget _buildNewGroupTile() {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: ColorManager.tealGreen,
        child: Icon(
          Icons.person,
          color: ColorManager.white,
        ),
      ),
      title: const Text('New Group'),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: ColorManager.tealGreen,
      leading: _buildAppBarBackBtn(),
      title: _buildAppBarTile(),
      actions: [_buildSearchBtn(), _buildMenuButton()],
    );
  }

  Widget _buildAppBarTile() {
    return ListTile(
      title: Text(
        'Select Contact',
        style: TextStyle(color: ColorManager.white),
      ),
      subtitle: Text('6 Contact', style: _contactCountStyle),
    );
  }

  Widget _buildAppBarBackBtn() {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  Widget _buildMenuButton() {
    return PopupMenuButton(itemBuilder: (context) {
      return choices.map((String choice) {
        return PopupMenuItem<String>(
          value: choice,
          child: Text(choice, style: _datesTextStyle),
        );
      }).toList();
    });
  }

  Widget _buildSearchBtn() =>
      IconButton(onPressed: () {}, icon: const Icon(Icons.search));
}
