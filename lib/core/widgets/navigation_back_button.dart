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
    return Padding(
      padding: const EdgeInsets.only(left: 28.0),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        color: CupertinoColors.activeGreen,
        borderRadius: BorderRadius.circular(50),
        child: const Icon(
          CupertinoIcons.back,
          size: 25,
        ),
        onPressed: () => Modular.to.navigate(backRoute),
      ),
    );
  }
}
