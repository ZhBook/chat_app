import 'package:chat_app/models/friend.dart';
import 'package:get/get.dart';

import 'database/DBManage.dart';
import 'network/impl/ApiImpl.dart';

class Controller extends GetxController {
  /// 你不需要这个，我推荐使用它只是为了方便语法。
  /// 用静态方法：Controller.to.increment()。
  /// 没有静态方法的情况下：Get.find<Controller>().increment();
  /// 使用这两种语法在性能上没有区别，也没有任何副作用。一个不需要类型，另一个IDE会自动完成。
  static Controller get to => Get.find(); // 添加这一行

  var friendList;

  ///获取好友列表
  List<Friend> getFriendList() {
    final ApiImpl request = new ApiImpl();
    request.getFriends().then((value) {
      friendList = value;
      print('friends:' + friendList.toString());
    });
    return friendList;
  }

  /// 获取好友信息
  Friend getFriendInfo(num friendId, num userId) {
    var friend;
    DBManage.getFriend(friendId, userId).then((value) => friend = value);
    return friend;
  }
}
