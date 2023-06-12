import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:meeting_room/core/enums/load_status.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/route_path.dart';
import '../../../../core/presentation/bloc/auth/auth_bloc.dart';
import '../../../../core/presentation/components/app_elevated_button.dart';
import '../../../../core/presentation/components/app_text_form_field.dart';

class SubscribeBody extends StatefulWidget {
  const SubscribeBody({super.key});

  @override
  State<SubscribeBody> createState() => _SubscribeBodyState();
}

class _SubscribeBodyState extends State<SubscribeBody> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _phoneController;
  bool _isPasswordNotVisible = true;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _phoneController = TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          Future.delayed(const Duration(milliseconds: 2000))
            .then((value) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Votre inscription s\' est déroulé avec succès',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                backgroundColor: const Color.fromRGBO(238, 75, 43, 1),
              ),
            );
              context.go(RoutePath.roomList);
          });
        } else if (state.status.isError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.error as String,
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
            horizontal: 34.w,
            vertical: 35.h,
          ),
          child: ListView(
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
                controller: _nameController,
                hintText: 'Nom',
                prefixIcon: Icon(
                  Icons.person_outline,
                  size: 24.sp,
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
              SizedBox(height: 12.h,),
              AppTextFormField(
                controller: _emailController,
                hintText: 'Email',
                prefixIcon: Icon(
                  Icons.email_outlined,
                  size: 24.sp,
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
              SizedBox(height: 12.h,),
              AppTextFormField(
                controller: _phoneController,
                hintText: 'Téléphone',
                prefixIcon: Icon(
                  Icons.phone,
                  size: 24.sp,
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
              SizedBox(height: 12.h,),
              AppTextFormField(
                controller: _passwordController,
                hintText: 'Mot de passe',
                obscureText: _isPasswordNotVisible,
                prefixIcon: Icon(
                  Icons.lock_outline,
                  size: 24.sp,
                  color: Colors.black.withOpacity(0.4),
                ),
                suffixIcon: InkWell(
                  onTap: () => setState(() => _isPasswordNotVisible = !_isPasswordNotVisible),
                  child: Icon(
                    _isPasswordNotVisible
                        ? FontAwesomeIcons.eyeSlash
                        : FontAwesomeIcons.eye,
                    size: 24.sp,
                    color: Colors.black.withOpacity(0.4),
                  ),
                ),
              ),
              SizedBox(height: 34.h,),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) => AppElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(AuthEventSubscribe(
                    name: _nameController.text,
                    password: _passwordController.text,
                    email: _emailController.text,
                    phone: _phoneController.text,
                  ));
                },
                buttonColor: state.status.isSuccess
                    ? AppColor.green
                    : AppColor.purple,
                text: Builder(
                  builder: (context) {
                    if (state.status.isLoading) {
                      return SpinKitThreeBounce(
                        color: Colors.white,
                        size: 20.sp,
                      );
                    }

                    if (state.status.isSuccess) {
                      return Icon(
                        Icons.check_circle_outline,
                        color: Colors.white,
                        size: 30.sp,
                      );
                    }

                    return Text(
                      'Se connecter',
                      style:
                      Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                      ),
                    );
                  },
                )),
              ),
              SizedBox(height: 90.h,),
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
      ),
    );
  }
}