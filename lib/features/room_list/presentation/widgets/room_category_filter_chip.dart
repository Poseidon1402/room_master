import 'package:flutter/material.dart';

import '../../../../core/constants/app_color.dart';

class RoomCategoryFilterChip extends StatelessWidget {
  final String text;
  final bool isSelected;
  final Function(bool) onSelected;

  const RoomCategoryFilterChip({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {

    return FilterChip(
      selected: isSelected,
      onSelected: onSelected,
      label: Text(text),
      labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: isSelected ? Colors.white : AppColor.purple,
      ),
      showCheckmark: false,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      selectedColor: AppColor.purple,
      side: isSelected ? BorderSide.none : const BorderSide(
        color: AppColor.purple,
      ),
    );
  }
}