import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:github_app/models/user_model.dart';
import 'package:github_app/utils/images.dart';
import 'package:http/http.dart' as http;

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  Future<UserModel?> getDate() async {
    String url = "https://api.github.com/users/ibrokihimbek";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> json =
          jsonDecode(response.body) as Map<String, dynamic>;
      return UserModel.fromJson(json);
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: const Icon(
          Icons.menu_rounded,
          color: Colors.white,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 134).r,
            child: Image.asset(MyImages.image_github),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10).r,
            child: const Icon(
              Icons.notification_add_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: FutureBuilder<UserModel?>(
        future: getDate(),
        builder: (BuildContext context, AsyncSnapshot<UserModel?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (snapshot.hasData) {
            UserModel? userModel = snapshot.data;
            return Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 100.w,
                      height: 100.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(userModel?.avatar_url ?? ''),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
