import 'package:flutter/material.dart';

import '../../internal/utils/style.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          'Profile',
          style: AppTextStyle.bold.copyWith(
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: const Center(child: Text('Profile'),),
    );
  }
}
