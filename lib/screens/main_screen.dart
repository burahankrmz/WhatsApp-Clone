import 'package:flutter/material.dart';
import 'package:whatsapp_clone/constants/color_manager.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.tealGreen,
        title: const Text('WhatsApp'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
        bottom: TabBar(
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
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          const Center(
            child: Text('CHATS'),
          ),
          const PersonListTile(),
          Center(
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
          ),
        ],
      ),
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
