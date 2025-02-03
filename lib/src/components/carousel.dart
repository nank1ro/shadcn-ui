import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

enum ShadOrientation {
  horizontal,
  vertical,
}

class ShadCarousel<T> extends StatefulWidget {
  const ShadCarousel({
    super.key,
    required this.children,
    this.loop = false,
    this.spacing,
    this.endWidget,
    this.startWidget,
    this.padding,
    this.carouselHeight,
    this.carouselWidth,
    this.viewportFraction,
  })  : orientation = ShadOrientation.horizontal,
        assert(
          children.length > 1,
          'The carousel must have at least 2 children',
        );

  const ShadCarousel.vertical({
    super.key,
    required this.children,
    this.loop = false,
    this.spacing,
    this.endWidget,
    this.startWidget,
    this.padding,
    this.carouselHeight,
    this.carouselWidth,
    this.viewportFraction,
  })  : orientation = ShadOrientation.vertical,
        assert(
          children.length > 1,
          'The carousel must have at least 2 children',
        );

  final List<Widget> children;

  /// The orientation of the carousel
  final ShadOrientation orientation;

  /// Whether the carousel should loop infinitely
  final bool loop;

  /// The spacing between the children
  final double? spacing;

  ///Indicator widgget at the start of the carousel
  final Widget? startWidget;

  ///Indicator widget at the end of the carousel
  final Widget? endWidget;

  /// The padding around the carousel
  final EdgeInsetsGeometry? padding;

  /// The height of the carousel
  final double? carouselHeight;

  /// The width of the carousel
  final double? carouselWidth;

  ///An integer that represents the fraction of the viewport that each page should
  /// occupy.
  ///1.0 means the page takes up the entire viewport, 0.5 means the page takes up
  /// half the viewport, and so on.
  final double? viewportFraction;
  @override
  State<ShadCarousel<T>> createState() => _ShadCarouselState<T>();
}

class _ShadCarouselState<T> extends State<ShadCarousel<T>> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: widget.viewportFraction ?? 0.8,
    );
  }

  void _nextPage() {
    setState(() {
      if (_currentIndex <= widget.children.length) {
        _pageController.animateToPage(
          _currentIndex++,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        _currentIndex++;
      } else if (_currentIndex == widget.children.length && widget.loop) {
        _pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        _currentIndex = 0;
      }
    });
  }

  void _previousPage() {
    setState(() {
      if (_currentIndex >= 0) {
        _pageController.animateToPage(
          _currentIndex--,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        _currentIndex--;
      } else if (_currentIndex == 0 && widget.loop) {
        _pageController.animateToPage(
          widget.children.length,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        _currentIndex = widget.children.length;
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context).carouselTheme;

    ///Chckinng the orientation of the carousel
    final horizontalOrientation =
        widget.orientation == ShadOrientation.horizontal;

    final effectiveHeight = widget.carouselHeight ??
        theme.carouselHeight ??
        MediaQuery.sizeOf(context).height;

    final effectiveWidth = widget.carouselWidth ??
        theme.carouselWidth ??
        MediaQuery.sizeOf(context).width;

    /// A variable for effective carousel padding
    final effectivePadding =
        widget.padding ?? theme.padding ?? const EdgeInsets.all(4);

    return SizedBox(
      height: effectiveHeight,
      width: effectiveWidth,
      child: ListView(
        scrollDirection:
            horizontalOrientation ? Axis.horizontal : Axis.vertical,
        children: [
          _buildCarouselButton(
            context,
            widget.startWidget ?? const Icon(Icons.arrow_back),
            _previousPage,
          ),
          Container(
            padding: effectivePadding,
            height: horizontalOrientation
                ? MediaQuery.sizeOf(context).height
                : MediaQuery.sizeOf(context).height * .8,
            width: horizontalOrientation
                ? MediaQuery.sizeOf(context).width * .8
                : MediaQuery.sizeOf(context).width,
            child: PageView.builder(
              itemCount: widget.children.length,
              scrollDirection:
                  horizontalOrientation ? Axis.horizontal : Axis.vertical,
              controller: _pageController,
              itemBuilder: (context, index) {
                return Padding(
                  padding: effectivePadding,
                  child: widget.children[index],
                );
              },
            ),
          ),
          _buildCarouselButton(
            context,
            widget.endWidget ?? const Icon(Icons.arrow_forward),
            _nextPage,
          ),
        ],
      ),
    );
  }
}

Widget _buildCarouselButton(
  BuildContext context,
  Widget child,
  VoidCallback onPressed,
) {
  return ShadGestureDetector(
    onTap: onPressed,
    child: child,
  );
}

@immutable
class ShadCarouselTheme {
  const ShadCarouselTheme({
    required this.padding,
    required this.carouselHeight,
    required this.carouselWidth,
    required this.viewportFraction,
    required this.spacing,
    required this.startWidget,
    required this.endWidget,
  });

  final EdgeInsetsGeometry? padding;
  final double? carouselHeight;
  final double? carouselWidth;
  final double viewportFraction;
  final double? spacing;
  final Widget? startWidget;
  final Widget? endWidget;
}
