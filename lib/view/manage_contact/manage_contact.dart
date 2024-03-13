// ignore_for_file: lines_longer_than_80_chars, inference_failure_on_instance_creation

import 'package:affiliate_platform/view/common/custom_scafflod.dart';
import 'package:affiliate_platform/view/manage_contact/new_contact.dart';
import 'package:flutter/material.dart';

class ManageContactPage extends StatelessWidget {
  const ManageContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          const CustomHeader(),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NewContact(),
                ),
              );
            },
            child: const Text('Create New Contact'),
          ),
        ],
      ),
    );
  }
}
