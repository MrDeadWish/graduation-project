import 'dart:async';
import 'package:flutter/material.dart';

class AppSlider extends StatefulWidget {
  final List slides;
  final int? slidesCount;
  final bool? showArrows;
  final EdgeInsets? containerPadding;
  final double? buttonLeftPositionTop;
  final double? buttonLeftPositionLeft;
  final double? buttonRightPositionTop;
  final double? buttonRightPositionRight;
  final Color? buttonColor;
  const AppSlider({
    super.key,
    required this.slides,
    this.slidesCount = 4,
    this.showArrows = true,
    this.containerPadding,
    this.buttonLeftPositionTop = 10,
    this.buttonLeftPositionLeft = -7,
    this.buttonRightPositionTop = 10,
    this.buttonRightPositionRight = -7,
    this.buttonColor = Colors.black,
  });

  @override
  State<AppSlider> createState() => _AppSliderState();
}

class _AppSliderState extends State<AppSlider> {
  ScrollController _scrollController = ScrollController();
  bool buttonLeftDisabled = false;
  bool buttonRightDisabled = false;

  @override
  Widget build(BuildContext context) {
    double sumPadding = (widget.containerPadding != null
            ? widget.containerPadding!.left
            : 20) +
        (widget.containerPadding != null ? widget.containerPadding!.right : 20);

    print(sumPadding);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double sliderWidth = constraints.maxWidth -
            (widget.slides.length > widget.slidesCount! &&
                    widget.showArrows == true
                ? sumPadding
                : 0);
        double cardWidth = (sliderWidth / widget.slidesCount!);

        _updatePosition() {
          final double _offset = _scrollController.offset / cardWidth;
          final double _offsetDouble = _offset - _offset.floor();
          int _offsetInt = 0;

          _offsetInt = _offsetDouble > 0.5 ? _offset.ceil() : _offset.floor();
          if (_scrollController.offset <
              _scrollController.position.maxScrollExtent) {
            _scrollController.animateTo(
              _offsetInt * cardWidth,
              duration: const Duration(milliseconds: 500),
              curve: Curves.linear,
            );
          }
        }

        return SizedBox(
          width: double.infinity,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: widget.slides.length > widget.slidesCount! &&
                        widget.showArrows == true
                    ? (widget.containerPadding ??
                        const EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                        ))
                    : null,
                child: NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (scrollNotification is ScrollStartNotification) {
                    } else if (scrollNotification is ScrollUpdateNotification) {
                      if (_scrollController.offset <= 0) {
                        setState(
                          () {
                            buttonLeftDisabled = true;
                          },
                        );
                      } else {
                        setState(
                          () {
                            buttonLeftDisabled = false;
                          },
                        );
                      }

                      if (_scrollController.offset ==
                          _scrollController.position.maxScrollExtent) {
                        setState(
                          () {
                            buttonRightDisabled = true;
                          },
                        );
                      } else {
                        setState(
                          () {
                            buttonRightDisabled = false;
                          },
                        );
                      }
                    } else if (scrollNotification is ScrollEndNotification) {
                      Timer(
                        const Duration(milliseconds: 100),
                        () => _updatePosition(),
                      );
                    }
                    return true;
                  },
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.slides
                          .map(
                            (element) => Container(
                              width: cardWidth,
                              child: element,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),
              if (widget.slides.length > widget.slidesCount! &&
                  widget.showArrows == true)
                Positioned(
                  left: widget.buttonLeftPositionLeft,
                  top: widget.buttonLeftPositionTop,
                  child: InkWell(
                    onTap: () {
                      if (_scrollController.offset >
                          _scrollController.position.minScrollExtent) {
                        _scrollController.animateTo(
                          _scrollController.offset - cardWidth,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.linear,
                        );
                      }
                    },
                    child: Icon(
                      color: buttonLeftDisabled == true
                          ? widget.buttonColor!.withAlpha(50)
                          : widget.buttonColor!,
                      Icons.keyboard_arrow_left_outlined,
                    ),
                  ),
                ),
              if (widget.slides.length > widget.slidesCount! &&
                  widget.showArrows == true)
                Positioned(
                  right: widget.buttonRightPositionRight,
                  top: widget.buttonRightPositionTop,
                  child: InkWell(
                    onTap: () {
                      if (_scrollController.offset <
                          _scrollController.position.maxScrollExtent) {
                        _scrollController.animateTo(
                          _scrollController.offset + cardWidth,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.linear,
                        );
                      }
                    },
                    child: Icon(
                      color: buttonRightDisabled == true
                          ? widget.buttonColor!.withAlpha(50)
                          : widget.buttonColor!,
                      Icons.keyboard_arrow_right_outlined,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
