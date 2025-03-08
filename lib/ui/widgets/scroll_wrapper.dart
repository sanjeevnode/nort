import 'package:flutter/material.dart';

class ScrollWrapper extends StatelessWidget {
  const ScrollWrapper({
    super.key,
    required this.children,
    required this.height,
    this.width,
    this.scrollController,
    this.mainAxisAlignment=MainAxisAlignment.start,
    this.crossAxisAlignment=CrossAxisAlignment.start,
    this.padding=const EdgeInsets.all(24),
  });

  final List<Widget> children;
  final double height;
  final double? width;
  final EdgeInsets padding;
  final ScrollController? scrollController;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          children: children,
        ),
      ),
    );
  }
}
