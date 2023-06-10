import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/presentation/components/app_elevated_button.dart';
import '../../../../core/presentation/components/app_text_form_field.dart';

class SubscribeBody extends StatelessWidget {
  const SubscribeBody({super.key});

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 34.w,
          vertical: 35.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h,),
            Center(
              child: Image.asset(
                'assets/images/room 2.png',
                width: 292.w,
                height: 260.h,
              ),
            ),
            Text(
              'S\'inscrire',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 33.h,),
            AppTextFormField(
              hintText: 'Nom',
              prefixIcon: Icon(
                Icons.person_outline,
                size: 24.sp,
                color: Colors.black.withOpacity(0.4),
              ),
            ),
            SizedBox(height: 12.h,),
            AppTextFormField(
              hintText: 'Email',
              prefixIcon: Icon(
                Icons.email_outlined,
                size: 24.sp,
                color: Colors.black.withOpacity(0.4),
              ),
            ),
            SizedBox(height: 12.h,),
            AppTextFormField(
              hintText: 'Téléphone',
              prefixIcon: Icon(
                Icons.phone,
                size: 24.sp,
                color: Colors.black.withOpacity(0.4),
              ),
            ),
            SizedBox(height: 12.h,),
            AppTextFormField(
              hintText: 'Mot de passe',
              prefixIcon: Icon(
                Icons.lock_outline,
                size: 24.sp,
                color: Colors.black.withOpacity(0.4),
              ),
            ),
            SizedBox(height: 34.h,),
            AppElevatedButton(
              onPressed: () => print('test'),
              text: 'Se connecter',
            ),
            const Spacer(),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Vous avez déjà un compte ? ',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.black.withOpacity(0.4),
                    ),
                  ),
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => context.pop(),
                    text: ' Se connecter',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColor.purple,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}