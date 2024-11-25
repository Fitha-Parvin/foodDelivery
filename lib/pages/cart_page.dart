import 'package:flutter/material.dart';
import 'package:food_delivery/helpers/cart_handler.dart';
import 'package:food_delivery/models/food.dart';
import 'package:provider/provider.dart';
import '../justmain2.dart';
import 'payment/addressNpayement.dart';  // Ensure this import is correct
import '../theme.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProv, _) {
        if (cartProv.foods.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 8,
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/empty.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const Expanded(child: Text("Cart is Empty")),
              const Spacer()
            ],
          );
        }

        // Aggregate details
        final List<String> foodImages = cartProv.foods.map((food) => food.image).toList();
        final List<String> foodNames = cartProv.foods.map((food) => food.name).toList();
        final List<int> quantities = cartProv.foods.map((food) {
          return cartProv.quantity[food.name] ?? 0;
        }).toList();
        final double totalAmount = cartProv.amount;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: ListView(
                children: cartProv.foods
                    .map((food) => _buildFoodBox(context, food, cartProv))
                    .toList(),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: 250),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: textboxColor,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentScreen(
                          foodImages: foodImages, // Pass the list of images
                          amount: totalAmount,
                          foodNames: foodNames, // Pass the list of food names
                          quantities: quantities,
                         // Pass the list of quantities
                        ),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Amount: \$ ${totalAmount.toStringAsFixed(2)}"),
                      const Spacer(),
                      const Text("Buy Now"),
                      const Icon(Icons.shopify),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFoodBox(BuildContext context, Food food, CartProvider cart) {
    final int foodQuantity = cart.quantity[food.name] ?? 0;
    final double foodAmount = food.price * foodQuantity;
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: ListTile(
        leading: Image.asset(food.image),
        title: Text(
          food.name,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "\$ ${foodAmount.toStringAsFixed(2)}",
              style: const TextStyle(
                color: AppColor.transparentColor,
                fontSize: 22.0,
              ),
            ),
            Text(
              "${foodQuantity}x",
              style: const TextStyle(
                color: AppColor.transparentColor,
                fontSize: 22.0,
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.delete,
            color: AppColor.primaryColor,
          ),
          onPressed: () {
            cart.removeItem(food);
          },
        ),
      ),
    );
  }
}
