import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:meeting_room/core/domain/entity/room.dart';
import 'package:meeting_room/core/enums/load_status.dart';
import 'package:time_range_picker/time_range_picker.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/domain/entity/reservation.dart';
import '../../../../core/presentation/components/app_elevated_button.dart';
import '../../../../core/presentation/components/app_text_form_field.dart';
import '../bloc/reservation_bloc.dart';

class BookingBody extends StatefulWidget {
  final Room room;

  const BookingBody({super.key, required this.room});

  @override
  State<BookingBody> createState() => _BookingBodyState();
}

class _BookingBodyState extends State<BookingBody> {
  late TextEditingController dateController;
  late TextEditingController timeController;

  @override
  void initState() {
    dateController = TextEditingController();
    timeController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    dateController.dispose();
    timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReservationBloc, ReservationInsertionState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          _buildBottomSheetWithQrCode(state.reservationId!);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Votre réservation a été enregistrée avec succès',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                    ),
                textAlign: TextAlign.center,
              ),
              backgroundColor: AppColor.green,
            ),
          );
        } else if (state.status.isError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Une erreur s\'est produite',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                    ),
                textAlign: TextAlign.center,
              ),
              backgroundColor: const Color.fromRGBO(238, 75, 43, 1),
            ),
          );
        }
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 27.w,
            vertical: 95.h,
          ),
          child: Column(
            children: [
              AppTextFormField(
                controller: dateController,
                hintText: 'Date',
                onTap: _showDatePicker,
                readOnly: true,
                showCursor: false,
                suffixText: dateController.text.isNotEmpty ? 'Date' : '',
                prefixIcon: Icon(
                  FontAwesomeIcons.calendar,
                  size: 24.sp,
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              AppTextFormField(
                controller: timeController,
                onTap: _showTimeRangePicker,
                hintText: 'Heure',
                readOnly: true,
                showCursor: false,
                suffixText: timeController.text.isNotEmpty ? 'Heure' : '',
                prefixIcon: Icon(
                  Icons.access_time_outlined,
                  size: 24.sp,
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
              const Spacer(),
              BlocBuilder<ReservationBloc, ReservationInsertionState>(
                builder: (context, state) => AppElevatedButton(
                    onPressed: () {
                      context
                          .read<ReservationBloc>()
                          .add(ReservationInsertEvent(Reservation(
                            room: widget.room,
                            date: dateController.text,
                            user: FirebaseAuth.instance.currentUser?.email
                                as String,
                            time: timeController.text,
                          )));
                    },
                    text: state.status.isLoading
                        ? SpinKitWave(
                            color: Colors.white,
                            size: 20.sp,
                          )
                        : Text(
                            'Confirmer',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Colors.white,
                                      fontSize: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.fontSize,
                                    ),
                          )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        locale: const Locale("fr"),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 1),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: AppColor.purple,
                onPrimary: Colors.white,
                onSurface: AppColor.purple,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: AppColor.purple, // button text color
                ),
              ),
            ),
            child: child!,
          );
        });

    if (pickedDate != null) {
      String formattedDate =
          DateFormat("dd MMMM yyyy", 'fr_FR').format(pickedDate);
      setState(() => dateController.text = formattedDate);
    }
  }

  void _showTimeRangePicker() async {
    TimeRange time = await showTimeRangePicker(
        context: context,
        fromText: 'À',
        toText: 'Jusqu\'à',
        strokeWidth: 4,
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: AppColor.purple,
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: AppColor.purple, // button text color
                ),
              ),
            ),
            child: child!,
          );
        });

    setState(() {
      timeController.text =
          '${formatTime(time.startTime)} - ${formatTime(time.endTime)}';
    });
  }

  String formatTime(TimeOfDay time) {
    final format = DateFormat.Hm('fr_FR');
    final dateTime = DateTime(0, 1, 1, time.hour, time.minute);
    return format.format(dateTime);
  }

  void _buildBottomSheetWithQrCode(String reservationId) {

    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Card(
          elevation: 0.0,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 10.h,
            ),
            width: MediaQuery.of(context).size.width,
            height: 2 * MediaQuery.of(context).size.height / 3,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Excellent ! Votre reservation s\'est déroulée avec succès\n',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      TextSpan(
                        text: 'Voici votre qr code pour la réservation\n',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ]
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Column(
                    children: [
                      QrImage(
                        size: 200,
                        data: reservationId,
                      ),
                      InkWell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              Icons.download,
                              color: Colors.black87,
                            ),
                            Text(
                              'Exporter',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: const Color(0xFF1E1E1E),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
