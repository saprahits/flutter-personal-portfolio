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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiteshsapra/dashboard/dashboard_controller.dart';
import 'package:hiteshsapra/theme/image_assets.dart';
import 'package:hiteshsapra/widget/responsive.dart';

class PortfolioTab extends StatelessWidget {
  final DashboardController controller;
  const PortfolioTab({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isMobile = Responsive.isMobile(context);

    Widget buildTextSection(String title, String subtitle, String description,
        double fontSize, TextAlign textAlign) {
      return Column(
        crossAxisAlignment: textAlign == TextAlign.center
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: textAlign,
            style: theme.textTheme.titleSmall!.copyWith(
              fontSize: fontSize * 1.2,
              color: theme.primaryColor,
            ),
          ),
          Text(
            subtitle,
            textAlign: textAlign,
            style: theme.textTheme.titleSmall!.copyWith(
              fontSize: fontSize * 2,
              color: theme.highlightColor,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            description,
            textAlign: textAlign,
            style: theme.textTheme.titleSmall!.copyWith(
              fontSize: fontSize * 0.8,
              color: theme.hoverColor,
            ),
          ),
        ],
      );
    }

    Widget buildBlogItem(PortfolioItem item) {
      return GestureDetector(
        onTap: () async {},
        child: Container(
          decoration: BoxDecoration(
            color: theme.secondaryHeaderColor.withOpacity(0.6),
            borderRadius: BorderRadius.circular(16),
          ),
          margin: EdgeInsets.only(bottom: isMobile ? 16:0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 120,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Stack(
                    children: [
                      ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(
                              0.8), // Change the opacity value as needed
                          BlendMode.dstATop,
                        ),
                        child: CachedNetworkImage(
                          width: double.infinity,
                          height: double.infinity,
                          imageUrl: item.imageUrl,
                          fit: BoxFit.contain,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) {
                            return const Icon(Icons.error);
                          },
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            item.date,
                            style: theme.textTheme.titleSmall!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.category,
                      style: theme.textTheme.titleSmall!
                          .copyWith(color: theme.primaryColor)
                          .copyWith(fontSize: 20),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style:
                      theme.textTheme.titleSmall!.copyWith(fontSize: 18),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }

    Widget buildBlogGrid(int crossAxisCount) {
      return Obx(
        () => Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: controller.categories.map((category) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ChoiceChip(
                      label: Text(category),
                      selected: controller.selectedCategory.value == category,
                      onSelected: (bool selected) {
                        if (selected) {
                          controller.changeCategory(category);
                        }
                      },
                      selectedColor: theme.primaryColor,
                      backgroundColor: theme.scaffoldBackgroundColor,
                      labelStyle:
                          theme.textTheme.titleSmall!.copyWith(fontSize: 16),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            isMobile
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.filteredItems.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return buildBlogItem(controller.filteredItems[index]);
                    })
                : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 2,
                    ),
                    itemCount: controller.filteredItems.length,
                    itemBuilder: (context, index) {
                      return buildBlogItem(controller.filteredItems[index]);
                    },
                  ),
          ],
        ),
      );
    }

    Widget buildMobileLayout() {
      return Column(
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Image.asset(ImageAssets.ic12),
              ),
              Positioned(
                bottom: 1,
                right: 1,
                child: Image.asset(ImageAssets.ic22),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    buildTextSection(
                        'Portfolio',
                        'My Amazing Works',
                        'Two popular approaches for creating mobile applications that provide a seamless user experience are native development and cross-platform development.',
                        20,
                        TextAlign.center),
                    const SizedBox(height: 20),
                    buildBlogGrid(1),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              children: [
                Positioned(
                  bottom: 20,
                  right: 1,
                  child: Image.asset(ImageAssets.ic6),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    AspectRatio(
                        aspectRatio: 1,
                        child: Image.asset(ImageAssets.icSkills)),
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        buildTextSection(
                            "Coding is Life",
                            "I Continuously Develop Skills to Stay Updated",
                            "Two popular methods for building effective desktop applications are modular design and microservices architecture",
                            20,
                            TextAlign.center),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ],
                ),
              ],
            ),
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
                top: 1,
                left: 150,
                child: Image.asset(ImageAssets.ic12),
              ),
              Positioned(
                bottom: 20,
                right: 1,
                child: Image.asset(ImageAssets.ic22),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 150, right: 150, top: 150, bottom: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Expanded(flex: 1, child: SizedBox()),
                        Expanded(
                            flex: 2,
                            child: buildTextSection(
                                'Portfolio',
                                'My Amazing Works',
                                'Two popular approaches for creating mobile applications that provide a seamless user experience are native development and cross-platform development.',
                                24,
                                TextAlign.center)),
                        const Expanded(flex: 1, child: SizedBox()),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    buildBlogGrid(3),
                  ],
                ),
              ),
            ],
          ),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Stack(
              children: [
                Positioned(
                  bottom: 20,
                  right: 1,
                  child: Image.asset(ImageAssets.ic6),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildTextSection(
                                "Coding is Life",
                                "I Continuously Develop Skills to Stay Updated",
                                "Two popular methods for building effective desktop applications are modular design and microservices architecture",
                                24,
                                TextAlign.left),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                      const SizedBox(width: 40),
                      Expanded(child: Image.asset(ImageAssets.icSkills)),
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
