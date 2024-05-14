import 'package:oriksha_application/core/app_export.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CustomRatingCard extends StatelessWidget {
  final String name;
  final String image;
  const CustomRatingCard({super.key, required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    double fullRating = 0.0;
    return Container(
      decoration: BoxDecoration(
          color: ColorConstant.primaryWhite,
          borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              maxRadius: 25,
              backgroundImage: CachedNetworkImageProvider(image.toString(),errorListener: (p0) {
                const CircularProgressIndicator();
              },),
            ),
            Gap(w(context, 10)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name.toString(),
                  style: AppStyle.style(f(context, 14),
                      fontWeight: FontWeight.w800,
                      fontColor: ColorConstant.primaryBlack),
                ),
                RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  unratedColor: Colors.grey,
                  glowColor: ColorConstant.primaryOrg,
                  itemCount: 5,
                  itemSize: f(context, 30),
                  itemPadding: EdgeInsets.symmetric(horizontal: w(context, 3)),
                  updateOnDrag: true,
                  itemBuilder: (context, index) {
                    return const Icon(
                      Icons.star,
                      color: ColorConstant.primaryOrg,
                    );
                  },
                  onRatingUpdate: (ratingvalue) {
                    fullRating = ratingvalue;
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
