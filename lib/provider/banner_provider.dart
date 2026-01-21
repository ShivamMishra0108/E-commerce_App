import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BannerProvider extends StateNotifier<List<Banner>>{
  BannerProvider(): super([]);

  void SetBanner(List<Banner> banners){
    state = banners;
  }
}

final bannerProvider = StateNotifierProvider<BannerProvider, List<Banner>>((ref){
  return BannerProvider();
});


                                             // U N U S E D : 