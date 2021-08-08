import 'package:flutter/material.dart';
import 'package:physiotherapy/authentication/auth_client.dart';
import 'package:physiotherapy/screens/store/constants.dart';
import 'package:physiotherapy/screens/store/models/Product.dart';
import 'package:physiotherapy/utils/database.dart';
import 'package:physiotherapy/utils/routes/routeConstants.dart';

import 'categorries.dart';
import 'item_card.dart';

class Body extends StatelessWidget {
  String uid = AuthenticationClient.presentUser.uid;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
          child: Text(
            "Store",
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Categories(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child: GridView.builder(
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: kDefaultPaddin,
                  crossAxisSpacing: kDefaultPaddin,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) => ItemCard(
                      product: products[index],
                      press: () => {
                        Navigator.pushNamed(
                            context, RouteConstants.PRODUCTDESCRIPTION,
                            arguments: products[index])
                      },
                      // press: () => Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => DetailsScreen(
                      //         product: products[index],
                      //       ),
                      //     )),
                    )),
          ),
        ),
      ],
    );
  }
}
