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
import 'package:hiteshsapra/widget/responsive.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceTab extends StatelessWidget {
  const ServiceTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = Responsive.isMobile(context);

    final domainList = [
      {"image": ImageAssets.icPatelwala, "url": "https://patelwala.com"},
      {"image": ImageAssets.icBujex, "url": "https://bujex.com"},
      {"image": ImageAssets.icNearfact, "url": "https://nearfact.com"},
      {"image": ImageAssets.icKeyvacy, "url": "https://keyvacy.com"},
      {"image": ImageAssets.icBoxoffice, "url": "https://boxofficemovi.com"},
      {"image": ImageAssets.icStudyza, "url": "https://studyza.com"},
      {"image": ImageAssets.icOnemindev, "url": "https://onemindev.com"},
      {"image": ImageAssets.icBhasha, "url": "https://hibhasha.com"},
    ];

    final items = [
      {
        "title": "Mobile App Development",
        "price": "\$30-40 (Hours)",
        "description":
            "Creating cross-platform mobile applications using Flutter for both Android and iOS, ensuring high performance and a native look and feel.",
        "icon": Icons.phone_android,
        "iconColor": Colors.blue
      },
      {
        "title": "Web Application Development",
        "price": "\$10-25 (Hours)",
        "description":
            "Building responsive and scalable web applications using modern frameworks and technologies, tailored to meet your business needs.",
        "icon": Icons.web,
        "iconColor": Colors.green
      },
      {
        "title": "CRM Application Development",
        "price": "\$20-30 (Hours)",
        "description":
            "Developing custom CRM applications to help you manage your customer relationships more effectively, boosting your business productivity.",
        "icon": Icons.business,
        "iconColor": Colors.red
      },
      {
        "title": "API Integration",
        "price": "\$10-15 (Hours)",
        "description":
            "Seamlessly integrating third-party APIs to enhance your application's functionality, providing a richer user experience.",
        "icon": Icons.api,
        "iconColor": Colors.orange
      },
      {
        "title": "E-commerce Solutions",
        "price": "\$20-30 (Hours)",
        "description":
            "Developing robust and scalable e-commerce platforms with secure payment gateways and user-friendly interfaces.",
        "icon": Icons.shopping_cart,
        "iconColor": Colors.purple
      },
    ];

    Widget buildGridItem(Map<String, dynamic> item) {
      return Container(
        padding: const EdgeInsets.all(16),
        margin: EdgeInsets.only(bottom: isMobile ? 16 : 0),
        decoration: BoxDecoration(
          color: theme.secondaryHeaderColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  colorFilter:
                      ColorFilter.mode(item["iconColor"], BlendMode.srcIn),
                  image: const AssetImage(ImageAssets.icFullCircleGreen),
                ),
              ),
              child: Icon(item["icon"], size: 50),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item["title"],
                    style: theme.textTheme.titleSmall!,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Starts from",
                          style: theme.textTheme.titleSmall!
                              .copyWith(fontSize: 16),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        item["price"],
                        style: theme.textTheme.titleSmall!
                            .copyWith(fontSize: 16, color: theme.primaryColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item["description"],
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleSmall!
                        .copyWith(fontSize: 16, color: theme.hoverColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget buildTextSection(double fontSize, TextAlign textAlign) {
      return Column(
        crossAxisAlignment: textAlign == TextAlign.center
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          Text(
            'Services',
            textAlign: textAlign,
            style: theme.textTheme.titleSmall!
                .copyWith(fontSize: fontSize * 1.2, color: theme.primaryColor),
          ),
          Text(
            'What I Do for Clients',
            textAlign: textAlign,
            style: theme.textTheme.titleSmall!
                .copyWith(fontSize: fontSize * 2, color: theme.highlightColor),
          ),
          const SizedBox(height: 20),
          Text(
            'Most common methods for designing websites that work well on desktop is responsive and adaptive design',
            textAlign: textAlign,
            style: theme.textTheme.titleSmall!
                .copyWith(fontSize: fontSize * 0.8, color: theme.hoverColor),
          ),
        ],
      );
    }

    Widget buildGridView(int crossAxisCount) {
      return isMobile
          ? ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return buildGridItem(items[index]);
              },
            )
          : GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: isMobile ? 2.5 : 3.5,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return buildGridItem(items[index]);
              },
            );
    }

    Widget buildTableItem(Map<String, String> item) {
      return GestureDetector(
        onTap: () async {
          final url = Uri.parse(item["url"]!);
          if (await canLaunchUrl(url)) {
            await launchUrl(url);
          } else {
            throw 'Could not launch $url';
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor.withOpacity(0.70),
            border: Border.all(color: theme.dividerColor),
          ),
          child: Center(
            child: Image.asset(item["image"]!),
          ),
        ),
      );
    }

    Widget buildTable(int crossAxisCount) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
          childAspectRatio: isMobile ? 2.5 : 3.5,
        ),
        itemCount: domainList.length,
        itemBuilder: (context, index) {
          return buildTableItem(domainList[index]);
        },
      );
    }

    Widget buildDomainLayout() {
      return Row(
        children: [
          if (!isMobile) const Expanded(flex: 1, child: SizedBox()),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Text(
                  'Domain Services',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleSmall!
                      .copyWith(fontSize: 20 * 1.2, color: theme.primaryColor),
                ),
                Text(
                  'We are ready to offer our premium park domain for sale.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleSmall!
                      .copyWith(fontSize: 20 * 2, color: theme.highlightColor),
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
                child: Image.asset(ImageAssets.ic5),
              ),
              Positioned(
                bottom: 1,
                right: 1,
                child: Image.asset(ImageAssets.ic16),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    buildTextSection(20, TextAlign.center),
                    const SizedBox(height: 20),
                    buildGridView(1),
                    const SizedBox(height: 40),
                    buildDomainLayout(),
                    const SizedBox(height: 20),
                    buildTable(2),
                  ],
                ),
              ),
            ],
          ),
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
                child: Image.asset(ImageAssets.ic5),
              ),
              Positioned(
                bottom: 20,
                right: 1,
                child: Image.asset(ImageAssets.ic16),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 150, right: 150, top: 150, bottom: 40),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Expanded(flex: 1, child: SizedBox()),
                        Expanded(
                            flex: 2,
                            child: buildTextSection(24, TextAlign.center)),
                        const Expanded(flex: 1, child: SizedBox()),
                      ],
                    ),
                    const SizedBox(height: 30),
                    buildGridView(2),
                    const SizedBox(height: 40),
                    buildDomainLayout(),
                    const SizedBox(height: 20),
                    buildTable(4),
                  ],
                ),
              ),
            ],
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
