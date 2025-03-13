import 'package:flutter/material.dart';
import 'package:nort/core/core.dart';

class AppBottomSheet {
  final BuildContext context;

  AppBottomSheet(this.context);

  Future<T?> showDefaultBottomSheet<T>({
    required Widget child,
    double? height,
    EdgeInsets padding = const EdgeInsets.all(20),
    void Function()? onModalCloseCallBack,
    bool isDismissible = false,
    bool enableDrag = true,
  }) {
    return showModalBottomSheet<T>(
        context: context,
        isDismissible: isDismissible,
        enableDrag: enableDrag,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return PopScope(
            canPop: isDismissible,
            onPopInvoked: (didPop) {
              if (didPop) {
                onModalCloseCallBack?.call();
              }
            },
            child: Container(
              height: height,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.light100,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                border: Border(
                  top: BorderSide(
                    color: AppColors.dark100,
                    width: 1,
                  ),
                  left: BorderSide(
                    color: AppColors.dark100,
                    width: 1,
                  ),
                  right: BorderSide(
                    color: AppColors.dark100,
                    width: 1,
                  ),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        padding: const EdgeInsets.all(10),
                        icon: const Icon(
                          Icons.close_rounded,
                          size: 20,
                          color: AppColors.dark900,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: padding,
                    child: child,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
