import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';
import 'package:new_slt/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:new_slt/features/auth/presentation/widgets/auth_textfield_widget.dart';

class LoginPageAuthSection extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final AutovalidateMode autovalidateMode;
  const LoginPageAuthSection({
    super.key,
    required this.formKey,
    required this.autovalidateMode,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: autovalidateMode,
      key: formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.centerRight,
              child: ArabicTextWidget(
                text: "تسجيل الدخول",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Spaces.inSectionSpace20,
            AuthTextField(
              onSaved: (val) {
                context.read<AuthCubit>().loginModel.email = val!.trim();
              },
              validator: (p0) => p0!.isEmpty ? "ادخل البريد الالكتروني" : null,
              icon: Icons.email,
              hint: "البريد الالكتروني",
              textInputType: TextInputType.emailAddress,
            ),
            Spaces.inSectionSpace20,
            AuthTextField(
              onSaved: (val) {
                context.read<AuthCubit>().loginModel.password = val!.trim();
              },
              validator: (p0) => p0!.isEmpty ? "ادخل كلمة المرور" : null,
              icon: Icons.lock,
              hint: "كلمة المرور",
              isPassword: true,
            ),
            Spaces.inSectionSpace20,
            SizedBox(
              width: 175.w,
              child: Divider(
                color: Theme.of(context).primaryColor.withAlpha(150),
                thickness: 0.7,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
