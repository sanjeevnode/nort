import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nort/core/core.dart';

class NoteItem extends StatefulWidget {
  const NoteItem({
    super.key,
    this.title = '',
    this.lastUpdated = '',
    this.onTap,
  });

  final String title;
  final String lastUpdated;
  final void Function()? onTap;

  @override
  State<NoteItem> createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  late final Color _circleColor;
  bool _isTapped = false;

  @override
  void initState() {
    super.initState();
    _circleColor = _generateRandomDarkColor();
  }

  Color _generateRandomDarkColor() {
    final random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(156),
      random.nextInt(156),
      random.nextInt(156),
    );
  }

  String _getFirstWordCapitalized(String text) {
    final words = text.split(' ');
    if (words.isEmpty || words.first.isEmpty) return '?';
    return words.first[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isTapped = true),
      onTap: () {
        widget.onTap?.call();
        Future.delayed(const Duration(milliseconds: 100), () {
          setState(() => _isTapped = false);
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _isTapped ? AppColors.light500 : AppColors.light100,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: _circleColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  _getFirstWordCapitalized(widget.title),
                  style: AppTextStyle.textXlRegular.copyWith(
                    color: AppColors.light100,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.textMdMedium.copyWith(
                      color: AppColors.dark900,
                    ),
                  ),
                  Text(
                    'Last updated : ${widget.lastUpdated}',
                    style: AppTextStyle.textSmRegular.copyWith(
                      color: AppColors.dark100,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
