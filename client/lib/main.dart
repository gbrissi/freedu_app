import 'package:client/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Must add this line.
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    minimumSize: Size(390, 780),
    maximumSize: Size(390, 780),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );

  windowManager.waitUntilReadyToShow(
    windowOptions,
    () async {
      await windowManager.show();
      await windowManager.focus();
    },
  );

  initializeDateFormatting().then(
    (_) => runApp(
      const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // useInheritedMediaQuery: true,
    // designSize: const Size(360, 690),
    // minTextAdapt: true,
    // splitScreenMode: true,
    return MaterialApp.router(
      locale: const Locale('pt', 'BR'),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
