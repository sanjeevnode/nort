import 'package:flutter/material.dart';

class DynamicHeightContainer extends StatefulWidget {
  const DynamicHeightContainer({
    required this.children,
    this.padding = EdgeInsets.zero,
    super.key,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  final List<Widget> children;
  final EdgeInsets padding;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  State<DynamicHeightContainer> createState() => _DynamicHeightContainerState();
}

class _DynamicHeightContainerState extends State<DynamicHeightContainer> {
  final GlobalKey _containerKey = GlobalKey();
  double _calculatedHeight = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _calculateHeight());
  }

  void _calculateHeight() {
    final context = _containerKey.currentContext;
    if (context != null) {
      final renderBox = context.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        setState(() {
          _calculatedHeight = renderBox.size.height + widget.padding.vertical;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _containerKey,
      padding: widget.padding,
      width: double.infinity,
      height: _calculatedHeight > 0 ? _calculatedHeight : null,
      child: Column(
        crossAxisAlignment: widget.crossAxisAlignment,
        mainAxisSize: MainAxisSize.min,
        children: widget.children,
      ),
    );
  }
}
