import 'package:flutter/material.dart';
import 'package:vibe/feature/home/view/widgets/overllaped_carousel/overllaped_carousel_renderer.dart';

class OverlappedCarousel extends StatefulWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final double itemWidth;
  final double itemHeight;
  final double obscure;
  final double skewAngle;
  final int initialPage;
  final ValueChanged<int>? onPageChanged;
  final double nearCardSpacing;
  final double farCardSpacing;

  const OverlappedCarousel.builder({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.itemWidth,
    required this.itemHeight,
    this.obscure = 0,
    this.skewAngle = -0.35,
    this.initialPage = 0,
    this.onPageChanged,
    this.nearCardSpacing = 45,
    this.farCardSpacing = 50,
  });

  @override
  State<OverlappedCarousel> createState() => _OverlappedCarouselState();
}

class _OverlappedCarouselState extends State<OverlappedCarousel> {
  late final PageController _controller;
  late double currentPage;
  int _lastReportedPage = -1;

  @override
  void initState() {
    super.initState();
    currentPage = widget.initialPage.toDouble();
    _controller = PageController(
      viewportFraction: 0.25,
      initialPage: widget.initialPage,
    );

    _controller.addListener(() {
      final page = _controller.page ?? 0;
      setState(() {
        currentPage = page;
      });

      final rounded = page.round();

      if (rounded != _lastReportedPage) {
        _lastReportedPage = rounded;
        widget.onPageChanged?.call(rounded);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.itemHeight + 80,
      child: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: widget.itemCount,
            itemBuilder: (_, _) {
              return const SizedBox.shrink();
            },
          ),

          IgnorePointer(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return OverlappedCarouselRenderer(
                  centerIndex: currentPage,
                  maxWidth: constraints.maxWidth,
                  itemWidth: widget.itemWidth,
                  itemHeight: widget.itemHeight,
                  itemCount: widget.itemCount,
                  itemBuilder: widget.itemBuilder,
                  obscure: widget.obscure,
                  skewAngle: widget.skewAngle,
                  nearCardSpacing: widget.nearCardSpacing,
                  farCardSpacing: widget.farCardSpacing,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
