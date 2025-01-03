import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:new_prepaid_demo/core/extensions/build_context.dart';

class AccountContainer extends StatelessWidget {
  final String title;
  final List<AccountContainerTile> children;

  const AccountContainer({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          decoration: BoxDecoration(
            color: context.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 3),
                spreadRadius: 2.0,
                blurRadius: 6.0,
                color: const Color(0xff694F4F).withAlpha(50),
                blurStyle: BlurStyle.inner,
              ),
              BoxShadow(
                offset: const Offset(0, 1),
                spreadRadius: 0.0,
                blurRadius: 3.0,
                color: const Color(0xff694F4F).withAlpha(50),
                blurStyle: BlurStyle.inner,
              ),
            ],
          ),
          child: ListView.separated(
            // padding: EdgeInsets.all(8.0),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: children.length,
            separatorBuilder: (ctx, index) => Divider(height: 1.0),
            itemBuilder: (ctx, index) => children[index],
          ),
        ),
      ],
    );
  }
}

class AccountContainerTile extends StatelessWidget {
  final String image;
  final String label;
  final void Function() onTap;
  final Widget? trailing;

  const AccountContainerTile({
    super.key,
    required this.image,
    required this.label,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    const double width = 24.0;
    const double height = 24.0;

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: width,
                  height: height,
                  // child: Image.asset(image),
                  child: Icon(Icons.abc), //todo: to change
                ),
                SizedBox(width: 20.0),
                Text(label).animate().fade(duration: 500.ms),
              ],
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}
