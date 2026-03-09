// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/features/user/data/models/user_model.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/routes/app_router.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';
import 'package:new_slt/features/auth/data/models/register_model.dart';
import 'package:new_slt/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:new_slt/features/auth/presentation/widgets/auth_done_button_widget.dart';
import 'package:new_slt/features/auth/presentation/widgets/register_member_details_boxes_section.dart';
import 'package:new_slt/features/auth/presentation/widgets/register_page_image_section.dart';
import 'package:new_slt/features/auth/presentation/widgets/register_page_text_buttons_section.dart';
import 'package:new_slt/features/auth/presentation/widgets/register_page_text_fields_sections.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  void registerButtonFunction(BuildContext context) async {
    formKey.currentState!.save();
    // image path
    var image = context.read<UserCubit>().imageFile;
    // upload the image
    await context.read<AuthCubit>().uploadImage(image!.path);
    // instance from register model that holds Email and Password
    RegisterModel registerModel = context.read<AuthCubit>().registerModel;
    // instance from user model that holds other user details
    UserModel userModel = context.read<AuthCubit>().userModel;
    // call the register function
    await context.read<AuthCubit>().register(
      registerModel.email!,
      registerModel.password!,
      userModel,
    );
    context.read<UserCubit>().imageFile = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) async {
            if (state is AuthErrorState) {
              Helpers.showSnackBar(context, state.errorMessage);
            }
            if (state is AuthSuccessState) {
              Helpers.showSnackBar(context, "تم انشاء الحساب بنجاح");

              await context
                  .read<UserCubit>()
                  .getCurrentUser(); // Save User Data
              if (!context.mounted) return;
              GoRouter.of(context).pushReplacement(AppRouter.kHomePage);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spaces.inSectionSpace20,
                    Container(
                      alignment: Alignment.centerRight,
                      child: ArabicTextWidget(
                        text: "انشاء حساب جديد",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Spaces.sectionsSpace40,
                    const RegisterPageImageSection(),
                    Spaces.sectionsSpace40,
                    RegisterPageTextFieldsSections(
                      autovalidateMode: autovalidateMode,
                      formKey: formKey,
                    ),
                    Spaces.sectionsSpace40,
                    // ignore: prefer_const_constructors
                    RegisterMemberDetailsBoxesSection(),
                    Spaces.sectionsSpace60,
                    AuthDoneButtonWidget(
                      isLoading: state is AuthLoadingState,
                      onPressed: () async {
                        if (formKey.currentState!.validate() &&
                            context.read<UserCubit>().imageFile != null) {
                          registerButtonFunction(context);
                          // close the keyboard
                          FocusManager.instance.primaryFocus?.unfocus();
                        } else {
                          Helpers.showSnackBar(context, "ادخل جميع البيانات");
                          // close the keyboard
                          FocusManager.instance.primaryFocus?.unfocus();
                        }
                      },
                    ),
                    Spaces.sectionsSpace60,
                    RegisterPageTextButtonsSection(
                      autovalidateMode: autovalidateMode,
                      formKey: formKey,
                    ),
                    Spaces.inSectionSpace20,
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
