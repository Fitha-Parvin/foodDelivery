import 'package:flutter/material.dart';

import '../models/food.dart';
import '../theme.dart';

//widget usato da home_page (elementi della list view in basso)
//e da favorite page (elementi della grid view)
class FoodBox extends StatelessWidget {
  final Food food;
  final VoidCallback onNavigate;
  const FoodBox({
    Key? key,
    required this.food,
    required this.onNavigate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.2,
          child: InkWell(
            onTap: () => onNavigate(),
            child: Material(
              type: MaterialType.card,
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: LayoutBuilder(
                builder: (context, cons) => Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //food image
                    Container(
                      width: cons.maxWidth * 1,
                      height: cons.maxHeight * 0.3,
                      decoration: BoxDecoration(color: Colors.green,
                        image: DecorationImage(
                          image: AssetImage(food.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    //image name
                    FittedBox(
                      child: Text(
                        food.name,
style: TextStyle(fontWeight:FontWeight.bold,fontSize: 15),

                      ),
                    ),
                    //mini description
                    FittedBox(
                      child: Text(food.miniDescription,
                          style: Theme.of(context).textTheme.bodySmall),
                    ),
                    //prezzo
                    Text(
                      "\$ ${food.price.toStringAsFixed(2)}",
                      style: const TextStyle(
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
