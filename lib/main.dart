import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:musicavis/utils/notifications.dart';

import 'providers/theme.dart';
import 'repository/boxes.dart';
import 'ui/meta/meta.dart';
import 'ui/routes/all.dart';
import 'utils/constants.dart';
import 'utils/themes.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initNotifications();

  await Hive.initFlutter();
  registerAdapters();
  await openBoxes();

  runApp(ProviderScope(
    child: MusicavisApp(),
  ));
}

class MusicavisApp extends StatefulHookWidget {
  MusicavisApp({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MusicavisAppState();
}

class _MusicavisAppState extends State<MusicavisApp> {
  @override
  initState() {
    super.initState();
    if (Hive.box(SETTINGS_BOX).get(SETTINGS_NOTIFICATIONS_KEY)) {
      scheduleDailyNotification();
    }
  }

  @override
  dispose() {
    boxes.forEach((box) => Hive.box(box).compact());
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = getTheme(useProvider(themeStateNotifier.state));

    return MaterialApp(
      title: APP_NAME,
      theme: theme,
      home: const MetaRoute(),
      routes: {
        ROUTE_GOALS: (_) => GoalsRoute(),
        ROUTE_PRACTICE: (_) => PracticeRoute(),
        ROUTE_CALENDAR: (_) => CalendarRoute(),
        ROUTE_PROFILE: (_) => ProfileRoute(),
        ROUTE_PROFILE_SETTINGS: (_) => ProfileSettingsRoute(),
        ROUTE_PROFILE_SETTINGS_INSTRUMENTS: (_) => InstrumentListRoute(),
      },
    );
  }
}
