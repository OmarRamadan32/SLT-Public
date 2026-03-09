import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';
import 'package:new_slt/core/widgets/small_note_widget.dart';
import 'package:new_slt/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:new_slt/features/auth/presentation/widgets/auth_textfield_widget.dart';

class RegisterPageTextFieldsSections extends StatelessWidget {
  const RegisterPageTextFieldsSections({
    super.key,
    required this.formKey,
    required this.autovalidateMode,
  });

  final GlobalKey<FormState> formKey;
  final AutovalidateMode autovalidateMode;

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: autovalidateMode,
      key: formKey,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            child: ArabicTextWidget(
              text: "المعلومات الشخصية",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),

          Spaces.inSectionSpace20,

          AuthTextField(
            hint: "اسم المستخدم",
            textInputType: TextInputType.name,
            isArabicText: true,
            icon: Icons.person_2,
            validator: (p0) => p0!.isEmpty ? "ادخل الاسم" : null,
            onSaved: (val) {
              context.read<AuthCubit>().userModel.name = val!.trim();
            },
          ),

          Spaces.inSectionSpace20,
          AuthTextField(
            hint: "البريد الالكتروني",
            textInputType: TextInputType.emailAddress,
            isArabicText: false,
            icon: Icons.email,
            validator: (p0) => p0!.isEmpty ? "ادخل البريد الالكتروني" : null,
            onSaved: (val) {
              context.read<AuthCubit>().registerModel.email = val!.trim();
            },
          ),
          Spaces.inSectionSpace20,
          AuthTextField(
            hint: "كلمة المرور",
            textInputType: TextInputType.visiblePassword,
            isPassword: false,
            isArabicText: false,
            icon: Icons.lock,
            validator: (p0) => p0!.isEmpty ? "ادخل كلمة المرور" : null,
            onSaved: (val) {
              context.read<AuthCubit>().registerModel.password = val!.trim();
            },
          ),
          const SmallNoteWidget(
            content: "- يجب ان يكون الاسم ثنائي و باللغة العربية -",
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }
}
