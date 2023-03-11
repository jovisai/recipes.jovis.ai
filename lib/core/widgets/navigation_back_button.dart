import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

class NavigationBackButton extends StatelessWidget {
  final String backRoute;
  const NavigationBackButton({
    super.key,
    required this.backRoute,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0),
        child: Row(children: const [
          Icon(
            CupertinoIcons.back,
            size: 25,
          ),
          Text(
            "Back",
            style: TextStyle(color: CupertinoColors.activeGreen),
          )
        ]),
      ),
      onTap: () => Modular.to.navigate(backRoute),
    );
  }
}
