import '../core/app_export.dart';

class CustomAppBar extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final Widget? action;

   const CustomAppBar({super.key, this.onPressed, required this.text,  this.action});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: onPressed != null
            ? Row(
                children: [
                  //back button
                  IconButton(
                      style: const ButtonStyle(
                          overlayColor: MaterialStatePropertyAll(
                              ColorConstant.transparent)),
                      onPressed: onPressed,
                      icon: const Icon(
                        Icons.keyboard_backspace,
                        color: ColorConstant.primaryBlack,
                        size: 30,
                      )),
                  Gap(w(context, 10)),
                  Text(text,
                      style: AppStyle.style(f(context, 18),
                          fontColor: ColorConstant.primaryBlack,
                          fontWeight: FontWeight.w600)),
                ],
              )
            : Padding(
                padding:
                    EdgeInsets.only(left: w(context, 28), top: h(context, 10),right: w(context, 28)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      text,
                      style: AppStyle.style(f(context, 20),
                          fontColor: ColorConstant.primaryBlack,
                          fontWeight: FontWeight.w600),
                    ),
                    action??SizedBox(),

                  ],
                ),
              ));
  }
}
