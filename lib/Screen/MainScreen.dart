// ignore_for_file: non_constant_identifier_names, unused_field

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scrollfoodlist/dishModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  static List<String> dishName = [
    "Pizza",
    "Burger",
    "IceCresm",
    "Donot",
    "Momos",
    "THali",
    "Biryani",
    "Tandoori"
  ];

  static List url = [
    "assets/pizza.png",
    "assets/burger.png",
    "assets/dunot.png",
    "assets/icecream.png",
    "assets/momos.png",
    "assets/thali.png",
    "assets/biryani.png",
    "assets/tandori.png"
  ];

  final List<Dish> DishData = List.generate(
      dishName.length, (index) => Dish(dishName[index], '${url[index]}'));

  final _pageSplashController =
      PageController(initialPage: 0, viewportFraction: 0.35);

  double _currentPage = 0.0;

  void _ScrollListener() {
    setState(() {
      _currentPage = _pageSplashController.page!;
    });
  }

  @override
  void initState() {
    _pageSplashController.addListener(_ScrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _pageSplashController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Positioned(
                top: 8.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 12.h,
                    ),
                    Text(
                      "Explore\nFavourite Dish",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 22.sp,
                          letterSpacing: -0.5),
                    ),
                  ],
                ),
              ),
            ),
            //back_shadow
            Positioned(
              left: 13.w,
              right: 0.w,
              bottom: -size.height * 0.3.h,
              height: size.height * 0.4.h,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.white.withOpacity(0.75),
                        blurRadius: 90.r,
                        offset: Offset.zero,
                        spreadRadius: 35.r)
                  ],
                ),
              ),
            ),
            Transform.scale(
              scale: 1.6,
              alignment: Alignment.bottomCenter,
              child: PageView.builder(
                controller: _pageSplashController,
                scrollDirection: Axis.vertical,
                itemCount: DishData.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return const SizedBox.shrink();
                  }
                  final dish = DishData[index - 1];
                  final result = _currentPage - index + 1;
                  final value = -0.4 * result + 1;
                  final opacity = value.clamp(0.0, 1.0);
                  return Padding(
                    padding: EdgeInsets.only(bottom: 30.h),
                    child: Transform(
                      alignment: Alignment.bottomCenter,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..translate(
                            0.0,
                            MediaQuery.of(context).size.height /
                                2.6 *
                                (1 - value).abs())
                        ..scale(value),
                      child: AnimatedOpacity(
                        opacity: opacity,
                        duration: const Duration(milliseconds: 100),
                        child: Stack(
                          children: [
                            Center(
                              child: SizedBox(
                                height: 200.h,
                                width: 200.w,
                                child: Image.asset(
                                  dish.ImageUrl,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 13.w,
                              right: 0.w,
                              bottom: -size.height * 0.3.h,
                              height: size.height * 0.4.h,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.white.withOpacity(0.7),
                                        blurRadius: 90.r,
                                        offset: Offset.zero,
                                        spreadRadius: 35.r)
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: -50.h,
                              height: 100.h,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
