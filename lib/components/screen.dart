import 'package:binevir/components/user_panel.dart';
import 'package:flutter/material.dart';

class Screen extends StatefulWidget {
  final Widget body;
  final Widget? floatingActionButton;
  final EdgeInsetsGeometry? padding;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final Decoration? decoration;
  final bool? userEdit;
  final String? userPhoto;
  final Function()? userOnTap;

  Screen({
    required this.body,
    this.padding,
    this.floatingActionButton,
    this.backgroundColor,
    this.decoration,
    this.bottomNavigationBar,
    this.userEdit = false,
    this.userPhoto,
    this.userOnTap,
  });

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            UserPanel(
              edit: widget.userEdit,
              photo: widget.userPhoto,
              onTap: widget.userOnTap,
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(child: widget.body)
          ],
        ),
      ),
      floatingActionButton: widget.floatingActionButton,
    );
  }
}
