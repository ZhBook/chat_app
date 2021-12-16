import 'package:catcher/catcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

import 'business/barItem/controller/BarItemController.dart';

String? selectedNotificationPayload;

final BehaviorSubject<String?> selectNotificationSubject =
    BehaviorSubject<String?>();

final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

Future<void> main() async {
  CatcherOptions debugOptions = CatcherOptions(
      SilentReportMode(), [ConsoleHandler()],
      localizationOptions: [LocalizationOptions.buildDefaultChineseOptions()]);

  /// Release configuration. Same as above, but once user accepts dialog, user will be prompted to send email with crash to support.
  CatcherOptions releaseOptions = CatcherOptions(SilentReportMode(), [
    EmailManualHandler(["709688530@qq.com"])
  ]);

  /// STEP 2. Pass your root widget (MyApp) along with Catcher configuration:
  Catcher(
      rootWidget: MyApp(),
      debugConfig: debugOptions,
      // enableLogger: true,
      releaseConfig: releaseOptions);
  // runApp(MyApp());

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');
  final IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings(onDidReceiveLocalNotification: (
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {
    didReceiveLocalNotificationSubject.add(
      ReceivedNotification(
        id: id,
        title: title,
        body: body,
        payload: payload,
      ),
    );
  });
  final MacOSInitializationSettings initializationSettingsMacOS =
      MacOSInitializationSettings();
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: initializationSettingsMacOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    selectedNotificationPayload = payload;
    selectNotificationSubject.add(payload);
  });

  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('your channel id', 'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker');
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  // 执行提示
  // await flutterLocalNotificationsPlugin.show(
  //     0, 'plain title', 'plain body', platformChannelSpecifics,
  //     payload: 'item x');
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /// STEP 3. Add navigator key from Catcher. It will be used to navigate user to report page or to show dialog.
      navigatorKey: Catcher.navigatorKey,
      /* builder: (BuildContext context, Widget? widget) {
        Catcher.addDefaultErrorWidget(
            showStacktrace: true,
            title: "Custom error title",
            description: "Custom error description",
            maxWidthForSmallMode: 150);
        return widget;
      },*/
      home: Scaffold(
        //软键盘打开时，点击留白区域关闭
        body: GestureDetector(
            onTap: () {
              FocusScopeNode focusScopeNode = FocusScope.of(context);
              if (!focusScopeNode.hasPrimaryFocus &&
                  focusScopeNode.focusedChild != null) {
                FocusManager.instance.primaryFocus!.unfocus();
              }
            },
            child: Index()),
        resizeToAvoidBottomInset: false,
      ),
      theme: ThemeData(
          // 1.亮度
          brightness: Brightness.light,
          // 2.primarySwatch传入不是Color, 而是MaterialColor(包含了primaryColor和accentColor)
          primarySwatch: Colors.red,
          // 3.primaryColor: 单独设置导航和TabBar的颜色
          primaryColor: Colors.orange,
          // 4.accentColor: 单独设置FloatingActionButton\Switch
          accentColor: Colors.green,
          // 5.Button的主题
          buttonTheme: ButtonThemeData(
              height: 25, minWidth: 10, buttonColor: Colors.yellow),
          // 6.Card的主题
          cardTheme: CardTheme(color: Colors.greenAccent, elevation: 10),
          // 7.Text的主题
          textTheme: TextTheme(
            bodyText1: TextStyle(fontSize: 16, color: Colors.red),
            bodyText2: TextStyle(fontSize: 20),
            headline1: TextStyle(fontSize: 14),
            headline2: TextStyle(fontSize: 16),
            headline3: TextStyle(fontSize: 18),
            headline4: TextStyle(fontSize: 20),
          )),
      debugShowCheckedModeBanner: false,
    );
  }
}

void selectNotification(String payload) async {
  if (payload != null) {
    debugPrint('notification payload: $payload');
  }
}
