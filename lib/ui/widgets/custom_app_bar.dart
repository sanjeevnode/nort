import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nort/core/core.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.enableBack = false,
    this.onPop,
    this.height = 60,
    this.prefix,
  });
  final String title;
  final List<Widget>? actions;
  final bool enableBack;
  final double height;
  final void Function()? onPop;
  final Widget? prefix;

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Material(
        elevation: 1,
        child: Container(
          height: preferredSize.height,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (enableBack)
                IconButton(
                  padding: const EdgeInsets.only(left: 20, right: 12),
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    onPop?.call();
                    Navigator.of(context).pop();
                  },
                  icon: SvgPicture.asset(
                    'assets/icons/chevron_left.svg',
                    width: 20,
                    height: 20,
                    colorFilter: const ColorFilter.mode(
                        AppColors.dark900, BlendMode.srcIn),
                  ),
                )
              else
                const SizedBox(width: 20),
              if (prefix != null) ...[
                prefix!,
                const SizedBox(width: 6),
              ],
              Text(
                title,
                style: AppTextStyle.textMdSemibold,
              ),
              const SizedBox(width: 20),
              if (actions != null)
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: actions!,
                  ),
                ),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ),
    );
  }
}
