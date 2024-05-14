import 'package:oriksha_application/core/app_export.dart';


class CustomCard extends StatelessWidget {
  String rupeesText;
  String secondText;
  String locationPickTitleo;
  String locationPickSubTitle;
  String locationDropTitle;
  String locationDropSubTitle;
  String status;

  void Function() acceptOnTap;
  void Function() rejectOnTap;

  CustomCard(
      {super.key,
      required this.status,
      required this.locationDropSubTitle,
      required this.locationDropTitle,
      required this.locationPickSubTitle,
      required this.locationPickTitleo,
      required this.rupeesText,
      required this.secondText,
      required this.acceptOnTap,
      required this.rejectOnTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: ColorConstant.primaryWhite),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: w(context, 8),vertical: h(context, 8)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:  EdgeInsets.symmetric(vertical:status=='waiting'?0:h(context, 8)),
                  child: Text(
                    "\u{20B9}$rupeesText",
                    style: AppStyle.style(f(context, 18),
                        fontColor: ColorConstant.primaryBlack,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              status=='book' ? Container(
                  height: h(context, 52),
                  width: w(context, 52),
                  decoration: BoxDecoration(
                      color: ColorConstant.primaryWhite,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Colors.orange, width: w(context, 4))),
                  child: Center(
                    child: Text(
                      secondText,
                      style: AppStyle.style(f(context, 17),
                          fontColor: ColorConstant.primaryBlack,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ):SizedBox(),
              ],
            ),
            const Divider(),
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
                SizedBox(
                  width: w(context, 300),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: w(context, 15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          locationPickTitleo,
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
                          locationDropTitle,
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
                ),
              ],
            ),
           Gap(h(context, 15)),
         status=='waiting'?Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: CustomTextButton(
                      buttonName: 'Accept', onPressed: acceptOnTap),
                ),
                Gap(w(context, 10)),
                Flexible(
                  child: CustomTextButton(
                      buttonName: 'Reject', onPressed: rejectOnTap),
                ),
              ],
            ):SizedBox(),
          ],
        ),
      ),
    );
  }
}
