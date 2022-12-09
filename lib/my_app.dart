
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musik/internal/router/app_router.dart';

Future<void> initMyApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await initLocalDatabase();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final router = AppRouter();


  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      routerConfig: router.goRouter,
      builder: (context, child) {
        return Stack(
          children: [
            child!,
          ],
        );
      },
    );
  }
}


