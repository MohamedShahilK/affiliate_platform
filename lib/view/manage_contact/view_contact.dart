import 'package:affiliate_platform/view/common/custom_scafflod.dart';
import 'package:flutter/material.dart';

class ViewContact extends StatelessWidget {
  const ViewContact({super.key});

  @override
  Widget build(BuildContext context) {
    return  CustomScaffold(
      onTapFloatingButton: () {},
      body: const Column(
        children: [
          CustomHeader(isBackButtonNeeded: true, heading: 'Contact Details'),
          Column(
            children: [],
          ),
        ],
      ),
    );
  }
}
