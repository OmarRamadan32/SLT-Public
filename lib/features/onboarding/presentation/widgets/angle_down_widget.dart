import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_slt/core/theme/spaces.dart';

class AngleDownWidget extends StatelessWidget {
  const AngleDownWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
              Spaces.inSectionSpace20,
        const FaIcon(FontAwesomeIcons.angleDown),
        Spaces.inSectionSpace20,
    ]);
  }
}
