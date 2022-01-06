import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/bloc/bloc/users_bloc.dart';
import 'package:whatsapp_clone/constants/color_manager.dart';
import 'package:whatsapp_clone/model/user_model.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  final TextStyle _callsBodyText =
      const TextStyle(fontSize: 18, color: Colors.grey, letterSpacing: 1.5);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadUsers();
  }

  _loadUsers() async {
    BlocProvider.of<UsersBloc>(context).add(FetchUsers());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: ColorManager.tealGreen,
      title: const Text('WhatsApp'),
      actions: [
        _buildSearchBtn(),
        _buildMenuButton()
      ],
      bottom: _buildTabbar(),
    );
  }

  Widget _buildMenuButton() => IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert));

  Widget _buildSearchBtn() => IconButton(onPressed: () {}, icon: const Icon(Icons.search));

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
        _buildCallsBody(),
      ],
    );
  }

  Widget _buildCallsBody() {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                'To start calling contacts who have',
                style: _callsBodyText,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                'WhatsApp. tap at the bottom of your',
                style: _callsBodyText,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                'screen',
                style: _callsBodyText,
              ),
            ),
          ],
        ),
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
          onTap: () {},
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
