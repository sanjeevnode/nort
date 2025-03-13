import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nort/core/core.dart';

class NavItem extends StatefulWidget {
  const NavItem({
    super.key,
    required this.iconPath,
    this.isActive = false,
    this.size = 28,
    this.onPressed,
  });

  final bool isActive;
  final double size;
  final String iconPath;
  final void Function()? onPressed;

  @override
  State<NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<NavItem> {
  @override
  Widget build(BuildContext context) {
    final color = widget.isActive ? AppColors.dark900 : AppColors.dark100;
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
        decoration: BoxDecoration(
          color: widget.isActive
              ? AppColors.light300.withOpacity(.7)
              : AppColors.light100,
          border: Border(
            top: BorderSide(
              color: widget.isActive ? AppColors.primary : Colors.transparent,
              width: 1,
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              widget.iconPath,
              width: widget.size,
              height: widget.size,
              colorFilter: ColorFilter.mode(
                color,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
