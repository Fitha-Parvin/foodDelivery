import 'package:flutter/material.dart';
import 'package:food_delivery/models/enums.dart';
import 'package:food_delivery/router.dart';

import '../../common_widgets/food_box.dart';
import '../../helpers/food_handler.dart';
import '../../models/food.dart';
import '../../theme.dart';
import '../food_detail_page/component/rounded_container.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  late final List<FoodType> _foodTypes = FoodType.values;
  late FoodType currentFoodType;
  //initialized as pizzas
  late List<Food> currentFoods;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _foodTypes.length, vsync: this);
    currentFoodType = FoodType.pizza;
    currentFoods = takeFoodByType(currentFoodType);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _buildAppBar(context),
        body: _buildBody(context),
      );

  PreferredSizeWidget _buildAppBar(BuildContext context) => AppBar(
    backgroundColor: AppColor.primaryColor,
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const RoundedContainer(

            child: Icon(
              Icons.arrow_back_ios,
                color: Colors.white
            ),
          ),
        ),
        title: const Text(
          "Menu",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColor.primaryColor,
          indicatorColor: AppColor.primaryColor,
          tabs: _foodTypes
              .map(
                (foodType) => _buildTab(context, foodType),
              )
              .toList(),
        ),
      );

  Tab _buildTab(BuildContext context, FoodType foodType) {
    final String typeName = getFoodType(foodType);
    return Tab(
      child: Container(width: 400,height: 230,
        decoration: BoxDecoration(color: Colors.green,
          image: DecorationImage(
            image: AssetImage("assets/images/$typeName.png"),
          ),
        ),
      ),
    );
  }


  _buildBody(BuildContext context) => SafeArea(
        child: TabBarView(
            controller: _tabController,
            children: _foodTypes
                .map((type) => _buildCurrentMenu(context, type))
                .toList()),
      );

  Widget _buildCurrentMenu(BuildContext context, FoodType type) {
    currentFoods = takeFoodByType(type);
    return GridView(
      padding: const EdgeInsets.all(5.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
        mainAxisExtent: 250
      ),
      children: currentFoods
          .map((food) => FoodBox(
                food: food,
                onNavigate: () => Navigator.of(context)
                    .pushNamed(FoodDeliveryRouter.detailPage, arguments: food),
              ))
          .toList(),
    );
  }
}
