import 'package:flutter/material.dart';
import 'package:shopping_server/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:shopping_server/utils/constants/colors.dart';
import 'package:shopping_server/utils/helpers/helper_functions.dart';

class CustomChoiceChip extends StatelessWidget {
  const CustomChoiceChip({
    super.key,
    required this.label,
    required this.selected,
    this.onSelected,
  });

  final String label;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    final selectedColor = HelperFunctions.getColor(label);
    final isColor = selectedColor != null;

    return Theme(
      data: Theme.of(context).copyWith(canvasColor: AppPallete.transparentColor),
      child: ChoiceChip(
        label: isColor ? const SizedBox() : Text(label),
        selected: selected,
        labelStyle: TextStyle(color: selected ? AppPallete.whiteColor : null),
        onSelected: onSelected,
        avatar: isColor
            ? CircularContainer(width: 50, height: 50, backgroundColor: selectedColor)
            : null,
        labelPadding: isColor ? const EdgeInsets.all(0) : null,
        padding: isColor ? const EdgeInsets.all(0) : null,
        shape: isColor ? const CircleBorder() : null,
        backgroundColor: selectedColor,
      ),
    );
  }
}
