import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';
import 'package:url_launcher/url_launcher.dart';
abstract class Helpers {

  static Future<void> launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);

    try {
      // التحقق من إمكانية فتح الرابط
      if (await canLaunchUrl(url)) {
        await launchUrl(
          url,
          // externalApplication بتفتح المتصفح الأساسي للموبايل (كروم أو سفاري)
          mode: LaunchMode.externalApplication,
        );
      } (e) {
    };
  } catch (e) {
    print(e);
  }
  }
  static String getMonthName(int monthNumber) {
    List<String> arabicMonths = [
      "يناير",
      "فبراير",
      "مارس",
      "ابريل",
      "مايو",
      "يونيو",
      "يوليو",
      "اغسطس",
      "سبتمبر",
      "اكتوبر",
      "نوفمبر",
      "ديسمبر",
    ];
    if (monthNumber <= 0) {
      return "ديسمبر";
    } else {
      return arabicMonths[monthNumber - 1];
    }
  }

  static String zeroFill(int number) {
    return number.toString().padLeft(2, '0');
  }
 static List<Map<String, dynamic>> convertJsonStringToList(String jsonString) {
  if (jsonString.trim().isEmpty) {
    return [];
  }

  try {
    final decodedData = jsonDecode(jsonString);

    if (decodedData is List) {
      
      return decodedData.map((item) {
        if (item is Map) {
          return Map<String, dynamic>.from(item);
        }
        return <String, dynamic>{}; 
      }).toList();
      
    } else {
      return [];
    }
  } catch (e) {
    return [];
  }
}

 
 static Future<File?> pickImageFromGallery() async {
    final ImagePicker _picker = ImagePicker();
  final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  if (pickedFile == null) return null;
  return File(pickedFile.path);
}
static Future<List<File>> pickMultipleImagesFromGallery() async {
      final ImagePicker _picker = ImagePicker();
  final List<XFile>? pickedFiles = await _picker.pickMultiImage();
  if (pickedFiles == null) return [];
  return pickedFiles.map((e) => File(e.path)).toList();
  
}

static Future<void> showBottomSheetMethod({
  required BuildContext context,
  required Widget child,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: child,
      );
    },
  );
}

static void showSnackBar(
  BuildContext context,
  String message, {
  bool isSuccessMessage = false,
  bool isFailureMessage = false,
}) {
  ThemeData theme = Theme.of(context);
  final snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    elevation: 2,
    margin: EdgeInsets.only(bottom: 30.h, left: 16.w, right: 16.w),
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
    backgroundColor:
        isSuccessMessage
            ? Colors.green
            : isFailureMessage
            ? Colors.red
            : theme.bottomNavigationBarTheme.backgroundColor,

    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
    content: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      textDirection: TextDirection.rtl,
      children: [
        FaIcon(
          isSuccessMessage
              ? FontAwesomeIcons.circleCheck
              : isFailureMessage
              ? FontAwesomeIcons.circleXmark
              : FontAwesomeIcons.circleExclamation,
          color:
              isSuccessMessage || isFailureMessage
                  ? Colors.white
                  : theme.primaryColor,
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: ArabicTextWidget(
              maxLines: 2,
              text: message,
              style: theme.textTheme.bodySmall,
            ),
          ),
        ),
      ],
    ),
  );
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // close current snackbar
}

static void showDialogMethod(
  BuildContext context, {
  required String dialogTitle,
  required Widget actionsWidget,
}) {
  showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          title: ArabicTextWidget(
            text: dialogTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          actions: [actionsWidget],
          backgroundColor:
              Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        ),
  );
}
}
