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
            return Center(child: Text('Hatolik yuz berdi'));
          }
          if (snapshot.hasData) {
            UserModel? userModel = snapshot.data;
            return Padding(
              padding: const EdgeInsets.all(20).r,
              child: Column(children: [
                Row(
                  children: [
                    Container(
                      width: 90.w,
                      height: 90.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(userModel?.avatar_url ?? ''),
                        ),
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userModel?.name ?? '',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          userModel?.login ?? '',
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                Container(
                  height: 30.h,
                  width: double.infinity.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey, width: 1.w),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 10.w),
                      Image.asset(
                        MyImages.image_dart,
                        width: 22.w,
                      ),
                      SizedBox(width: 10.w),
                      const Text('Focusing')
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  height: 30.h,
                  width: double.infinity.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey, width: 1.w),
                      color: Colors.grey[200]),
                  child: const Center(
                    child: Text('Edit profile'),
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    const Icon(
                      Icons.link,
                      color: Colors.black,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      userModel?.html_url ?? '',
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    const Icon(
                      Icons.people,
                      color: Colors.black,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: ' ${userModel?.followers ?? ''}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Colors.black),
                          ),
                          const TextSpan(
                            text: ' followers • ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: ' ${userModel?.following ?? ''}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Colors.black),
                          ),
                          const TextSpan(
                            text: ' followers',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                Row(
                  children: [
                    const Icon(
                      Icons.book_outlined,
                      color: Colors.black,
                    ),
                    const Text(
                      ' Repositories ',
                      style: TextStyle(fontSize: 16),
                    ),
                    Container(
                      width: 26.w,
                      height: 22.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.grey[300]),
                      child: Center(
                        child: Text(
                          (userModel?.public_repos ?? '').toString(),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
            );
          }
          return Container();
        },
      ),
    );
  }
}
