import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meeting_room/routers.dart';

import 'app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MeetingRoomApp());
}

class MeetingRoomApp extends StatelessWidget {
  const MeetingRoomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => MaterialApp.router(
        title: 'Za Mandresy',
        theme: AppTheme.customTheme(),
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.configurations,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
          Locale('fr', ''),
        ],
      ),
      designSize: const Size(428, 926),
    );
  }
}
