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
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class DashboardController extends GetxController {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ScrollOffsetController scrollOffsetController =
      ScrollOffsetController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener =
      ScrollOffsetListener.create();

  RxInt currentIndex = 0.obs;

  List<String> tabs = [
    'Home',
    'About',
    'Portfolio',
    'Service',
    'Blog',
    'Contact'
  ];

  RxBool isScrolledMoreThan150 = false.obs;
  void init() {
    itemPositionsListener.itemPositions.addListener(() {
      final positions = itemPositionsListener.itemPositions.value;
      if (positions.isNotEmpty) {
        final min = positions
            .where((position) => position.itemLeadingEdge < 0.5)
            .reduce((min, position) =>
                position.itemLeadingEdge < min.itemLeadingEdge
                    ? position
                    : min);
        if (min.itemLeadingEdge < 0.0 && min.itemTrailingEdge > 0.0) {
          currentIndex.value = min.index;
        }
        //isScrolledMoreThan150.value = positions.first.index > 0;
      }
    });
  }

  void updateScrollOffset(ScrollNotification notification) {
    if (notification.metrics.axis == Axis.vertical) {
      if (notification.metrics.pixels > 150) {
        isScrolledMoreThan150.value = true;
      } else {
        isScrolledMoreThan150.value = false;
      }
    }
  }

  void scrollToIndex(int index) {
    itemScrollController
        .scrollTo(
      index: index,
      duration: const Duration(milliseconds: 500),
    )
        .then((_) {
      Future.delayed(const Duration(milliseconds: 200), () {
        currentIndex.value = index;
      });
    });
  }

  final List<String> categories = ['All', 'Mobile App', 'Website', 'TypeScript', 'Python (Django)', 'JavaScript'];
  ///Service
  var selectedCategory = 'Mobile App'.obs;
  var portfolioItems = <PortfolioItem>[
    // Mobile App
    PortfolioItem(
      name: 'Luxury Shopping App',
      date: 'May 2024',
      imageUrl: 'https://hiteshsapra.com/images/logo_512.png',
      category: 'Mobile App',
    ),
    PortfolioItem(
      name: 'Fitness Tracker App',
      date: 'Feb 2024',
      imageUrl: 'https://hiteshsapra.com/images/logo_512.png',
      category: 'Mobile App',
    ),

    // Website
    PortfolioItem(
      name: 'Corporate Website',
      date: 'Dec 2023',
      imageUrl: 'https://hiteshsapra.com/images/logo_512.png',
      category: 'Website',
    ),
    PortfolioItem(
      name: 'E-commerce Platform',
      date: 'Oct 2023',
      imageUrl: 'https://hiteshsapra.com/images/logo_512.png',
      category: 'Website',
    ),

    // TypeScript
    PortfolioItem(
      name: 'Real-time Chat Application',
      date: 'Jun 2023',
      imageUrl: 'https://hiteshsapra.com/images/logo_512.png',
      category: 'TypeScript',
    ),
    PortfolioItem(
      name: 'Project Management Tool',
      date: 'March 2023',
      imageUrl: 'https://hiteshsapra.com/images/logo_512.png',
      category: 'TypeScript',
    ),

    // Python (Django)
    PortfolioItem(
      name: 'Blog Platform',
      date: 'May 2020',
      imageUrl: 'https://hiteshsapra.com/images/logo_512.png',
      category: 'Python (Django)',
    ),
    PortfolioItem(
      name: 'Inventory Management System',
      date: 'Feb 2020',
      imageUrl: 'https://hiteshsapra.com/images/logo_512.png',
      category: 'Python (Django)',
    ),

    // JavaScript
    PortfolioItem(
      name: 'Interactive Dashboard',
      date: 'April 2019',
      imageUrl: 'https://hiteshsapra.com/images/logo_512.png',
      category: 'JavaScript',
    ),
    PortfolioItem(
      name: 'Single Page Application',
      date: 'Jan 2018',
      imageUrl: 'https://hiteshsapra.com/images/logo_512.png',
      category: 'JavaScript',
    ),
    // Add more items
  ].obs;

  List<PortfolioItem> get filteredItems {
    if (selectedCategory.value == 'All') {
      return portfolioItems;
    } else {
      return portfolioItems
          .where((item) => item.category == selectedCategory.value)
          .toList();
    }
  }

  void changeCategory(String category) {
    selectedCategory.value = category;
  }
}

class PortfolioItem {
  final String imageUrl;
  final String category;
  final String name;
  final String date;

  PortfolioItem({required this.name, required this.date, required this.imageUrl, required this.category});
}
