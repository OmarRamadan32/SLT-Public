import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class SelectCampaignTypeWidgetAdmin extends StatefulWidget {
  final Function(String) onSelected;
  const SelectCampaignTypeWidgetAdmin({super.key, required this.onSelected});

  @override
  State<SelectCampaignTypeWidgetAdmin> createState() =>
      _SelectCampaignTypeWidgetAdminState();
}

class _SelectCampaignTypeWidgetAdminState
    extends State<SelectCampaignTypeWidgetAdmin> {
  final String name1 = "عشان ربنا";
  final String name2 = "قادة الخير";
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = name1;
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      initialValue: selectedValue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      offset: const Offset(0, 50),
      color: Theme.of(context).primaryColor,
      onSelected: (value) {
        setState(() {
          selectedValue = value;
        });
        widget.onSelected(value);
      },
      itemBuilder:
          (context) => [
            PopupMenuItem(value: name1, child: Text(name1)),
            PopupMenuItem(value: name2, child: Text(name2)),
          ],
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          borderRadius: BorderRadius.circular(10.r),
          // border: Border.all(color: Theme.of(context).primaryColor),
        ),
        child: ListTile(
          titleAlignment: ListTileTitleAlignment.center,
          textColor: Theme.of(context).primaryColor,
          iconColor: Theme.of(context).primaryColor,
          title: ArabicTextWidget(text: selectedValue),
          leading: const Icon(Icons.arrow_drop_down),
        ),
      ),
    );
  }
}
