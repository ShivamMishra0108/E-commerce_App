import 'dart:async';
import 'package:e_commerce_app/controllers/banner_controller.dart';
import 'package:e_commerce_app/models/banner_model.dart';
import 'package:e_commerce_app/views/screens/nav_screens/widgets/reuseable_textWidget.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  late Future<List<BannerModel>> futureBanners;
  List<BannerModel> banners = [];
  final PageController _pageController = PageController(viewportFraction: 1);
  Timer? _timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    futureBanners = BannerController().loadBanners();
    futureBanners.then((loadedBanners) {
      setState(() {
        banners = loadedBanners;
      });
      _startAutoScroll();
    });
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (banners.isEmpty) return;

      if (_currentIndex < banners.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }

      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: TextWidget(title: "Special for you", subtitle: "See all"),
        ),

        const SizedBox(height: 3), 

        Container(
          height: 200,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: banners.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        controller: PageController(viewportFraction: 0.92),
                        itemCount: banners.length,
                        onPageChanged: (index) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          final banner = banners[index];

                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                banner.image,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 12),

                
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        banners.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _currentIndex == index ? 14 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _currentIndex == index
                                ? Colors.blue
                                : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}


// import 'package:e_commerce_app/controllers/banner_controller.dart';
// import 'package:e_commerce_app/models/banner_model.dart';
// import 'package:e_commerce_app/views/screens/nav_screens/widgets/reuseable_textWidget.dart';
// import 'package:flutter/material.dart';

// class BannerWidget extends StatefulWidget {
//   const BannerWidget({super.key});

//   @override
//   State<BannerWidget> createState() => _BannerWidgetState();
// }

// class _BannerWidgetState extends State<BannerWidget> {
//   late Future<List<BannerModel>> futureBanners;
//   List<BannerModel> banners = [];
//   final PageController _pageController = PageController();

//   @override
//   void initState() {
//     super.initState();
//     futureBanners = BannerController().loadBanners();
//     futureBanners.then((loadedBanners) {
//       setState(() {
//         banners = loadedBanners;
//       });
//     });
//   }

//   void _loadNewBanner() async {
//     // Here, call your controller to get a new banner
//     BannerModel? newBanner = await BannerController().loadNewBanner();
//     if (newBanner != null) {
//       setState(() {
//         banners.add(newBanner); // add the new banner to the list
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TextWidget(title: "Special for you ", subtitle: "see all"),
//         Padding(
//           padding: const EdgeInsets.all(5.0),
//           child: Container(
//             height: 160,
//             width: 360,
//             decoration: BoxDecoration(
//               border: Border.all(
//                 color:  Colors.white
//               ),
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: banners.isEmpty
//                 ? const Center(child: CircularProgressIndicator())
//                 : PageView.builder(
//                     controller: _pageController,
//                     itemCount: banners.length,
//                     onPageChanged: (index) {
//                       // If user reaches the last banner, load a new one
//                       if (index == banners.length - 1) {
//                         _loadNewBanner();
//                       }
//                     },
//                     itemBuilder: (context, index) {
//                       final banner = banners[index];
//                       return ClipRRect(
//                         borderRadius: BorderRadius.circular(4),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Image.network(
//                             banner.image,
//                             fit: BoxFit.fitHeight,
//                             width: double.infinity,
                            
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//           ),
//         ),
//       ],
//     );
//   }
// }
