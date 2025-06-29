import 'package:flutter/material.dart';

import '../../../infrastructure/utils/utils.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Column(
      children: [
        Text('not found', style: TextStyle(fontSize: 100)),
        Utils.tinyVerticalSpace,
        Icon(Icons.error_outline_outlined),
      ],
    ),
  );
}
