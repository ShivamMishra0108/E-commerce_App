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

  @override
  void initState() {
    super.initState();
    futureBanners = BannerController().loadBanners();
  }
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 170,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(4)
        ),
      
        child:  FutureBuilder(
        future: futureBanners,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          // }//else if(snapshot.hasError){
          //   return Center(child: Text( "Error: $snapshot.error"));
          }else if(!snapshot.hasData || snapshot.data!.isEmpty){
            return Center(child: Text("No Banners"),);
          }else{
            final banners = snapshot.data!;
            return PageView.builder(
              itemCount: banners.length,
              
              itemBuilder: (context, index) {
                final Banner = banners[index];
                return Column(
                  children: [
                    Image.network(Banner.image,
                    fit: BoxFit.cover,),
                   
                  ],
                );
              },
            );
          }
        },
      )
      ),
    );
  }
}