import 'package:flutter/Material.dart';

class ProductTitle extends StatelessWidget {
  final String title;

  const ProductTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      // ignore: deprecated_member_use
      style: Theme.of(context).textTheme.displayLarge!.copyWith(
            color: Colors.black,
          ),
    );
  }
}
