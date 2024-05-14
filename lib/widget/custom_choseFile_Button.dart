import 'package:oriksha_application/core/app_export.dart';


class CustomChooseFile extends StatelessWidget {
  final String labelText;
  final Function()?  onTap;
  final Widget? icon;
  final String? richText;
  final String? name;
  const CustomChooseFile({super.key,  this.labelText='', this.onTap, this.icon, this.name, this.richText});

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelText.isNotEmpty
            ? Padding(
          padding: EdgeInsets.symmetric(
              vertical: h(context, 2), horizontal: w(context, 14)),
          child: RichText(
              textScaleFactor: 1,
              text: TextSpan(
                text: '$labelText ',
                style: AppStyle.style(f(context, 14),
                    fontColor: ColorConstant.primaryBlack,
                    fontWeight: FontWeight.w400),
                children: <TextSpan>[
                  TextSpan(
                    text: richText ?? '',
                    style: AppStyle.style(
                      f(context, 18),
                      fontColor: Colors.red,
                    ),
                  ),
                ],
              )),
        )
            : const SizedBox(),
        Row(
          children: [
            Expanded(
              child: Container(
                height: h(context, 42),
                width: double.maxFinite,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    bottomLeft: Radius.circular(24.0),
                  ),
                ),

                child:  name==null? Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding:  EdgeInsets.only(left: w(context, 20)),
                    child: Text(
                      AppString.chooseFile.tr,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: true,
                      style: AppStyle.style(f(context, 14),
                          fontFamily: "Inter",
                          fontColor: ColorConstant.primaryBlack),
                    ),
                  ),
                ):Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Gap(w(context, 15)),
                   icon??const SizedBox(),
                    Gap(w(context, 8)),
                    Flexible(
                      child: Text(name??AppString.chooseFile.tr,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: AppStyle.style(f(context, 14),
                          fontFamily: "Inter",
                          fontColor: ColorConstant.primaryBlack),),
                    )
                  ],
                )
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: onTap??(){},
                child: Container(
                  height: h(context, 42),
                  decoration: BoxDecoration(
                    color: ColorConstant.colorGrey,
                    border: Border.all(color:ColorConstant.borderColorGrey,width: 1 ),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(24.0),
                      bottomRight: Radius.circular(24.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      AppString.browseFile.tr,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: true,
                      style: AppStyle.style(f(context, 14),
                          fontFamily: "Inter",
                          fontColor: ColorConstant.primaryBlack),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
