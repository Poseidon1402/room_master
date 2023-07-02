import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../core/constants/app_color.dart';
import '../../../core/data/repository/reservation_repository.dart';

class ScanQrCodeBody extends StatefulWidget {
  const ScanQrCodeBody({Key? key}) : super(key: key);

  @override
  _ScanQrCodeBodyState createState() => _ScanQrCodeBodyState();
}

class _ScanQrCodeBodyState extends State<ScanQrCodeBody> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 50.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  borderRadius: 10,
                  borderColor: AppColor.purple,
                  borderLength: 20,
                  borderWidth: 10,
                  cutOutSize: 250,
                ),
              ),
            ),
          ),
          const Expanded(
            flex: 1,
            child: Center(
              child: Text('Scannez le code'),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Reservation',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            content: FutureBuilder(
              future: ReservationRepository()
                  .getSingleReservation(result!.code!),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final reservation = snapshot.data!;

                  return Column(
                    children: [
                      const Icon(
                        Icons.check_circle_outline,
                        color: Colors.greenAccent,
                        size: 70,
                      ),
                      Text(
                        'Salle: ${reservation.room.number}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Date: ${reservation.date}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Heure: ${reservation.time}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  );
                }

                if(snapshot.hasError) {
                  return Column(
                    children: [
                      const Icon(
                        Icons.error,
                        color: Colors.redAccent,
                        size: 70,
                      ),
                      Text(
                        'Une erreur s\'est produite',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  );
                }

                return const Center(child: CircularProgressIndicator());
              },
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  context.pop();
                },
              ),
            ],
          );
        },
      );
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
