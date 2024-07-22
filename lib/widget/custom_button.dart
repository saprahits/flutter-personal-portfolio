/*
 * Project Name: Flutter Personal Portfolio
 *
 * Description: This project is a Flutter-based personal portfolio template. It is designed to be
 *              easily customizable and can be used by anyone for free.
 *
 * Copyright (c) 2024 Hitesh Sapra
 * Website: https://www.hiteshsapra.com
 *
 * License: Permission is hereby granted, free of charge, to any person obtaining a copy of this
 *          software and associated documentation files (the "Software"), to deal in the Software
 *          without restriction, including without limitation the rights to use, copy, modify,
 *          merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
 *          permit persons to whom the Software is furnished to do so, subject to the following
 *          conditions:
 *
 *          The above copyright notice and this permission notice shall be included in all copies
 *          or substantial portions of the Software.
 *
 *          THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
 *          INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
 *          PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 *          LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT
 *          OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 *          OTHER DEALINGS IN THE SOFTWARE.
 *
 * Credit: This project is created by Hitesh Sapra. If you use this project or any part of it, please
 *         give credit to the original author by including the following link: https://www.hiteshsapra.com
 */


import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double? width;
  final double? height;
  final Color? color;
  final Color? backgroundColor;
  final double borderWidth;
  final Color borderColor;
  final BorderRadiusGeometry borderRadius;
  final EdgeInsetsGeometry padding;
  final TextStyle? textStyle;
  final Duration animationDuration;
  final Widget? child;

  final RxBool _isHovered = true.obs; // Rx variable for hover state

  CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.width,
    this.child,
    this.height,
    this.color,
    this.backgroundColor,
    this.borderWidth = 1.0,
    this.borderColor = Colors.blue,
    this.borderRadius = const BorderRadius.all(Radius.circular(30.0)),
    this.padding = const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
    this.textStyle,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => MouseRegion(
        onEnter: (_) => _isHovered.value = false,
        onExit: (_) => _isHovered.value = true,
        child: AnimatedContainer(
          duration: animationDuration,
          width: width,
          height: height,
          decoration: BoxDecoration(
            gradient: _isHovered.value
                ? LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                backgroundColor ?? borderColor.withOpacity(0.3),
                backgroundColor ?? borderColor.withOpacity(0.1),
              ],
            )
                : null,
            border: Border.all(color: borderColor, width: borderWidth),
            borderRadius: borderRadius,
          ),
          child: OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: borderColor, width: borderWidth),
              shape: RoundedRectangleBorder(
                borderRadius: borderRadius,
              ),
              padding: padding,
              backgroundColor: Colors.transparent, // Transparent to let AnimatedContainer handle the background
            ),
            child: child ?? Text(
              text,
              style: textStyle ?? Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}



class AnimatedGradientContainer extends StatefulWidget {
  final bool isHovered;
  final Duration duration;
  final Color startColor;
  final Color endColor;
  final double width;
  final double height;

  const AnimatedGradientContainer({
    super.key,
    required this.isHovered,
    this.duration = const Duration(milliseconds: 300),
    required this.startColor,
    required this.endColor,
    required this.width,
    required this.height,
  });

  @override
  AnimatedGradientContainerState createState() => AnimatedGradientContainerState();
}

class AnimatedGradientContainerState extends State<AnimatedGradientContainer> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: widget.duration,
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: widget.isHovered
              ? [widget.startColor, widget.endColor]
              : [widget.endColor, widget.endColor],
        ),
      ),
    );
  }
}
