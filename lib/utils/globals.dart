
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Globals{

  static String get appName => "getIn";
  static const String COL_USERS = "users";
  static const String COL_USERLOC = "user_location";
  static const String COL_WORLD_CHAT = "world_chat";
  static const String COL_CHAT_ROOM = "chat_room";
  static const String COL_CHAT_ROOM_MSG = "chat_room_messages";
  static const String COL_LIKED_USERS = "likedPersonUID";

  static double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
  static double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;
  static double tabBarWidgetsHeight(BuildContext context) => MediaQuery.of(context).size.height / 1.13;
  static bool isIos(BuildContext context) => Theme.of(context).platform == TargetPlatform.iOS;

  static const String permissionMC = "com.mpallc.method.channels/permission";
	static const String locationEC = "com.mpallc.event.channels/location";
	static const String locationMC = "com.mpallc.event.methods/location";

}

  void hideKeyboard() => SystemChannels.textInput.invokeMethod('TextInput.hide');