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
import 'package:hiteshsapra/theme/image_assets.dart';
import 'package:hiteshsapra/widget/responsive.dart';

class BlogTab extends StatelessWidget {
  const BlogTab({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isMobile = Responsive.isMobile(context);

    final blogList = [
      {
        "title": "Jim Morisson Says when the musics over turn off the light",
        "category": "Web Development",
        "date": "23 Dec",
        "image": "assets/blog1.jpg",
        "url": "https://example.com/blog1"
      },
      {
        "title": "How to be appreciated for your hard work as a developer",
        "category": "Branding",
        "date": "23 Dec",
        "image": "assets/blog2.jpg",
        "url": "https://example.com/blog2"
      },
      {
        "title": "How designers and developers can collaborate better",
        "category": "Social Media",
        "date": "23 Dec",
        "image": "assets/blog3.jpg",
        "url": "https://example.com/blog3"
      },
      {
        "title": "Jim Morisson Says when the musics over turn off the light",
        "category": "Web Development",
        "date": "23 Dec",
        "image": "assets/blog1.jpg",
        "url": "https://example.com/blog1"
      },
      {
        "title": "How to be appreciated for your hard work as a developer",
        "category": "Branding",
        "date": "23 Dec",
        "image": "assets/blog2.jpg",
        "url": "https://example.com/blog2"
      }
    ];

    Widget buildBlogItem(Map<String, String> item) {
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
                height: 200,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        width: double.infinity,
                        height: double.infinity,
                        imageUrl:
                            "https://hiteshsapra.com/images/hiteshicon.jpeg",
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) {
                          return const Icon(Icons.error);
                        },
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
                            item["date"]!,
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
                      item["category"]!,
                      style: theme.textTheme.titleSmall!
                          .copyWith(color: theme.primaryColor)
                          .copyWith(fontSize: 20),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item["title"]!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style:
                          theme.textTheme.titleSmall!.copyWith(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget buildBlogGrid(int crossAxisCount) {
      return isMobile
          ? ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: blogList.length,
              itemBuilder: (context, index) {
                return buildBlogItem(blogList[index]);
              },
            )
          : GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.3,
              ),
              itemCount: blogList.length,
              itemBuilder: (context, index) {
                return buildBlogItem(blogList[index]);
              },
            );
    }

    Widget buildHeading() {
      return Row(
        children: [
          if (!isMobile) const Expanded(flex: 1, child: SizedBox()),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Text(
                  'From My Blog',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleSmall!
                      .copyWith(fontSize: 20 * 1.2, color: theme.primaryColor),
                ),
                Text(
                  'Our Recent Updates, Blog, Tips, Tricks & More',
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
                child: Image.asset(ImageAssets.ic1),
              ),
              Positioned(
                bottom: 1,
                right: 1,
                child: Image.asset(ImageAssets.ic25),
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
                    buildBlogGrid(1),
                    const SizedBox(height: 20),
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
                top: 1,
                left: 100,
                child: Image.asset(ImageAssets.ic1),
              ),
              Positioned(
                bottom: 20,
                right: 1,
                child: Image.asset(ImageAssets.ic25),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 150, right: 150, top: 150, bottom: 40),
                child: Column(
                  children: [
                    buildHeading(),
                    const SizedBox(height: 30),
                    buildBlogGrid(3),
                    const SizedBox(height: 30),
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
