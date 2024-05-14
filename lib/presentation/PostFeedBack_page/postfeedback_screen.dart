import 'package:oriksha_application/core/app_export.dart';
import 'package:oriksha_application/presentation/PostFeedBack_page/controller/postfeedback_controller.dart';
import 'package:oriksha_application/widget/custom_feedback_card.dart';
import 'package:oriksha_application/widget/custom_ratingcard.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class PostFeedBackScreen extends GetWidget<PostFeedBackController> {
  const PostFeedBackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryOrg,
        automaticallyImplyLeading: false,
        flexibleSpace: CustomAppBar(
          onPressed: (){
            Get.back();
          },
          text: AppString.feedBack.tr,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: w(context, 15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(h(context, 20)),
              CustomRatingCard(name: '', image: '',),
              Gap(h(context, 15)),
              CustomFeedBackCard(
                  locationDropSubTitle: "locationDropSubTitle",
                  dropTime: "12:50",
                  locationPickSubTitle: "locationPickSubTitle",
                  pickTime: "11:30"),
              Gap(h(context, 25)),
              Text(
               AppString.postYourReview.tr,
                style: AppStyle.style(f(context, 20),
                    fontWeight: FontWeight.bold,
                    fontColor: ColorConstant.primaryBlack),
              ),
              Gap(h(context, 10)),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: AppString.enterYourFeedBack.tr,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: h(context, 10), horizontal:w(context, 16)),
                  ),
                ),
              ),
              Gap(h(context, 10)),
              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                unratedColor: Colors.grey,
                itemCount: 5,
                itemSize: f(context, 40),
                itemPadding: EdgeInsets.symmetric(horizontal: w(context, 3)),
                updateOnDrag: true,
                itemBuilder: (context, index) {
                  return const Icon(
                    Icons.star,
                    color: ColorConstant.primaryOrg,
                  );
                },
                onRatingUpdate: (ratingvalue) {
                  controller.fullRating.value = ratingvalue;
                },
              ),
              Gap(h(context, 10)),
              CustomElevatedButton(onPressed: (){}, buttonName: AppString.submit.tr)
            ],
          ),
        ),
      ),
    );
  }
}
