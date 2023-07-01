import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/domain/entity/reservation.dart';
import '../../../../core/presentation/components/app_elevated_button.dart';

class Booking extends StatefulWidget {
  final Reservation reservation;

  const Booking({
    super.key,
    required this.reservation,
  });

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  Uint8List? qrCodeBytes;
  GlobalKey qrCodeKey = GlobalKey();

  @override
  void initState() {
    generateQRCode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 5.h,
      ),
      constraints: BoxConstraints.expand(
        height: 150.h,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 17.w,
        vertical: 14.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildBookingInfo(context),
          _buildDateAndHour(context),
        ],
      ),
    );
  }

  Widget _buildBookingInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Salle #${widget.reservation.room.number}',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Text(
          '${widget.reservation.room.capacity} places',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Row(
          children: [
            AppElevatedButton(
              onPressed: () async {
                _buildBottomSheetWithQrCode(
                    widget.reservation.id as String, context);
              },
              borderRadius: 51.r,
              width: 15,
              text: Text(
                'QR Code',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
            SizedBox(
              width: 25.w,
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Annuler',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColor.purple,
                    ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildDateAndHour(BuildContext context) {
    final date = widget.reservation.date.split(' ');

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          date[0],
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: const Color.fromRGBO(250, 12, 55, 1),
                fontSize: 40.sp,
              ),
        ),
        Text(
          '${date[1]} ${date[2]}',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Text(
          widget.reservation.time,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  void _buildBottomSheetWithQrCode(String reservationId, BuildContext context) {
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
            height: MediaQuery.of(context).size.height / 2,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                      text:
                          'Excellent ! Votre reservation s\'est déroulée avec succès\n',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    TextSpan(
                      text: 'Voici votre qr code pour la réservation\n',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ]),
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Column(
                      children: [
                        RepaintBoundary(
                          key: qrCodeKey,
                          child: qrCodeBytes != null
                              ? Image.memory(qrCodeBytes!)
                              : const CircularProgressIndicator(),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        AppElevatedButton(
                          onPressed: () {
                            saveQRCodeImage();
                          },
                          text: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.download,
                                color: Colors.white,
                              ),
                              Text(
                                'Exporter',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: Colors.white,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> generateQRCode() async {
    final qrImageData = await QrPainter(
      data: widget.reservation.id as String,
      version: QrVersions.auto,
      gapless: false,
    ).toImageData(300.0);

    setState(() {
      qrCodeBytes = qrImageData?.buffer.asUint8List();
    });
  }

  Future<void> saveQRCodeImage() async {
    try {
      final file = await ImageGallerySaver.saveImage(qrCodeBytes!,
          name: '${widget.reservation.id}.png');
      if (file != null) {
        GFToast.showToast(
          'Enregistré avec succès',
          context,
          toastDuration: 6,
          backgroundColor: Color.fromRGBO(75, 181, 67, 1),
          toastPosition: GFToastPosition.BOTTOM,
        );
      } else {
        print('Failed to save QR code image.');
      }
    } catch (e) {
      print('Error saving QR code image: $e');
    }
  }
}
