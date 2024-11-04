import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.amber,
        body: Center(
          child: Text(
            'Blog Screen',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 23.sp, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
