import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/routes/app_router.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:new_slt/features/auth/presentation/widgets/auth_done_button_widget.dart';
import 'package:new_slt/features/auth/presentation/widgets/login_page_auth_section.dart';
import 'package:new_slt/features/auth/presentation/widgets/login_page_header_section.dart';
import 'package:new_slt/features/auth/presentation/widgets/login_page_text_buttons_section.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  void loginButtonFunction(BuildContext context) async {
    formKey.currentState!.save();
    String email = context.read<AuthCubit>().loginModel.email!;
    String password = context.read<AuthCubit>().loginModel.password!;
    await context.read<AuthCubit>().login(email, password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
          bottom: true,
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) async {
              if (state is PasswordChangeState) {
                Helpers.showSnackBar(
                  context,
                  "سيتم إرسال رسالة تغيير كلمة المرور إليك, قم بمراجعة بريدك الإلكتروني",
                );
              }

              if (state is AuthErrorState) {
                Helpers.showSnackBar(context, state.errorMessage);
              }
              if (state is AuthSuccessState) {
                await context
                    .read<UserCubit>()
                    .getCurrentUser(); // Save User Data

                if (!context.mounted) return;
                GoRouter.of(context).pushReplacement(AppRouter.kHomePage);
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Spaces.inSectionSpace20,
                    const LoginPageHeaderSection(),
                    Spaces.screenLastItemSpace70,
                    LoginPageAuthSection(
                      formKey: formKey,
                      autovalidateMode: autovalidateMode,
                    ),
                    Spaces.sectionsSpace40,
                    AuthDoneButtonWidget(
                      isLoading: state is AuthLoadingState,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          loginButtonFunction(context);
                          // close the keyboard after submitting the form
                          FocusManager.instance.primaryFocus?.unfocus();
                        } else {
                          autovalidateMode = AutovalidateMode.always;
                        }
                      },
                    ),
                    Spaces.screenLastItemSpace70,
                    LoginPageTextButtonsSection(
                      formkey: formKey,
                      autovalidateMode: autovalidateMode,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
