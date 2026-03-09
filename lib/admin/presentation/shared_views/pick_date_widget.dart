import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class DateTimePickerField extends StatefulWidget {
  final void Function(DateTime dateTime) onDateTimeSelected;

  const DateTimePickerField({super.key, required this.onDateTimeSelected});

  @override
  State<DateTimePickerField> createState() => _DateTimePickerFieldState();
}

class _DateTimePickerFieldState extends State<DateTimePickerField> {
  DateTime? selectedDateTime;

  Future<void> _pickDateTime() async {
    // اختر التاريخ
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (pickedDate == null) return;

    // اختر الوقت
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime == null) return;

    // دمج التاريخ والوقت
    final finalDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    setState(() => selectedDateTime = finalDateTime);

    // رجّع القيمة للـ parent
    widget.onDateTimeSelected(finalDateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ArabicTextWidget(
          text: "موعد الاجتماع",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Spaces.space5,
        InkWell(
          onTap: _pickDateTime,
          child: InputDecorator(
            decoration: InputDecoration(
              enabled: true,
              filled: true,
              fillColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor.withAlpha(125),
                ),
              ),
            ),
            child: ArabicTextWidget(
              text:
                  selectedDateTime == null
                      ? "لم يتم الاختيار"
                      : "${selectedDateTime!.year}-${selectedDateTime!.month}-${selectedDateTime!.day} - "
                          "${(selectedDateTime!.hour % 12 == 0 ? 12 : selectedDateTime!.hour % 12).toString().padLeft(2, '0')}:${selectedDateTime!.minute.toString().padLeft(2, '0')} "
                          "${selectedDateTime!.hour >= 12 ? 'م' : 'ص'}",
            ),
          ),
        ),
      ],
    );
  }
}
