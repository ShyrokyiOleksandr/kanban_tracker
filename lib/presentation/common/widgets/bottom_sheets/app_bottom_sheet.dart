import 'package:flutter/material.dart';
import 'package:kanban_tracker/presentation/common/colors/app_colors.dart';
import 'package:kanban_tracker/presentation/common/widgets/bottom_sheets/app_bottom_sheet_drag_anchor.dart';

class AppBottomSheet extends StatelessWidget {
  static Future<T?> showModal<T>({
    required final BuildContext context,
    required final Widget child,
    final bool isScrollControlled = true,
    final bool enableDrag = true,
    final bool isDismissible = true,
    final decoration = const AppBottomSheetDefaultBackgroundDecoration(),
    final double paddingRatio = 0.08,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.transparent,
      enableDrag: enableDrag,
      isDismissible: isDismissible,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * paddingRatio),
          child: AppBottomSheet(
            isDismissible: isDismissible,
            decoration: decoration,
            child: child,
          ),
        );
      },
    );
  }

  final Widget child;
  final bool isDismissible;
  final BoxDecoration decoration;

  const AppBottomSheet({
    required this.child,
    required this.isDismissible,
    this.decoration = const AppBottomSheetDefaultBackgroundDecoration(),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: isDismissible ? Navigator.of(context).pop : null,
            child: Container(),
          ),
        ),
        DecoratedBox(
          decoration: decoration.copyWith(
              borderRadius:
                  AppBottomSheetDefaultBackgroundDecoration._borderRadius),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AppBottomSheetDragAnchor(),
              Flexible(child: child),
            ],
          ),
        ),
      ],
    );
  }
}

class AppBottomSheetDefaultBackgroundDecoration extends BoxDecoration {
  static const double cornersRadius = 24;
  static const _borderRadius = BorderRadius.only(
    topLeft: Radius.circular(cornersRadius),
    topRight: Radius.circular(cornersRadius),
  );

  const AppBottomSheetDefaultBackgroundDecoration()
      : super(
          color: AppColors.background,
          borderRadius: _borderRadius,
        );
}
