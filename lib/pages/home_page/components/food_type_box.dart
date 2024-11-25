import 'package:flutter/material.dart';
import 'package:food_delivery/models/enums.dart';

import '../../../theme.dart';

class FoodTypeBox extends StatefulWidget {
  final FoodType foodType;
  final bool isSelected;
  final VoidCallback onItemSelected;
  const FoodTypeBox({
    Key? key,
    required this.foodType,
    required this.onItemSelected,
    this.isSelected = false,
  }) : super(key: key);

  @override
  State<FoodTypeBox> createState() => _FoodTypeBoxState();
}

class _FoodTypeBoxState extends State<FoodTypeBox> {
  late final String typeName;

  @override
  void initState() {
    super.initState();
    typeName = getFoodType(widget.foodType);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            widget.onItemSelected();
          },
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Material(
              type: MaterialType.card,
              elevation: 3.0,
              color: widget.isSelected ? AppColor.primaryColor : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //icona immagine,
                  Container(
                    height: constraints.maxHeight * 0.6,
                    width: constraints.maxWidth * 0.6,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage("assets/images/$typeName.png"),
                    )),
                  ),
                  // Text(
                  //   typeName,
                  //   style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  //         color: widget.isSelected
                  //             ? Colors.white
                  //             : AppColor.titleTextColor,
                  //       ),

                  Container(
                    height: constraints.maxHeight * 0.1,
                    width: constraints.maxHeight * 0.1,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.isSelected
                          ? Colors.white
                          : AppColor.primaryColor,
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 16.0,
                      color: widget.isSelected
                          ? AppColor.primaryColor
                          : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
