import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_commerce_app_with_firebase_riverpod/application/app/product/product_provider.dart';
import 'package:e_commerce_app_with_firebase_riverpod/style/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Home extends HookConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () {
        ref.read(productProvider.notifier).getProducts();
      });
      return null;
    }, []);

    final state = ref.watch(productProvider);

    List<String> carouselImages = [];
    var dotPosition = useState(0);
    List products = [];
    var firestoreInstance = FirebaseFirestore.instance;

    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                fillColor: Colors.white,
                focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                    borderSide: BorderSide(color: Colors.blue)),
                enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                    borderSide: BorderSide(color: Colors.grey)),
                hintText: "Search products here",
                hintStyle: TextStyle(fontSize: 15.sp),
              ),
              onTap: () {},
              // onTap: () => Navigator.push(context,
              //     CupertinoPageRoute(builder: (_) => SearchScreen())),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          AspectRatio(
            aspectRatio: 3.5,
            child: CarouselSlider(
                items: carouselImages
                    .map((item) => Padding(
                          padding: const EdgeInsets.only(left: 3, right: 3),
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(item),
                                    fit: BoxFit.fitWidth)),
                          ),
                        ))
                    .toList(),
                options: CarouselOptions(
                    autoPlay: false,
                    enlargeCenterPage: true,
                    viewportFraction: 0.8,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    onPageChanged: (val, carouselPageChangedReason) {
                      dotPosition.value = val;
                      // setState(() {
                      //   dotPosition = val;
                      // });
                    })),
          ),
          SizedBox(
            height: 10.h,
          ),
          DotsIndicator(
            dotsCount: carouselImages.length == 0 ? 1 : carouselImages.length,
            position: dotPosition.value.toDouble(),
            //position: dotPosition.toDouble(),
            decorator: DotsDecorator(
              activeColor: AppColors.deep_orange,
              color: AppColors.deep_orange.withOpacity(0.5),
              spacing: EdgeInsets.all(2),
              activeSize: Size(8, 8),
              size: Size(6, 6),
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Expanded(
            child: GridView.builder(
                scrollDirection: Axis.horizontal,
                //itemCount: products.length,
                itemCount: state.products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 1),
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () {},
                    // onTap: () => Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (_) =>
                    //             ProductDetails(products[index]))),
                    child: Card(
                      elevation: 3,
                      child: Column(
                        children: [
                          // AspectRatio(
                          //     aspectRatio: 2,
                          //     child: Container(
                          //         color: Colors.yellow,
                          //         child: Image.network(
                          //           state.products[index].productImg.toString(),
                          //         ))),
                          // Text("${products[index]["product-name"]}"),
                          Text(state.products[index].productName),
                          // Container(
                          //   height: 190,
                          //   width: 200,
                          //   decoration: BoxDecoration(
                          //       image: DecorationImage(
                          //           image: NetworkImage(
                          //               '${state.products[index].productImg}'))),
                          // ),
                          Text(state.products[index].productPrice),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      )),
    );
  }
}
