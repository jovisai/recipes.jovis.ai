import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AppEntry extends ConsumerWidget {
  const AppEntry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (kIsWeb) {
      // running on the web!
      return Center(
        child: Container(
          decoration: BoxDecoration(
              color: CupertinoColors.black,
              border: Border.all(width: 10, color: CupertinoColors.black),
              borderRadius: const BorderRadius.all(Radius.circular(25))),
          padding: const EdgeInsets.only(top: 25, bottom: 25),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 853, maxWidth: 480),
            child: const MainApplication(),
          ),
        ),
      );
    }

    return const MainApplication();
  }
}

class MainApplication extends ConsumerWidget {
  const MainApplication({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoApp.router(
      theme: const CupertinoThemeData(
          primaryColor: CupertinoColors.activeGreen,
          brightness: Brightness.light,
          barBackgroundColor: CupertinoColors.white,
          textTheme: CupertinoTextThemeData(
              navTitleTextStyle: TextStyle(fontWeight: FontWeight.bold))),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      debugShowCheckedModeBanner: false,
    );
  }
}
