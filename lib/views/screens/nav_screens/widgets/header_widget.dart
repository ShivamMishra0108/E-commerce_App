import 'package:e_commerce_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HeaderWidget extends ConsumerStatefulWidget {
  const HeaderWidget({super.key});

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends ConsumerState<HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.25,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withOpacity(0.4),
                  Colors.lightBlue.withOpacity(0.6),
                ],
              ),
            ),
          ),

            Positioned(
            left: 12,
            top: 107,
            child: InkWell(
              onTap: () {},
              child: Icon(Icons.menu, color: Colors.black),
            ),
          ),

          Positioned(
            left: 48,
            top: 105,
            child: Container(
              height: 50,
              width: 320,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blue, width: 2),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: const TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.asset(
                        "assets/icons/search.png",
                        height: 20,
                        width: 20,
                      ),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.asset(
                        "assets/icons/cam.png",
                        height: 20,
                        width: 20,
                      ),
                    ),
                    border: InputBorder.none,
                    filled: false,
                  ),
                ),
              ),
            ),
          ),
        
          Positioned(
            left: 376,
            top: 50,
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: () {},
                child: Ink(
                  width: 31,
                  height: 31,
                  child: 
                     Image.asset("assets/icons/bell.png",color: Colors.grey.shade800,),
                    ),
                  ),
                ),
              ),
            
          
          Positioned(
            left: 380,
            top: 114,
            child: Material(
              type: MaterialType.canvas,
              child: InkWell(
                onTap: () {},
                child: Ink(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  width: 35,
                  height: 35,
                 child: Image.asset("assets/icons/message.png",color: Colors.black,),
                    
                  
                ),
              ),
            ),
          ),
          Positioned(child: Material()),

          Positioned(
            top: 35,
            left: 29,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Location",style: TextStyle(fontSize: 10),),
                  ),

                  Row(
                   
                    children: [
                      SizedBox(
                        child: Image.network(
                          height: 18,
                          width: 18,
                          'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2Fnn2Ldqjoc2Xp89Y7Wfzf%2F2ee3a5ce3b02828d0e2806584a6baa88.png',
                        ),
                      ),

                      Text("${user!.locality},${user.city}, ${user.state} ",style: TextStyle(fontSize: 14),)


                      
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
