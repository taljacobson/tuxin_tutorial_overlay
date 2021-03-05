import 'package:flutter/widgets.dart';

class OverlayData {
  final OverlayEntry entry;
  final int enabledVisibleWidgetsCount;
  final int disabledVisibleWidgetsCount;
  final bool detectWidgetPositionNSizeChanges;
  final String tagName;
  final BuildContext context;
  final AnimationController animationController;
  final List<GlobalKey> widgetsGlobalKeys;
  final Function hideOverlay;
  final Function showOverlay;
  final String uuid;
  final bool isOverlayBgTransparent;

  OverlayData({
    required this.entry,
    required this.tagName,
    required this.context,
    required this.hideOverlay,
    required this.showOverlay,
    required this.uuid,
    required this.animationController,
    required this.widgetsGlobalKeys,
    this.enabledVisibleWidgetsCount = 0,
    this.disabledVisibleWidgetsCount = 0,
    this.detectWidgetPositionNSizeChanges = true,
    this.isOverlayBgTransparent = false,
  });
}
