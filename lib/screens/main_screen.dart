import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:whatsapp_clone/bloc/users_bloc/users_bloc.dart';
import 'package:whatsapp_clone/constants/color_manager.dart';
import 'package:whatsapp_clone/model/user_model.dart';
import 'package:whatsapp_clone/screens/chat_screen.dart';
import 'package:whatsapp_clone/screens/contact_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late UsersBloc usersBloc;
  late TabController _tabController;
  List<String> choices = <String>[
    'New Group',
    'New broadcast',
    'Linked devices',
    'Starred messages',
    'Settings',
  ];
  final TextStyle _datesTextStyle =
      const TextStyle(fontSize: 14, color: Colors.black);
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    //_loadUsers();
    usersBloc = BlocProvider.of<UsersBloc>(context);
  }

  _loadUsers() async {
    usersBloc.add(FetchUsers());
  }

  @override
  void dispose() {
    super.dispose();
    usersBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          _buildBody(),
          _buildFloatingBtn(),
        ],
      ),
    );
  }

  Positioned _buildFloatingBtn() {
    return Positioned(
      right: 15,
      bottom: 15,
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              PageTransition(
                  child: const ContactsScreen(),
                  type: PageTransitionType.rightToLeft));
        },
        backgroundColor: ColorManager.tealGreen,
        child: const Icon(Icons.message),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: ColorManager.tealGreen,
      title: const Text('WhatsApp'),
      actions: [_buildSearchBtn(), _buildMenuButton()],
      bottom: _buildTabbar(),
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

  TabBar _buildTabbar() {
    return TabBar(
      controller: _tabController,
      indicatorColor: ColorManager.white,
      tabs: const [
        Tab(
          text: 'CHATS',
        ),
        Tab(
          text: 'STATUS',
        ),
        Tab(
          text: 'CALLS',
        ),
      ],
    );
  }

  Widget _buildBody() {
    return TabBarView(
      controller: _tabController,
      children: [
        _buildChatList(),
        const PersonListTile(),
        _buildCallList(),
      ],
    );
  }

  BlocBuilder<UsersBloc, UsersState> _buildChatList() {
    return BlocBuilder<UsersBloc, UsersState>(
      builder: (context, state) {
        if (state is UsersError) {
          final error = state.error;
          return Text(error);
        }
        if (state is UsersLoaded) {
          List<User> user = state.user;

          return ChatListTile(user);
        }
        if (state is UsersInitial) {
          _loadUsers();
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  BlocBuilder<UsersBloc, UsersState> _buildCallList() {
    return BlocBuilder<UsersBloc, UsersState>(
      builder: (context, state) {
        if (state is UsersError) {
          final error = state.error;
          return Text(error);
        }
        if (state is UsersLoaded) {
          List<User> user = state.user;

          return CallListTile(user);
        }
        if (state is UsersInitial) {
          _loadUsers();
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

// ignore: must_be_immutable
class CallListTile extends StatelessWidget {
  CallListTile(this.users, {Key? key}) : super(key: key);
  final List<User> users;

  List<bool> callType = [true, false, false, true, true, false];

  List<String> messages = [
    'Today, 23:12',
    'Today, 15:23',
    'Today, 11:40',
    'Yesterday, 18:34',
    'Yesterday, 15:54',
    'Yesterday, 12:00'
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {},
          leading: _buildUserImage(index),
          title: _buildUserName(index),
          subtitle: _buildCallTypeIcon(index),
          trailing: _buildCallBtn(),
        );
      },
    );
  }

  Widget _buildUserImage(int index) {
    return CircleAvatar(
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(users[index].avatar));
  }

  Widget _buildUserName(int index) => Text(users[index].firstName);

  Widget _buildCallBtn() {
    return IconButton(
      onPressed: () {},
      icon: Icon(Icons.call, color: ColorManager.tealGreen),
    );
  }

  Widget _buildCallTypeIcon(int index) {
    return Row(
      children: [
        callType[index]
            ? Icon(Icons.call_made, size: 16, color: ColorManager.tealGreen)
            : Icon(Icons.call_received,
                size: 16, color: ColorManager.tealGreen),
        const SizedBox(width: 5),
        Text(messages[index]),
      ],
    );
  }
}

// ignore: must_be_immutable
class ChatListTile extends StatelessWidget {
  ChatListTile(this.users, {Key? key}) : super(key: key);
  final List<User> users;

  final TextStyle _datesTextStyle =
      const TextStyle(fontSize: 12, color: Colors.grey);

  List<String> dates = [
    '00:49',
    '23:01',
    '22:00',
    'Yesterday',
    'Yesterday',
    'Yesterday'
  ];

  List<String> messages = [
    'Will you coming brother?',
    'Yeah I will be right there.',
    'I love you so much honey. See you soon',
    'Did you finish your job. We waiting you',
    'Lets Go Bro We will win this match.',
    'I want to learn Flutter Will you help me'
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    child: ChatScreen(
                      users[index]
                    ), type: PageTransitionType.rightToLeft));
          },
          leading: CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: NetworkImage(users[index].avatar),
          ),
          title: Text(users[index].firstName),
          subtitle: Text(messages[index]),
          trailing: Text(dates[index], style: _datesTextStyle),
        );
      },
    );
  }
}

class PersonListTile extends StatelessWidget {
  const PersonListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListTile(
        onTap: () {},
        leading: const CircleAvatar(
          backgroundColor: Colors.grey,
          child: Icon(
            Icons.person,
            color: Colors.white,
          ),
        ),
        title: const Text('My Status'),
        subtitle: const Text('Tap to add status update'),
      ),
    );
  }
}
