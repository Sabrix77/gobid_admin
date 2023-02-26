import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gobid_admin/model/product.dart';

class ProductCard extends StatelessWidget {
  Product product;
  String sellerName;
  Function() onPressed;

  // Function()? onPressed;
  //  ProductCard({required this.product, this.onPressed});

  ProductCard(
      {required this.product,
      required this.sellerName,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () => Navigator.of(context, rootNavigator: true)
      //     .pushNamed(ProductDetails.routeName, arguments: product.id),
      child: SizedBox(
        width: double.infinity,
        height: 220,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 200,
                  child: Card(
                    elevation: 6,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children: [
                          const SizedBox(width: 135),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Text(
                                  product.title,
                                  //overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  product.description,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(color: Colors.grey),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Biggest Price : ${product.biggestBid.toString()} LE',
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(color: Colors.grey),
                                ),
                                product.biggestBid == product.price
                                    ? const Text('No one raise the bid!',
                                        style: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 12))
                                    : const SizedBox(),
                                const SizedBox(height: 4),
                                Text(
                                  'Seller: $sellerName',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                        onPressed: onPressed,
                                        child: Text('End Auction')),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              bottom: 20,
              left: 15,
              child: SizedBox(
                width: 120,
                // color: Colors.red,
                height: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: FadeInImage(
                    placeholder:
                        const AssetImage('assets/images/Loading_icon.gif'),
                    image: NetworkImage(product.imgUrl),
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
