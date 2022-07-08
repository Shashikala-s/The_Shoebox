import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/Widget/AppScaffoldMessenger.dart';
import 'package:shoe_app/Widget/appbar.dart';
import 'package:shoe_app/model/shoe_model.dart';
import 'package:shoe_app/providers/CartProvider.dart';

class ProductPage extends StatefulWidget {
  final ShoesModel shoesModel;

  const ProductPage({Key? key, required this.shoesModel}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithCart(
        contextActivity: context,
      ),
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              widget.shoesModel.mainImage,
              fit: BoxFit.contain,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return Image.asset(
                  'assets/images/notavailable.png',
                  height: MediaQuery.of(context).size.height * 0.2,
                );
              },
            ),
            Text(
              widget.shoesModel.name,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .apply(fontWeightDelta: 2),
              textAlign: TextAlign.center,
            ),
            SizedBox(height:MediaQuery.of(context).size.height * 0.01 ,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.shoesModel.price.amount +
                    " " +
                    widget.shoesModel.price.currency,style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .apply(fontWeightDelta: 3),),
                Text(
                  widget.shoesModel.stockStatus,
                  style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .apply(fontWeightDelta: 3,color: Theme.of(context).primaryColor),
                ),
              ],
            ),
            SizedBox(height:MediaQuery.of(context).size.height * 0.01 ,),
            Row(
              children: [
                Text(
                  'About',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ],
            ),
            Text(
              widget.shoesModel.description,
              style: Theme.of(context).textTheme.caption,
              textAlign: TextAlign.justify,
            ),

            SizedBox(height:MediaQuery.of(context).size.height * 0.01 ,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    " Colors  "
                    ,style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .apply(fontWeightDelta: 3),),
                Text(
                  widget.shoesModel.colour,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .apply(fontWeightDelta: 3,color: Theme.of(context).primaryColor),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Container(
              height: 100,

              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.shoesModel.sizes.length,
                  itemBuilder: (context, index) {
                    return Center(
                      child: FloatingActionButton(
                        backgroundColor: Theme.of(context).disabledColor,
                        heroTag: null,
                        elevation: 0,
                        onPressed: () {},
                        child: Text(widget.shoesModel.sizes[index]),
                      ),
                    );
                  }),
            ),
            FloatingActionButton.extended(
              elevation: 0,
              heroTag: null,
              onPressed: () {
                AppScaffoldMessenger().successMsg(context, 'Item added');
                Provider.of<CartProvider>(context, listen: false)
                    .setCartItems(widget.shoesModel);
              },
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              label: Text(
                'Add to Cart'.toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .apply(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
