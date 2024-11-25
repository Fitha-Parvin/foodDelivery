import 'package:flutter/material.dart';
import 'package:food_delivery/helpers/cart_handler.dart';
import 'package:food_delivery/models/ingredient.dart';
import 'package:food_delivery/pages/payment/addressNpayement.dart';
import 'package:food_delivery/theme.dart';
import 'package:provider/provider.dart';
import '../../justmain2.dart';
import '../../models/food.dart';
import 'component/quantity_handler.dart';

class FoodDetailPage extends StatefulWidget {
  final Food food;
  const FoodDetailPage({
    Key? key,
    required this.food,
  }) : super(key: key);

  @override
  State<FoodDetailPage> createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  int quantity = 0; // Default to 0 initially
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.food.isFavourite;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(isFavorite != widget.food.isFavourite);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          child: _buildBody(context),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: _buildFab(context),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) => AppBar(
    backgroundColor: AppColor.primaryColor,
    elevation: 0,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
      onPressed: () => Navigator.of(context).pop(isFavorite != widget.food.isFavourite),
    ),
    centerTitle: true,
    title: Text(
      widget.food.name,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  Widget _buildBody(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailsImage(),
        const SizedBox(height: 16),
        QuantityHandler(
          onBtnTapped: (val) => setState(() {
            quantity = val;
          }),
        ),
        const SizedBox(height: 24),
        Text(
          "Ingredients",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: widget.food.ingredients.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) => _buildIngredient(context, widget.food.ingredients[index]),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          "Details",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.food.description,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.grey[700],
            fontSize: 16.0,
          ),
        ),
      ],
    ),
  );

  Widget _buildDetailsImage() => Stack(
    children: [
      ClipRect(
        child: Container(
          height: 270,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: AssetImage(widget.food.image),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
      Positioned(
        top: 16,
        right: 16,
        child: InkWell(
          onTap: () {
            setState(() {
              isFavorite = !isFavorite;
              widget.food.isFavourite = isFavorite;
            });
          },
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: AppColor.primaryColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.white,
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 16,
        left: 16,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColor.primaryColor.withOpacity(0.7),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            "\$ ${widget.food.price.toStringAsFixed(2)}",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    ],
  );

  Widget _buildIngredient(BuildContext context, Ingredient ingredient) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.35,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(width: 1.0, color: Colors.grey.shade300),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "assets/icons/ingredients/${ingredient.name}.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                ingredient.name,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFab(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: AppColor.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
            ),
            onPressed: () {
              if (quantity > 0) {
                final totalAmount = widget.food.price * quantity;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentScreen(
                      foodImages: [widget.food.image], // Pass the list of images
                      amount: totalAmount,          // Pass the total amount
                      foodNames: [widget.food.name], // Pass the food name
                      quantities: [quantity],
                      // Pass the quantity
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  _buildSnackBar(context, haveError: true),
                );
              }
            },
            child: const Text("Buy Now"),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: AppColor.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
            ),
            onPressed: () {
              if (quantity > 0) {
                context.read<CartProvider>().addItem(widget.food, quantity);
                ScaffoldMessenger.of(context).showSnackBar(
                  _buildSnackBar(context),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  _buildSnackBar(context, haveError: true),
                );
              }
            },
            child: const Text("Add to Cart"),
          ),
        ),
      ],
    ),
  );

  SnackBar _buildSnackBar(BuildContext context, {bool haveError = false}) =>
      SnackBar(
        backgroundColor: haveError ? Colors.red : AppColor.primaryColor,
        duration: const Duration(milliseconds: 1500),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              haveError
                  ? "Error: Please Choose Quantity"
                  : "${quantity}x ${widget.food.name} Added To Cart!",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (!haveError)
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    "cart",
                        (route) => false,
                  );
                },
                child: const Text("Open Cart"),
              ),
          ],
        ),
      );
}
