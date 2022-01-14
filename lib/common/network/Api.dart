import 'package:chat_app/models/friend.dart';
import 'package:chat_app/models/index.dart';
import 'package:chat_app/models/login.dart';
import 'package:chat_app/models/result.dart';
import 'package:chat_app/models/user.dart';

abstract class Api {
  Future<Login> login(String username, String pwd);

  Future<Result> register(User user);

  Future<User> getLoginUserInfo();

  Future<List<Friend>> getFriends();

  Future<void> sendMessage(String friendId, Message message);

  Future<List<FriendInfo>> searchFriends(String column, int start, int limit);

  Future<bool> addFriend(String friendId, String message);

  Future<List<FriendRequest>> getRequest();

  Future<bool> handleRequest(num requestId, num isAgree);

  Future<FileInfo> uploadImg(String path);

  Future<PageResult> getMoments(num pageIndex, int pageSize);

  Future<bool> publishMoments(String context, String images, String video);

  Future<bool> likesMoments(String momentsId);

  Future<bool> commentMoments(String momentsId, String context);
}
