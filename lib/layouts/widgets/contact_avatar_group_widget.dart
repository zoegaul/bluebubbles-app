import 'package:bluebubbles/layouts/widgets/contact_avatar_widget.dart';
import 'package:bluebubbles/layouts/widgets/theme_switcher/theme_switcher.dart';
import 'package:bluebubbles/repository/models/chat.dart';
import 'package:bluebubbles/repository/models/handle.dart';
import 'package:flutter/material.dart';

class ContactAvatarGroupWidget extends StatefulWidget {
  ContactAvatarGroupWidget(
      {Key key,
      @required this.participants,
      this.width,
      this.height,
      @required this.chat})
      : super(key: key);
  final List<Handle> participants;
  final Chat chat;
  final double width;
  final double height;

  @override
  _ContactAvatarGroupWidgetState createState() =>
      _ContactAvatarGroupWidgetState();
}

class _ContactAvatarGroupWidgetState extends State<ContactAvatarGroupWidget>
    with AutomaticKeepAliveClientMixin {
  List<dynamic> icons;
  List<Handle> participants = [];

  @override
  Widget build(BuildContext context) {
    super.build(context);

    participants = widget.participants;
    // if (participants.length > 2) {
    //   participants = participants.sublist(0, 2);
    // }

    if (participants.length == 0) {
      return Container(
        width: widget.width ?? 40,
        height: widget.height ?? 40,
      );
    }

    return Container(
      width: widget.width ?? 40,
      height: widget.height ?? 40,
      child: participants.length > 1
          ? ThemeSwitcher(
              iOSSkin: Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: ContactAvatarWidget(
                      handle: participants[0],
                      size: 26,
                      fontSize: 12,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: ContactAvatarWidget(
                      handle: participants[1],
                      size: 26,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              materialSkin: Builder(
                builder: (context) {
                  if (widget.participants.length == 2) {
                    return Stack(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: ContactAvatarWidget(
                            handle: participants[0],
                            size: 24.5,
                            fontSize: 10.5,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: ContactAvatarWidget(
                            handle: participants[1],
                            size: 24.5,
                            fontSize: 10.5,
                          ),
                        ),
                      ],
                    );
                  } else if (widget.participants.length == 3) {
                    return Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomRight,
                          child: ContactAvatarWidget(
                            handle: participants[0],
                            size: 21.5,
                            fontSize: 9,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: ContactAvatarWidget(
                            handle: participants[1],
                            size: 21.5,
                            fontSize: 9,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: ContactAvatarWidget(
                            handle: participants[2],
                            size: 21.5,
                            fontSize: 9,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomRight,
                          child: ContactAvatarWidget(
                            handle: participants[0],
                            size: 20,
                            fontSize: 8.7,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: ContactAvatarWidget(
                            handle: participants[1],
                            size: 20,
                            fontSize: 8.7,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: ContactAvatarWidget(
                            handle: participants[2],
                            size: 20,
                            fontSize: 8.7,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: ContactAvatarWidget(
                            handle: participants[3],
                            size: 20,
                            fontSize: 8.7,
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            )
          : ContactAvatarWidget(
              handle: participants.first,
              borderThickness: 0.1,
            ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
