import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/constants/app_color.dart';
import '../../my_booking/presentation/widgets/my_booking_body.dart';
import 'bloc/room_bloc.dart';
import 'widgets/icon_bottom_bar.dart';
import 'widgets/room_list_body.dart';

class RoomListScreen extends StatefulWidget {
  const RoomListScreen({super.key});

  @override
  State<RoomListScreen> createState() => _RoomListScreenState();
}

class _RoomListScreenState extends State<RoomListScreen> {
  int _selectedIndex = 0;
  final body = [
    const RoomListBody(),
    const MyBookingBody(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 12.h,
            ),
            child: _selectedIndex == 1 ? Text(
              'Mes Réservations',
              style: Theme.of(context).textTheme.titleLarge,
            ) :RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Bonjour John Doe\n',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 20.sp,
                        ),
                  ),
                  TextSpan(
                    text: 'Bienvenue sur e-room\n',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.black.withOpacity(0.4),
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: AppColor.white1,
        body: BlocProvider(
          create: (context) => RoomBloc()..add(RoomFetchingEvent()),
          child: body[_selectedIndex],
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 125.w,
            vertical: 15.h,
          ),
          child: Container(
            width: 200.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18.r),
                topRight: Radius.circular(18.r),
              ),
              color: Colors.white
            ),
            child: BottomAppBar(
              elevation: 0.5,
              shape: const CircularNotchedRectangle(),
              child: SizedBox(
                width: 125,
                height: 100.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 19.w,
                    vertical: 16.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconBottomBar(
                        icon: Icons.room_preferences_outlined,
                        selected: _selectedIndex == 0,
                        onPressed: () => setState(() => _selectedIndex = 0),
                      ),
                      IconBottomBar(
                        icon: FontAwesomeIcons.house,
                        selected: _selectedIndex == 1,
                        onPressed: () => setState(() => _selectedIndex = 1),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
