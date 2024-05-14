import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class YourShimmeringListView extends StatelessWidget {
  final double? height;
  final bool padding;
  const YourShimmeringListView({Key? key, required this.height, this.padding=true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size; // Fix the typo here
    var w = mq.width * 1;
    var h = mq.height * 1;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding==false?0 :w * 0.04),
      child: Shimmer.fromColors(
        baseColor: Colors.white.withOpacity(0.2),
        highlightColor: Colors.white.withOpacity(0.9),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return  Card(
              child: SizedBox(
                height:h* height!,
              ),
            );
          },
          itemCount: 5, // Set the itemCount to the number of shimmer items
        ),
      ),
    );
  }
}
