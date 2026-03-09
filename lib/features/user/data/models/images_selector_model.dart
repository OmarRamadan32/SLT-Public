import 'package:new_slt/features/user/presentation/widgets/images_selector_widget.dart';

class ImagesSelectorModel {
  final ImageSelectorType type;
  final bool? isCircular;
  final bool? inistialImage;

  ImagesSelectorModel({
    required this.type,
    this.isCircular,
    this.inistialImage,
  });
}
