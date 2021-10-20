import 'package:catcher/catcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'business/barItem/controller/BarItemController.dart';

void main() {
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
      home: Scaffold(body: Index()),
    );
  }
}
