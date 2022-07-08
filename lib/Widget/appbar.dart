import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/Widget/AppScaffoldMessenger.dart';
import 'package:shoe_app/providers/CartProvider.dart';
import 'package:shoe_app/view/cart_screen.dart';

class AppBarWithCart extends StatefulWidget implements PreferredSizeWidget {
  const AppBarWithCart({
    Key? key,

    required this.contextActivity,
  }) : super(key: key);


  final BuildContext contextActivity;

  @override
  _AppBarWithCartState createState() => _AppBarWithCartState();

  @override
  Size get preferredSize =>
      Size.fromHeight(MediaQuery.of(contextActivity).size.height * 0.07);
}

class _AppBarWithCartState extends State<AppBarWithCart> {
  Color? CartColor;

  @override
  void initState() {
    CartColor = Colors.orange;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.grey[700]),
      backgroundColor: Colors.white,
      title: Row(
        children: [
          Image.asset(
            'assets/images/logo.png',
            height: MediaQuery.of(context).size.height * 0.1,
          ),
        ],
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GestureDetector(
            onTap: () {
              if (Provider.of<CartProvider>(context, listen: false)
                  .cartList
                  .isNotEmpty) {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.leftToRight,
                        child: CartScreen()));
              } else {
                AppScaffoldMessenger().errorMsg(context, 'Shopping cart empty');

              }
            },
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    top: 12.0,
                    left: 20.0,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      if (Provider.of<CartProvider>(context, listen: false)
                          .cartList
                          .isNotEmpty) {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.leftToRight,
                                child: CartScreen()));
                      } else {}
                    },
                    child: const Icon(Icons.shopping_cart,
                        size: 30.0, color: Colors.black),
                  ),
                ),
                Positioned(
                  bottom: 8.0,
                  right: 16.0,
                  child: Container(
                    height: 20.0,
                    width: 20.0,
                    decoration: BoxDecoration(
                        color: Provider.of<CartProvider>(context, listen: true)
                                .cartList
                                .isNotEmpty
                            ? Colors.orange
                            : Colors.black,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Center(
                      child: Text(
                        Provider.of<CartProvider>(context, listen: true)
                            .cartList
                            .length
                            .toString()
                            .toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
