import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/Widget/appbar.dart';
import 'package:shoe_app/model/shoe_model.dart';
import 'package:shoe_app/providers/CartProvider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<ShoesModel> shoeList = [];
  final totalPrice =
      MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');

  @override
  void initState() {
    shoeList = Provider.of<CartProvider>(context, listen: false).cartList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithCart(
        contextActivity: context,
      ),
      body: SafeArea(
        child: Container(
          child: Provider.of<CartProvider>(context, listen: true)
                      .cartList
                      .length>0
              ? ListView.builder(
                  itemCount: Provider.of<CartProvider>(context, listen: false)
                      .cartList
                      .length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.height * 0.01),
                        child: Row(
                          children: [
                            Expanded(
                              child: shoeList.length > 0
                                  ? Image.network(
                                      shoeList[index].mainImage,
                                      height:
                                          MediaQuery.of(context).size.height *
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
                                    )
                                  : Text(''),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    shoeList.length > 0
                                        ? shoeList[index].name
                                        : "-",
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                  Text(
                                    shoeList.length > 0
                                        ? shoeList[index].brandName
                                        : '-',
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Qty ' +
                                            Provider.of<CartProvider>(context,
                                                    listen: true)
                                                .cartList[index]
                                                .qty
                                                .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      ),
                                      FloatingActionButton(
                                        heroTag: null,
                                        mini: true,
                                        elevation: 0,
                                        backgroundColor: Colors.transparent,
                                        child: Icon(
                                          Icons.remove_circle_outline,
                                          color: Colors.grey[400],
                                          size: 30,
                                        ),
                                        onPressed: () {

                                          Provider.of<CartProvider>(context,
                                                  listen: false)
                                              .reduceCartItems(shoeList[index]);
                                        },
                                      ),
                                      Container(
                                        child: Text(''),
                                      ),
                                      FloatingActionButton(
                                        heroTag: null,
                                        mini: true,
                                        elevation: 0,
                                        backgroundColor: Colors.transparent,
                                        child: Icon(
                                          Icons.add_circle_outline,
                                          color: Colors.orange[200],
                                          size: 30,
                                        ),
                                        onPressed: () {
                                          Provider.of<CartProvider>(context,
                                                  listen: false)
                                              .setCartItems(shoeList[index]);
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Unit Price  ' +
                                                shoeList[index].price.amount +
                                                " " +
                                                shoeList[index].price.currency,
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption,
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.005,
                                          ),
                                          Text(
                                              'Total Price ' +
                                                  double.parse(shoeList[index]
                                                          .price
                                                          .total
                                                          .toString())
                                                      .toStringAsFixed(2)
                                                      .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .apply(fontWeightDelta: 3))
                                        ],
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            Provider.of<CartProvider>(context,
                                                    listen: false)
                                                .removeCartItem(index);
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ))
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  })
              : Container(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'shopping cart empty',
                    style: Theme.of(context).textTheme.subtitle2,
                  )),
        ),
      ),
    );
  }
}
