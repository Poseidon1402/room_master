import 'package:flutter/material.dart';

import '../../core/constants/app_color.dart';
import 'widgets/scan_qr_code_body.dart';

class ScanQrCodeScreen extends StatelessWidget {
  const ScanQrCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColor.white1,
        leading: Image.asset(
          'assets/logo/E-room sans nom.png',
        ),
      ),
      body: const ScanQrCodeBody(),
    );
  }
}