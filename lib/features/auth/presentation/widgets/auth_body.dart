import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:meeting_room/core/presentation/components/app_text_form_field.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/route_path.dart';
import '../../../../core/presentation/components/app_elevated_button.dart';

class AuthBody extends StatelessWidget {
  const AuthBody({super.key});

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
                'assets/images/room.png',
                width: 292.w,
                height: 270.h,
              ),
            ),
            SizedBox(height: 36.h,),
            RichText(
              text: TextSpan(
                children: <InlineSpan>[
                  TextSpan(
                    text: 'Bienvenue\n',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextSpan(
                    text: 'Connectez-vous pour continuer',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.black.withOpacity(0.4),
                      fontSize: 20.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 46.h,),
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
              hintText: 'Mot de passe',
              prefixIcon: Icon(
                Icons.lock_outline,
                size: 24.sp,
                color: Colors.black.withOpacity(0.4),
              ),
            ),
            SizedBox(height: 47.h,),
            AppElevatedButton(
              onPressed: () => context.go(RoutePath.roomList),
              text: 'Se connecter',
            ),
            const Spacer(),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Vous n\'avez pas de compte ? ',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.black.withOpacity(0.4),
                    ),
                  ),
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        context.push(RoutePath.signUp);
                      },
                    text: ' S\'inscrire',
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