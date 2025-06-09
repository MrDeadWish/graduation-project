import 'package:flutter/material.dart';

var height = AppBar().preferredSize.height;

void showModal(
    {required BuildContext context,
    required Widget child,
    Widget? header,
    Widget? footer,
    EdgeInsets? padding,
    Function? onClose,
    bool custom = false}) async {
  await showModalBottomSheet(
    context: context,
    isDismissible: false,
    isScrollControlled: true,
    useRootNavigator: false,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20.0),
      ),
    ),
    builder: (context) {
      final scrollController = ScrollController();
      bool isClose = false;
      scrollController.addListener(() {
        if (scrollController.position.pixels <
            -MediaQuery.of(context).size.height * 0.2) {
          if (!isClose) {
            Navigator.of(context).pop();
            isClose = true;
          }
        }
      });
      return Container(
        padding: const EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: 40,
        ),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height - height,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (header != null) header,
            Flexible(
              child: SingleChildScrollView(
                controller: scrollController,
                child: child,
              ),
            ),
            if (footer != null) footer,
          ],
        ),
      );
    },
  ).whenComplete(() {
    if (onClose != null) {
      onClose();
    }
  });
}
