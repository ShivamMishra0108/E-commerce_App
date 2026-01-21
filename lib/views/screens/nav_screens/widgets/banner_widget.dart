import 'package:e_commerce_app/controllers/banner_controller.dart';
import 'package:e_commerce_app/models/banner_model.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  late Future<List<BannerModel>> futureBanners;
  List<BannerModel> banners = [];
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    futureBanners = BannerController().loadBanners();
    futureBanners.then((loadedBanners) {
      setState(() {
        banners = loadedBanners;
      });
    });
  }

  void _loadNewBanner() async {
    // Here, call your controller to get a new banner
    BannerModel? newBanner = await BannerController().loadNewBanner();
    if (newBanner != null) {
      setState(() {
        banners.add(newBanner); // add the new banner to the list
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 170,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(
            color:  Colors.white
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(9),
        ),
        child: banners.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : PageView.builder(
                controller: _pageController,
                itemCount: banners.length,
                onPageChanged: (index) {
                  // If user reaches the last banner, load a new one
                  if (index == banners.length - 1) {
                    _loadNewBanner();
                  }
                },
                itemBuilder: (context, index) {
                  final banner = banners[index];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
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
    );
  }
}
