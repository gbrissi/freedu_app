import 'package:client/screens/home/components/home_drawer/components/drawer_option.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeOption extends StatefulWidget {
  const HomeOption({super.key});

  @override
  State<HomeOption> createState() => _HomeOptionState();
}

class _HomeOptionState extends State<HomeOption> {
  void showHome() => context.pushNamed('home');

  @override
  Widget build(BuildContext context) {
    return DrawerOption(
      label: "Home",
      leading: const Icon(
        Icons.home,
      ),
      onTap: showHome,
    );
  }
}
