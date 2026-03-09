import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/core/routes/app_router.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';
import 'package:new_slt/core/widgets/drawer_widget/drawer_card_widget.dart';
import 'package:new_slt/features/auth/presentation/cubit/auth_cubit.dart';

class DrawerLogoutCard extends StatelessWidget {
  const DrawerLogoutCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DrawerCardWidget(
      isLogoutCard: true,
      label: "تسجيل الخروج",
      icon: FontAwesomeIcons.arrowRightFromBracket,
      ontap: () {
        Helpers.showDialogMethod(
          context,
          dialogTitle: "هل تريد تسجيل الخروج؟",
          actionsWidget: Row(
            children: [
              Expanded(
                flex: 1,
                child: TextButton(
                  child: ArabicTextWidget(
                    text: "نعم",
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall!.copyWith(color: Colors.red),
                  ),
                  onPressed: () {
                    context.pop();
                    context.read<AuthCubit>().logout();
                    GoRouter.of(context).push(AppRouter.kLoginPage);
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: TextButton(
                  child: ArabicTextWidget(
                    text: "لا",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  onPressed: () {
                    context.pop();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
