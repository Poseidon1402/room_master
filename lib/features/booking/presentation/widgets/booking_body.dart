import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:time_range_picker/time_range_picker.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/presentation/components/app_elevated_button.dart';
import '../../../../core/presentation/components/app_text_form_field.dart';

class BookingBody extends StatefulWidget {
  const BookingBody({super.key});

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
    return SizedBox(
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
            AppElevatedButton(
              onPressed: () => print('test'),
              text: Text(
                'Confirmer',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                  fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
                ),
              ),
            ),
          ],
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
      }
    );

    setState(() {
      timeController.text = '${formatTime(time.startTime)} - ${formatTime(time.endTime)}';
    });
  }

  String formatTime(TimeOfDay time) {
    final format = DateFormat.Hm('fr_FR');
    final dateTime = DateTime(0, 1, 1, time.hour, time.minute);
    return format.format(dateTime);
  }
}
