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
import 'package:hiteshsapra/theme/image_assets.dart';
import 'package:hiteshsapra/widget/custom_button.dart';
import 'package:hiteshsapra/widget/responsive.dart';

class AboutTab extends StatelessWidget {
  const AboutTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget hireMeButton() {
      return CustomButton(
        onPressed: () {
          // Define the action to be performed on button press
        },
        text: 'Hire Me',
        width: 200,
        height: 50,
        color: theme.primaryColor,
        backgroundColor: theme.primaryColor,
        borderColor: theme.primaryColor,
        borderWidth: 1.0,
        borderRadius: BorderRadius.circular(30),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
        textStyle: theme.textTheme.titleSmall!.copyWith(fontSize: 16),
        animationDuration: const Duration(milliseconds: 300),
      );
    }

    Widget profilePicture() {
      return Image.asset(ImageAssets.icTmAbout);
    }

    Widget aboutText(double fontSize) {
      return Column(
        crossAxisAlignment: Responsive.isMobile(context)
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          Text(
            'I\'m a Software Developer',
            style: theme.textTheme.titleSmall!.copyWith(
              fontSize: fontSize * 1.2,
              color: theme.primaryColor,
            ),
          ),
          Text(
            'I can create anything you need',
            textAlign: Responsive.isMobile(context)
                ? TextAlign.center
                : TextAlign.left,
            style: theme.textTheme.titleSmall!.copyWith(
              fontSize: fontSize * 2,
              color: theme.highlightColor,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Hello there! I\'m a developer with 9 years of experience, passionate and dedicated to my work. With a solid background in both mobile and web application development, I have acquired the skills and knowledge necessary to make your project a success. I specialize in creating robust and user-friendly mobile applications, CRM systems, and web applications. I enjoy every step of the development process, from initial discussion and collaboration to final deployment and support. Whether you need a sophisticated mobile app, an efficient CRM, or a seamless web application, I can bring your vision to life.',
            textAlign: Responsive.isMobile(context)
                ? TextAlign.center
                : TextAlign.left,
            style: theme.textTheme.titleSmall!.copyWith(
              fontSize: fontSize * 0.8,
              color: theme.hoverColor,
            ),
          ),
        ],
      );
    }

    Widget cardData(String number, String text, Color color) {
      return Container(
        width: Responsive.isMobile(context) ? double.infinity : 200,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.secondaryHeaderColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Responsive.isMobile(context)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    number,
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: color,
                      fontSize: 40,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    text,
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: theme.hoverColor,
                      fontSize: 18,
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    number,
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: color,
                      fontSize: 40,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      text,
                      style: theme.textTheme.titleMedium!.copyWith(
                        color: theme.hoverColor,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
      );
    }

    Widget buildMobileLayout() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(ImageAssets.ic11),
            ),
            Positioned(
              bottom: 1,
              right: 1,
              child: Image.asset(ImageAssets.ic2),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                AspectRatio(
                  aspectRatio: 1,
                  child: profilePicture(),
                ),
                cardData('9+', 'Years of Success', const Color(0xff1cbe59)),
                const SizedBox(height: 20),
                cardData('40+', 'Total Projects', const Color(0xff6e50f0)),
                const SizedBox(height: 20),
                aboutText(20),
                const SizedBox(height: 20),
                hireMeButton(),
                const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      );
    }

    Widget buildTabletLayout() {
      return Stack(
        children: [
          Positioned(
            left: 150,
            top: 100,
            child: Image.asset(ImageAssets.ic11),
          ),
          Positioned(
            bottom: 1,
            right: 1,
            child: Image.asset(ImageAssets.ic2),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 150, right: 150, top: 150, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    profilePicture(),
                    Positioned(
                        top: 100,
                        left: 50,
                        child: cardData(
                            '9+', 'Years of Success', const Color(0xff1cbe59))),
                    Positioned(
                        bottom: 100,
                        right: 50,
                        child: cardData(
                            '40+', 'Total Projects', const Color(0xff6e50f0))),
                  ],
                ),
                const SizedBox(width: 40),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      aboutText(24),
                      const SizedBox(height: 20),
                      hireMeButton(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    return Container(
      color: theme.scaffoldBackgroundColor,
      child: Responsive(
        mobile: buildMobileLayout(),
        tablet: buildTabletLayout(),
      ),
    );
  }
}
