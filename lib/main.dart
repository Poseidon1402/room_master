import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meeting_room/routers.dart';

import 'app_theme.dart';
import 'core/presentation/bloc/auth/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MeetingRoomApp());
}

class MeetingRoomApp extends StatelessWidget {
  const MeetingRoomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: ScreenUtilInit(
        builder: (context, child) => MaterialApp.router(
          title: 'Za Mandresy',
          locale: const Locale('fr'),
          theme: AppTheme.customTheme(),
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.configurations,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('fr', ''),
          ],
        ),
        designSize: const Size(428, 926),
      ),
    );
  }
}
