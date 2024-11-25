import 'package:flutter/material.dart';
import '../../models/enums.dart';
import '../../router.dart';
import '../../theme.dart';
import '../../common_widgets/food_box.dart'; // Assume this exists
import '../../helpers/food_handler.dart';
import 'components/food_type_box.dart'; // Assume this exists

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FoodType _selectedFoodType = FoodType.pizza;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.black ,

        elevation: 0,
        title:
            Center(
              child: Image(width: double.infinity,
                  height: 70,
                  image: AssetImage("assets/images/foodie.jpg")),

            ),

      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Our Menu Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Our Menu",
                  style: Theme.of(context).textTheme.titleLarge,
                ),

              ],
            ),
            const SizedBox(height: 10),

            // Horizontal Category List
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: FoodType.values.length,
                itemBuilder: (context, index) {
                  FoodType type = FoodType.values[index]; // Get each food type
                  return Padding(
                    padding: const EdgeInsets.only(right: 16),
                    // Space between avatars
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () => setState(() => _selectedFoodType = type),
                          // Handle tap
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: _selectedFoodType == type
                                ? AppColor.primaryColor
                                : Colors.black, // Highlight selected
                            child: FoodTypeBox(
                              foodType: type,
                              isSelected: _selectedFoodType == type,
                              onItemSelected: () =>
                                  setState(() => _selectedFoodType = type),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          type.toString().split('.').last, // Display food type name
                          style: TextStyle(
                            fontSize: 12,
                            color: _selectedFoodType == type
                                ? AppColor.primaryColor
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // Featured Items Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Featured Items",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(
                    context,
                    FoodDeliveryRouter.popularPage,
                    arguments: _selectedFoodType,
                  ),
                  child: const Text(
                    "View All",
                    style: TextStyle(
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Vertical Featured Items List
            Expanded(
              child: ListView.builder(
                itemCount: takePopularFoodByType(_selectedFoodType).length,
                itemBuilder: (context, index) {
                  final food = takePopularFoodByType(_selectedFoodType)[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          food.image, // Assuming food has an image URL
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(food.name),
                      subtitle: Text("\$${food.price.toStringAsFixed(2)}",style: TextStyle(color: Colors.green),),
                      trailing: ElevatedButton(
                        onPressed: () => Navigator.of(context).pushNamed(
                              FoodDeliveryRouter.detailPage,
                              arguments: food),


                        child: Text("View"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primaryColor,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
