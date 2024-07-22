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

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hiteshsapra/dashboard/tabs/about_tab.dart';
import 'package:hiteshsapra/dashboard/tabs/blog_tab.dart';
import 'package:hiteshsapra/dashboard/tabs/contact_tab.dart';
import 'package:hiteshsapra/dashboard/tabs/home_tab.dart';
import 'package:hiteshsapra/dashboard/tabs/portfolio_tab.dart';
import 'package:hiteshsapra/dashboard/tabs/service_tab.dart';
import 'package:hiteshsapra/theme/image_assets.dart';
import 'package:hiteshsapra/widget/responsive.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../theme/theme_controller.dart';
import 'dashboard_controller.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ThemeController themeController = Get.find();
  final DashboardController controller = Get.find();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    super.initState();
    controller.init();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = Responsive.isMobile(context);

    final List<Widget> itemTabs = [
      const HomeTab(),
      const AboutTab(),
      PortfolioTab(
        controller: controller,
      ),
      const ServiceTab(),
      const BlogTab(),
      const ContactTab(),
    ];

    return Responsive(
      mobile: SafeArea(
          top: kIsWeb ? false : true,
          child: _buildBody(context, theme, isMobile, itemTabs)),
      tablet: _buildBody(context, theme, isMobile, itemTabs),
    );
  }

  Widget _buildBody(BuildContext context, ThemeData theme, bool isMobile,
      List<Widget> itemTabs) {
    return Scaffold(
      backgroundColor: theme.secondaryHeaderColor,
      body: Stack(
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              controller.updateScrollOffset(notification);
              return true;
            },
            child: ScrollablePositionedList.builder(
                itemCount: itemTabs.length,
                itemBuilder: (context, index) {
                  return itemTabs[index];
                },
                itemScrollController: controller.itemScrollController,
                itemPositionsListener: controller.itemPositionsListener,
                scrollOffsetListener: controller.scrollOffsetListener,
                scrollOffsetController: controller.scrollOffsetController),
          ),
          SizedBox(
            height: isMobile ? 60 : 120,
            child: Obx(
              () => AppBar(
                centerTitle: false,
                scrolledUnderElevation: 0,
                elevation: controller.isScrolledMoreThan150.isTrue ? 5 : 0,
                toolbarHeight: isMobile ? 60 : 120,
                backgroundColor: controller.isScrolledMoreThan150.isTrue
                    ? theme.scaffoldBackgroundColor
                    : Colors.transparent,
                automaticallyImplyLeading: false,
                titleSpacing: isMobile ? 10 : 100,
                title: _buildTitle(theme, isMobile),
                actions: _buildActions(context, isMobile),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row _buildTitle(ThemeData theme, bool isMobile) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: isMobile ? 40 : 60,
          width: isMobile ? 40 : 60,
          decoration: BoxDecoration(
            color: controller.isScrolledMoreThan150.isTrue
                ? theme.secondaryHeaderColor
                : theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(isMobile ? 20 : 30),
          ),
          child: SvgPicture.asset(
            ImageAssets.icHsLogo,
            height: isMobile ? 40 : 60,
            width: isMobile ? 40 : 60,
            semanticsLabel: 'A red up arrow',
            allowDrawingOutsideViewBox: false,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          'Hitesh',
          style: theme.textTheme.titleSmall!.merge(
            TextStyle(
                fontSize: isMobile ? 25 : 50, fontFamily: 'NikeFuturaNDEng'),
          ),
        ),
        const SizedBox(width: 2),
        Text(
          'Sapra',
          style: theme.textTheme.titleMedium!.merge(
            TextStyle(
                fontSize: isMobile ? 25 : 50, fontFamily: 'NikeFuturaNDEng'),
          ),
        ),
        if (!isMobile) ...[
          const Expanded(child: SizedBox()),
          Flexible(
            child: Container(
              height: 100,
              alignment: Alignment.centerRight,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.tabs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Obx(
                    () => Container(
                      margin: const EdgeInsets.only(right: 30),
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          controller.scrollToIndex(index);
                        },
                        child: Text(
                          controller.tabs[index],
                          style: controller.currentIndex.value == index
                              ? theme.textTheme.titleMedium!.merge(
                                  const TextStyle(fontSize: 20),
                                )
                              : theme.textTheme.titleSmall!.merge(
                                  const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ],
    );
  }

  List<Widget> _buildActions(BuildContext context, bool isMobile) {
    final theme = Theme.of(context);
    return [
      if (isMobile)
        IconButton(
            onPressed: () {
              Get.bottomSheet(
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (int index = 0;
                          index < controller.tabs.length;
                          index++)
                        Obx(() => GestureDetector(
                              onTap: () {
                                controller.scrollToIndex(index);
                                Get.back();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  controller.tabs[index],
                                  style: theme.textTheme.titleSmall!.copyWith(
                                      fontSize: 16,
                                      color:
                                          controller.currentIndex.value == index
                                              ? theme.primaryColor
                                              : theme.hoverColor),
                                ),
                              ),
                            )),
                    ],
                  ),
                ),
                backgroundColor: theme.scaffoldBackgroundColor,
                shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(16.0)),
                ),
              );
            },
            icon: const Icon(Icons.menu)),
      PopupMenuButton<ThemeMode>(
        icon: Obx(
          () => Icon(_getThemeIcon(themeController.themeMode.value)),
        ),
        onSelected: (ThemeMode mode) {
          themeController.switchTheme(mode);
        },
        itemBuilder: (BuildContext context) {
          return const [
            PopupMenuItem<ThemeMode>(
              value: ThemeMode.light,
              child: Text('Light Mode'),
            ),
            PopupMenuItem<ThemeMode>(
              value: ThemeMode.dark,
              child: Text('Dark Mode'),
            ),
            PopupMenuItem<ThemeMode>(
              value: ThemeMode.system,
              child: Text('System Mode'),
            ),
          ];
        },
      ),
      SizedBox(width: isMobile ? 10 : 100),
    ];
  }

  IconData _getThemeIcon(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return Icons.wb_sunny;
      case ThemeMode.dark:
        return Icons.nights_stay;
      case ThemeMode.system:
      default:
        return Icons.brightness_auto;
    }
  }
}
