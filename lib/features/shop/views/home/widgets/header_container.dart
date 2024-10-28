import 'package:flutter/cupertino.dart';

import '../../../../../common/widgets/custom_shapes/containers/circular_container.dart';
import '../../../../../common/widgets/custom_shapes/curved_edges/curved_edges.dart';
import '../../../../../utils/constants/colors.dart';

class HeaderContainer extends StatelessWidget {
  const HeaderContainer({
    super.key, required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomCurvedEdges(),
      child: Container(
        color: AppPallete.primary,
        padding: const EdgeInsets.all(0),
        child: Stack(
          children: [
            Positioned(
              top: -250,
              right: -250,
              child: CircularContainer(
                backgroundColor: AppPallete.whiteColor.withOpacity(0.1),
              ),
            ),
            Positioned(
              top: 100,
              right: -270,
              child: CircularContainer(
                backgroundColor: AppPallete.whiteColor.withOpacity(0.1),
              ),
            ),
            child
          ],
        ),
      ),
    );
  }
}

/*
  - ClipPath is used to create the top space of HomeScreen.
  - That space is used for Header.
  - All the content of this Header is in 'child' attribute.
 */
