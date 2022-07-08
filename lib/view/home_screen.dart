import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/Widget/AppScaffoldMessenger.dart';
import 'package:shoe_app/Widget/appbar.dart';
import 'package:shoe_app/model/shoe_model.dart';
import 'package:shoe_app/providers/CartProvider.dart';
import 'package:shoe_app/services/app_services.dart';
import 'package:shoe_app/view/product_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ShoesModel> imageList = [];
  List<ShoesModel> categoryList = [];


  @override
  void initState() {
    _getSlider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBarWithCart(
          contextActivity: context,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Visibility(
                visible: imageList.length > 0 ? true : false,
                child: Container(
                  color: Colors.white,
                  child: CarouselSlider.builder(
                    itemCount: imageList.length,
                    options: CarouselOptions(
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                      autoPlay: true,
                    ),
                    itemBuilder: (ctx, index, realIdx) {
                      return Container(
                        color: Colors.white,
                        child: Row(
                          children: [
                            Container(
                              child: Image.network(
                                imageList[index].mainImage,
                                height: MediaQuery.of(context).size.height * 0.15,
                                width: MediaQuery.of(context).size.width * 0.55,
                                fit: BoxFit.cover,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return Image.asset(
                                    'assets/images/logo.png',
                                    height:
                                        MediaQuery.of(context).size.height * 0.2,
                                  );
                                },
                              ),
                            ),
                            Expanded(
                              child: Text(
                                imageList[index].name,
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding:
                EdgeInsets.all(MediaQuery.of(context).size.height * 0.010),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.050,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categoryList.length,
                      itemBuilder: (context, index) {
                        return Row(

                          children: [
                            FloatingActionButton.extended(
                              onPressed: () {
                                setState(() {

                                });
                              },
                              // label: Text(categories[index].name??'',style: Theme.of(context).textTheme.caption!.apply(color: Provider.of<ShoppingProvider>(context, listen: true).categoryList![index] == Provider.of<ShoppingProvider>(context, listen: true).selectedCategory?Theme.of(context).cardColor:Theme.of(context).primaryColor),),
                             label: Text(categoryList[index].brandName),
                              heroTag: null,
                              elevation: 0,
                              // backgroundColor: Provider.of<ShoppingProvider>(context, listen: true).categoryList![index] == Provider.of<ShoppingProvider>(context, listen: true).selectedCategory
                              //     ? Theme.of(context).primaryColor
                              //     : Theme.of(context).cardColor,
                              backgroundColor: Colors.orange[400],
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.020,
                            )
                          ],
                        );
                      }),
                ),
              ),
              Expanded(
                child: FutureBuilder<List<ShoesModel>?>(
                    future: AppServices().showData(context),
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.connectionState == ConnectionState.done) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.leftToRight,
                                        child: ProductPage(
                                          shoesModel: snapshot.data![index],
                                        )));
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.white70, width: 1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.height *
                                          0.01),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Image.network(
                                          snapshot.data?[index].mainImage ??
                                              '-',
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.15,
                                          fit: BoxFit.contain,
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace? stackTrace) {
                                            return Image.asset(
                                              'assets/images/notavailable.png',
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.2,
                                            );
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot.data![index].name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2,
                                            ),
                                            Text(
                                              snapshot.data![index].brandName,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  snapshot.data![index].price
                                                          .amount +
                                                      " " +
                                                      snapshot.data![index]
                                                          .price.currency,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2!
                                                      .apply(
                                                          fontWeightDelta: 3),
                                                ),
                                                FloatingActionButton(
                                                  backgroundColor: Colors.black,
                                                    mini: true,
                                                    elevation: 0,
                                                    onPressed: () {
                                                      AppScaffoldMessenger()
                                                          .successMsg(context,
                                                              'Item added');
                                                      Provider.of<CartProvider>(
                                                              context,
                                                              listen: false)
                                                          .setCartItems(snapshot
                                                              .data![index]);
                                                    },
                                                    child: Icon(
                                                      Icons.shopping_cart,
                                                      color: Theme.of(context)
                                                          .cardColor,
                                                    )),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              color: Colors.grey,
                            ),
                          ],
                        );
                      }
                    }),
              ),
            ],
          ),
        ));
  }

  void _getSlider() async {
    await AppServices().showData(context).then((value) {
      setState(() {
        imageList = value;
        for(var model in value) {
          if (categoryList.any((e) => model.brandName == e.brandName)) {
// print('already added');
          } else {
            categoryList.add(model);
          }
        }
      });
    });
  }
}
