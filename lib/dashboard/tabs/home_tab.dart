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
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hiteshsapra/theme/image_assets.dart';
import 'package:hiteshsapra/widget/custom_button.dart';
import 'package:hiteshsapra/widget/responsive.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget aboutButton() {
      return CustomButton(
        onPressed: () {
          // Define the action to be performed on button press
        },
        text: 'About Me',
        width: 230,
        height: 60,
        color: Colors.white,
        backgroundColor: theme.primaryColor,
        borderColor: theme.primaryColor,
        borderWidth: 1.0,
        borderRadius: BorderRadius.circular(30),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
        textStyle: theme.textTheme.titleSmall!.copyWith(fontSize: 16),
        animationDuration: const Duration(milliseconds: 300),
        child: Row(
          children: [
            Text(
              'Download CV',
              style: theme.textTheme.titleSmall!.copyWith(fontSize: 18),
            ),
            const SizedBox(
              width: 5,
            ),
            Icon(Icons.download, color: theme.highlightColor),
          ],
        ),
      );
    }

    Widget profilePicture(double radius) {
      return Image.asset(ImageAssets.avatar);
    }

    Widget aboutText(double fontSize, BuildContext context) {
      final theme = Theme.of(context);
      return Column(
        crossAxisAlignment: Responsive.isMobile(context)
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          Text('Hello, I\'m',
              style: theme.textTheme.titleSmall!.merge(
                TextStyle(fontSize: fontSize * 1.2, color: theme.primaryColor),
              )),
          Text('Hitesh Sapra',
              style: theme.textTheme.titleSmall!.merge(
                TextStyle(fontSize: fontSize * 2, color: theme.highlightColor),
              )),
          Text('An Experienced Software Team Leader',
              textAlign: Responsive.isMobile(context)
                  ? TextAlign.center
                  : TextAlign.left,
              style: theme.textTheme.titleSmall!.merge(
                TextStyle(fontSize: fontSize * 1, color: theme.highlightColor),
              )),
          const SizedBox(height: 20),
          Text(
              'I am skilled in Flutter, Android, iOS, Python (Django) development, JavaScript, and TypeScript. I specialize in project micro architecture and am available for work worldwide.',
              textAlign: Responsive.isMobile(context)
                  ? TextAlign.center
                  : TextAlign.left,
              style: theme.textTheme.titleSmall!.merge(
                TextStyle(fontSize: fontSize * 0.8, color: theme.hoverColor),
              )),
        ],
      );
    }

    const List<Map<String, String>> socialMedia = [
      {"image": ImageAssets.facebook, "url": 'https://www.facebook.com/onemindev/'},
      {"image": ImageAssets.instagram, "url": 'https://www.instagram.com/onemindevofficial/'},
      {"image": ImageAssets.youtube, "url": 'https://www.youtube.com/@onemindevofficial'},
      {"image": ImageAssets.linkedin, "url": 'https://www.linkedin.com/in/hiteshsapra/'},
      {"image": ImageAssets.whatsapp, "url": 'https://www.hiteshsapra.com'},
    ];

    void launchURL(String url) async {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch $url';
      }
    }

    Widget socialIcons() {
      return Row(
        mainAxisAlignment: Responsive.isMobile(context)
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: socialMedia.map((social) {
          return IconButton(
            icon: Image.asset(social["image"]!, height: 30),
            iconSize: 30,
            onPressed: () {
              launchURL(social["url"]!);
            },
          );
        }).toList(),
      );
    }

    Widget processFeature(BuildContext context) {
      int crossAxisCount = 1; // Default to mobile view
      if (!Responsive.isMobile(context)) {
        crossAxisCount = 3;
      }

      return Container(
        color: theme.secondaryHeaderColor,
        margin: EdgeInsets.symmetric(vertical: crossAxisCount == 1 ? 16 : 100),
        padding:
            EdgeInsets.symmetric(horizontal: crossAxisCount == 1 ? 16 : 150),
        child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio:
                  (MediaQuery.of(context).size.width / crossAxisCount) / 400,
            ),
            itemCount: 3,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage(index == 0
                            ? ImageAssets.icCircleRed
                            : index == 1
                                ? ImageAssets.icCirclePurple
                                : ImageAssets.icCircleYellow),
                      )),
                      child: SvgPicture.asset(
                        index == 0
                            ? ImageAssets.icPerfect
                            : index == 1
                                ? ImageAssets.icQuality
                                : ImageAssets.icIdea,
                        semanticsLabel: 'A red up arrow',
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      index == 0
                          ? 'Pixel Perfect'
                          : index == 1
                              ? 'High Quality'
                              : 'Awesome Idea',
                      style: theme.textTheme.titleSmall!
                          .merge(const TextStyle(fontSize: 24)),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Most common methods for developing software that performs well across different platforms are responsive and adaptive design.',
                      style: theme.textTheme.titleSmall!.merge(TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: theme.hoverColor)),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            }),
      );
    }

    Widget buildMobileLayout(BuildContext context) {
      return Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageAssets
                    .icHomeBgMobile), // Replace with your image asset path
                fit: BoxFit.fill,
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  AspectRatio(aspectRatio:1, child: profilePicture(60)),
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      aboutText(20, context),
                      const SizedBox(height: 20),
                      aboutButton(),
                      const SizedBox(height: 20),
                      socialIcons(),
                    ],
                  ),
                ],
              ),
            ),
          ),
          processFeature(context),
        ],
      );
    }

    Widget buildTabletLayout(BuildContext context) {
      return Column(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImageAssets
                      .icHomeBg), // Replace with your image asset path
                  fit: BoxFit.fill,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 150),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        aboutText(24, context),
                        const SizedBox(height: 20),
                        aboutButton(),
                        const SizedBox(height: 20),
                        socialIcons()
                      ],
                    ),
                  ),
                  const SizedBox(width: 40),
                  Expanded(child: profilePicture(80)),
                ],
              ),
            ),
          ),
          processFeature(context),
        ],
      );
    }

    return Responsive(
      mobile: buildMobileLayout(context),
      tablet: buildTabletLayout(context),
    );
  }
}
