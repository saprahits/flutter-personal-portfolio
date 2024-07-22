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

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hiteshsapra/theme/image_assets.dart';
import 'package:hiteshsapra/widget/custom_button.dart';
import 'package:hiteshsapra/widget/responsive.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactTab extends StatelessWidget {
  const ContactTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = Responsive.isMobile(context);

    final contactItems = [
      {
        "icon": Icons.location_on,
        "iconColor": Colors.orange,
        "title": "Address",
        "subtitle": "Ahmedabad, India",
      },
      {
        "icon": Icons.email,
        "iconColor": Colors.green,
        "title": "Email",
        "subtitle": "hiteshsapra@hiteshsapra.com",
        "url": "mailto:hiteshsapra@hiteshsapra.com"
      },
      {
        "icon": Icons.phone,
        "iconColor": Colors.purple,
        "title": "Phone",
        "subtitle": "+91 960160 5922",
        "url": "tel:+919601605922"
      },
    ];

    InputDecoration inputDecoration(String labelText) {
      return InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: theme.primaryColor),
        ),
      );
    }

    Widget buildContactItem(Map<String, dynamic> item) {
      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: item["iconColor"],
              child: Icon(item["icon"], color: Colors.white),
            ),
            const SizedBox(width: 20),
            TextButton(
              style: ButtonStyle(
                padding: WidgetStateProperty.all(const EdgeInsets.all(10)),
              ),
              onPressed: () async {
                if (item["url"] != null) {
                  final url = Uri.parse(item["url"]!);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item["title"]!,
                    style: theme.textTheme.titleSmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item["subtitle"]!,
                    style: theme.textTheme.titleSmall!
                        .copyWith(color: theme.primaryColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget buildContactForm() {
      return Column(
        crossAxisAlignment:
            isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: inputDecoration('Your Name'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  decoration: inputDecoration('Your Email'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: inputDecoration('Your Phone'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  decoration: inputDecoration('Subject'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextFormField(
            maxLines: 5,
            decoration: inputDecoration('Write your message here'),
          ),
          const SizedBox(height: 16),
          CustomButton(
            onPressed: () {
              // Define the action to be performed on button press
            },
            text: 'Submit Now',
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
          )
        ],
      );
    }

    Widget buildHeading() {
      return Row(
        children: [
          if (!isMobile) const Expanded(flex: 1, child: SizedBox()),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Text(
                  'Contact Me',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleSmall!
                      .copyWith(fontSize: 20 * 1.2, color: theme.primaryColor),
                ),
                if (!isMobile)
                  const SizedBox(
                    height: 20,
                  ),
                Text(
                  'I Want To Hear From You',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleSmall!
                      .copyWith(fontSize: 20 * 2, color: theme.highlightColor),
                ),
                const SizedBox(height: 20),
                Text(
                  'Please fill out the form on this section to contact with me. Or call between 9:00 a.m. and 8:00 p.m. ET, Monday through Friday',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleSmall!.merge(
                    TextStyle(fontSize: 20 * 0.8, color: theme.hoverColor),
                  ),
                ),
                if (!isMobile)
                  const SizedBox(
                    height: 30,
                  ),
              ],
            ),
          ),
          if (!isMobile) const Expanded(flex: 1, child: SizedBox()),
        ],
      );
    }

    Widget buildMobileLayout() {
      return Column(
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Image.asset(ImageAssets.ic110),
              ),
              Positioned(
                bottom: 1,
                right: 1,
                child: Image.asset(ImageAssets.ic26),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    buildHeading(),
                    const SizedBox(height: 20),
                    ...contactItems.map(buildContactItem),
                    const SizedBox(height: 32),
                    buildContactForm(),
                  ],
                ),
              ),
            ],
          ),
          const Footer(),
        ],
      );
    }

    Widget buildTabletLayout() {
      return Column(
        children: [
          Stack(
            children: [
              Positioned(
                top: 100,
                left: 1,
                child: Image.asset(ImageAssets.ic110),
              ),
              Positioned(
                bottom: 20,
                right: 1,
                child: Image.asset(ImageAssets.ic26),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 150, right: 150, top: 150, bottom: 150),
                child: Column(
                  children: [
                    buildHeading(),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children:
                                contactItems.map(buildContactItem).toList(),
                          ),
                        ),
                        const SizedBox(width: 32),
                        Expanded(
                          child: buildContactForm(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Footer(),
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

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = Responsive.isMobile(context);

    return Container(
      color: theme.secondaryHeaderColor,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Developed with love by ',
                  style: theme.textTheme.titleSmall!
                      .copyWith(fontSize: 18, color: theme.hoverColor),
                ),
                TextSpan(
                  text: 'OneMinDev ',
                  style: theme.textTheme.titleSmall!.copyWith(
                    fontSize: 18,
                    color: theme.hoverColor,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      final url = Uri.parse("https://www.onemindev.com");
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                ),
                TextSpan(
                  text: '© ${DateTime.now().year}',
                  style: theme.textTheme.titleSmall!
                      .copyWith(fontSize: 18, color: theme.hoverColor),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  'Terms & Condition',
                  style: theme.textTheme.titleSmall!.copyWith(fontSize: 16),
                ),
              ),
              if (!isMobile) const SizedBox(width: 16),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Privacy Policy',
                  style: theme.textTheme.titleSmall!.copyWith(fontSize: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
