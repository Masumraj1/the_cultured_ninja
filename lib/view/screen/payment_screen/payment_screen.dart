import 'package:final_movie/utils/app_colors/app_colors.dart';
import 'package:final_movie/view/widgets/custom_button/custom_button.dart';
import 'package:final_movie/view/widgets/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      ///======================Search Appbar===============
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
          color: AppColors.lightWhite,
        ),
        backgroundColor: AppColors.backgroundColor,
        title: const CustomText(
          text: "Make Payment",
          color: AppColors.lightWhite,
          fontSize: 20,
        ),
        centerTitle: true,
      ),

      ///======================Payment Body===============
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: CustomText(
                    text: 'Note:',
                    color: AppColors.yesButtonColor,
                    fontSize: 22,
                  ),
                ),Expanded(
                  flex: 7,
                  child: CustomText(
                    textAlign: TextAlign.start,
                    text: ' When you pay \$5, ads will no longer be shown',
                    color: AppColors.lightWhite,
                    fontSize: 18,
                    maxLines: 3,
                  ),
                ),

              ],
            ),

            const SizedBox(height: 260),
            Center(
              child: CustomButton(
                fillColor: AppColors.buttonColor,
                onTap: () {

              },title: 'Pay Now \$5',),
            )
          ],
        ),
      ),
    );
  }
}
