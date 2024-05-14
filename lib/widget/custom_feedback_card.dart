import 'package:oriksha_application/core/app_export.dart';


class CustomFeedBackCard extends StatelessWidget {
  String pickTime;
  String locationPickSubTitle;
  String dropTime;
  String locationDropSubTitle;

  CustomFeedBackCard({
    super.key,
    required this.locationDropSubTitle,
    required this.dropTime,
    required this.locationPickSubTitle,
    required this.pickTime,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
            child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: w(context, 8), vertical: h(context, 8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "mihir pansuriya ori rampur",
              maxLines: 2,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: AppStyle.style(f(context, 14),
                  fontColor: ColorConstant.primaryBlack,
                  fontWeight: FontWeight.w800),
            ),
            Row(
              children: [
                Column(
                  children: [
                    Container(
                      height: h(context, 10),
                      width: w(context, 10),
                      decoration: const BoxDecoration(
                        color: ColorConstant.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      height: h(context, 40),
                      width: w(context, 2),
                      decoration: const BoxDecoration(
                        color: ColorConstant.primaryOrg,
                      ),
                    ),
                    Container(
                      height: h(context, 10),
                      width: w(context, 10),
                      decoration: const BoxDecoration(
                        color: ColorConstant.orange38,
                        shape: BoxShape.circle,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: w(context, 15)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pickTime,
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyle.style(f(context, 16),
                            fontColor: ColorConstant.primaryBlack,
                            fontWeight: FontWeight.w800),
                      ),
                      Text(
                        locationPickSubTitle,
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyle.style(f(context, 14),
                            fontColor: ColorConstant.primaryBlack,
                            fontWeight: FontWeight.w400),
                      ),
                      Gap(
                        h(context, 15),
                      ),
                      Text(
                        dropTime,
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyle.style(f(context, 16),
                            fontColor: ColorConstant.primaryBlack,
                            fontWeight: FontWeight.w800),
                      ),
                      Text(
                        locationDropSubTitle,
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyle.style(f(context, 14),
                            fontColor: ColorConstant.primaryBlack,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Gap(h(context, 15)),
          ],
        ),
      ),
    );
  }
}
