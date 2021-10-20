import 'package:simple_logger/simple_logger.dart';

import 'config/Global.dart';
import 'database/DBManage.dart';
import 'network/Request.dart';

class InitClass {
  static final log = SimpleLogger();

  static void init() {
    //数据库初始化
    DBManage.initDB();

    log.info("全局初始化");
    Global.init();

    log.info("网络初始化");
    //初始化网络请求相关配置
    Request.init();
  }
}
