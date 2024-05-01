import 'package:flutter/material.dart';
import 'package:yumprint/presentation_layer/component/text_component.dart';

class ContainerComponent extends StatelessWidget {
  const ContainerComponent(
      {super.key,
      required this.width,
      required this.height,
      required this.mealImageUrl,
      required this.mealTitle,
      required this.mealId,
      this.isFromSearchCategory = false});

  final double width;
  final double height;
  final String mealTitle;
  final String mealImageUrl;
  final String mealId;
  final bool isFromSearchCategory;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isFromSearchCategory) {
          Navigator.pushNamed(context, 'category_meal_list', arguments: mealTitle);
        }
        if (isFromSearchCategory == false) {
          Navigator.pushNamed(context, 'meal_detail_screen', arguments: mealId);
        }
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FadeInImage.assetNetwork(
              placeholder: 'image/image_place_holder.png',
              image: mealImageUrl,
              width: width,
              height: height,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: width,
            height: height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Color.fromARGB(255, 0, 0, 0),
                ],
                begin: Alignment.center,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          SizedBox(
            width: width,
            height: height,
            child: TextComponent(
              text: mealTitle,
              textSize: 18,
              textColor: Colors.white,
              textAlign: Alignment.bottomCenter,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
