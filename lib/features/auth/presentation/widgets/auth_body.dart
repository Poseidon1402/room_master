import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:meeting_room/core/enums/load_status.dart';
import 'package:meeting_room/core/presentation/components/app_text_form_field.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_validator/form_validator.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/route_path.dart';
import '../../../../core/presentation/bloc/auth/auth_bloc.dart';
import '../../../../core/presentation/components/app_elevated_button.dart';

class AuthBody extends StatefulWidget {
  const AuthBody({super.key});

  @override
  State<AuthBody> createState() => _AuthBodyState();
}

class _AuthBodyState extends State<AuthBody> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  bool _isPasswordVisible = false;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          Future.delayed(const Duration(milliseconds: 2000));
          state.currentUser?.email == 'admin@gmail.com'
              ? context.go(RoutePath.qrScanner)
              : context.go(RoutePath.roomList);
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
      child: Form(
        key: _formKey,
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
                SizedBox(
                  height: 30.h,
                ),
                Center(
                  child: Image.asset(
                    'assets/images/room.png',
                    width: 292.w,
                    height: 270.h,
                  ),
                ),
                SizedBox(
                  height: 36.h,
                ),
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
                SizedBox(
                  height: 46.h,
                ),
                AppTextFormField(
                  controller: _emailController,
                  hintText: 'Email',
                  type: TextInputType.emailAddress,
                  validator: ValidationBuilder(localeName: 'fr')
                      .required()
                      .email()
                      .build(),
                  onChange: (value) => _formKey.currentState!.validate(),
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    size: 24.sp,
                    color: Colors.black.withOpacity(0.4),
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                AppTextFormField(
                  controller: _passwordController,
                  hintText: 'Mot de passe',
                  obscureText: !_isPasswordVisible,
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    size: 24.sp,
                    color: Colors.black.withOpacity(0.4),
                  ),
                  validator: ValidationBuilder(localeName: 'fr')
                      .required()
                      .minLength(8)
                      .build(),
                  onChange: (value) => _formKey.currentState!.validate(),
                  suffixIcon: InkWell(
                    onTap: () => setState(
                        () => _isPasswordVisible = !_isPasswordVisible),
                    child: Icon(
                      _isPasswordVisible
                          ? FontAwesomeIcons.eyeSlash
                          : FontAwesomeIcons.eye,
                      size: 24.sp,
                      color: Colors.black.withOpacity(0.4),
                    ),
                  ),
                ),
                SizedBox(
                  height: 47.h,
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) => AppElevatedButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(AuthEventLogin(
                              email: _emailController.text,
                              password: _passwordController.text,
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
                SizedBox(
                  height: 95.h,
                ),
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
        ),
      ),
    );
  }
}
