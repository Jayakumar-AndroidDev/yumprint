import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:yumprint/presentation_layer/component/text_component.dart';

class NetworkFailScreen extends StatelessWidget {
  const NetworkFailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset('image/network_fail.json',width:150,height:150),
            const SizedBox(
              height: 5,
            ),
            const TextComponent(
              text: 'Please Check Your Network',
              textSize: 20,
              textColor: Colors.orange,
              textAlign: Alignment.center,
              fontWeight: FontWeight.bold,
            )
          ],
        ),
      ),
    );
  }
}
