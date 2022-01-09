import 'package:flutter/material.dart';
import 'package:whatsapp_clone/constants/color_manager.dart';
import 'package:whatsapp_clone/model/user_model.dart';

// ignore: must_be_immutable
class ChatScreen extends StatefulWidget {
  User user;
  ChatScreen(this.user, {Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<String> choices = <String>[
    'View contact',
    'Media, links, and docs',
    'Search',
    'Mute notifications',
    'Wallpaper',
    'More',
  ];

  List<String> moreChoices = <String>[
    'Report',
    'Block',
    'Search',
    'Clear chat',
    'Export chat',
    'Add shortcut',
  ];

  //bool isMore = false;

  @override
  void initState() {
    super.initState();
  }

  final TextStyle _datesTextStyle =
      const TextStyle(fontSize: 14, color: Colors.black);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.chatBackground,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Positioned(
            bottom: 5,
            left: 5,
            child: SizedBox(
              height: 45,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Material(
                        color: Colors.white,
                        elevation: 4,
                        borderRadius: BorderRadius.circular(30),
                        child: TextField(
                          minLines: 1,
                          maxLines: 6,
                          decoration: InputDecoration(
                            prefixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.emoji_emotions_outlined,
                                color: Colors.grey.shade500,
                              ),
                            ),
                            suffixIcon: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.photo_camera_sharp,
                                  color: Colors.grey.shade500,
                                )),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            contentPadding: const EdgeInsets.only(left: 10),
                            hintText: 'Message',
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: FloatingActionButton(
                        backgroundColor: ColorManager.tealGreen,
                        onPressed: () {},
                        child: const Icon(Icons.mic),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: ColorManager.tealGreen,
      leadingWidth: 60,
      leading: _buildAppBarLeading(),
      title: _buildAppBarUserInfo(),
      actions: [
        _buildVideoCallBtn(),
        _buildCallBtn(),
        _buildMenuBtn(),
      ],
    );
  }

  Widget _buildMenuBtn() {
    return PopupMenuButton(itemBuilder: (context) {
      return choices.map((String choice) {
        return PopupMenuItem<String>(
          value: choice,
          child: choice != "More"
              ? Text(
                  choice,
                  style: _datesTextStyle,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      choice,
                      style: _datesTextStyle,
                    ),
                    const Icon(
                      Icons.arrow_right,
                      color: Colors.black,
                    )
                  ],
                ),
        );
      }).toList();
    });
  }

  Widget _buildCallBtn() {
    return IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.call,
          size: 22,
        ));
  }

  Widget _buildVideoCallBtn() =>
      IconButton(onPressed: () {}, icon: const Icon(Icons.videocam_sharp));

  Widget _buildAppBarUserInfo() {
    return ListTile(
      title: Text(
        widget.user.firstName,
        style: TextStyle(color: ColorManager.white),
      ),
      subtitle: Text("online", style: TextStyle(color: ColorManager.white)),
    );
  }

  Widget _buildAppBarLeading() {
    return Row(
      children: [
        const Expanded(child: Icon(Icons.arrow_back)),
        Expanded(
            child: CircleAvatar(
                backgroundImage: NetworkImage(widget.user.avatar))),
      ],
    );
  }
}
