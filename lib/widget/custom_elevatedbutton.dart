import 'package:oriksha_application/core/Utils/app_textstyle.dart';
import 'package:oriksha_application/core/Utils/color_constant.dart';
import 'package:oriksha_application/core/Utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class CustomElevatedButton extends StatelessWidget {
  final void Function() onPressed;
  final String buttonName;
  final bool? isLoading;
  final String? icon;

  const CustomElevatedButton(
      {super.key,
      required this.onPressed,
      required this.buttonName,
      this.isLoading = false, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: h(context, 40),
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        width: double.infinity,
        child: ElevatedButton(
            onPressed: !isLoading! ? onPressed : () {},
            style: ElevatedButton.styleFrom(
                shadowColor: Colors.grey,
                elevation: 4,
                foregroundColor: Colors.white,
                splashFactory: InkRipple.splashFactory,
                surfaceTintColor: ColorConstant.transparent,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                backgroundColor: ColorConstant.primaryOrg),
            child: !isLoading!
                ?icon!=null? Row(
                  children: [
                    icon != null?
                        SvgPicture.asset(icon!):Icon(Icons.arrow_forward_rounded),
                    Gap(w(context, 10)),
                    Text(
                        buttonName,
                        style: AppStyle.style(f(context, 18),
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w700,
                            fontColor: ColorConstant.primaryWhite,
                            ),
                      ),
                  ],
                ):                    Text(
              buttonName,
              style: AppStyle.style(f(context, 19),
                fontFamily: "Inter",
                fontWeight: FontWeight.bold,
                fontColor: ColorConstant.primaryWhite,
              ),
            )
                : SizedBox(
                    height: h(context, 30),
                    width: h(context, 30),
                    child: const CircularProgressIndicator(
                      color: ColorConstant.primaryWhite,
                      strokeWidth: 2,
                    ))));
  }
}
