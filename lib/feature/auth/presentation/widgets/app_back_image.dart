import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../app/assets_path.dart';

class AppBackGroundImage extends StatelessWidget {
  const AppBackGroundImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: SvgPicture.asset(
        AssetsPath.backGroundImage,
        fit: BoxFit.cover,
      ),
    );
  }
}