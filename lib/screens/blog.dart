import 'package:bd_app/screens/route.dart';
import 'package:bd_app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Blog extends StatefulWidget {
  const Blog({super.key});

  @override
  State<Blog> createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  List<String> categories = [
    'Career & Business',
    'Money & Economics',
    'Web Development'
  ];
  List<String> blogImages = [
    'images/Rectangle 6717.png',
    'images/Rectangle 4.png',
    'images/Rectangle 6717.png',
  ];
  List<String> monthNames = [
    "Jan",
    "Feb",
    "March",
    "April",
    "May",
    "June",
    "July",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
  getDateFromTimestamp(String timestamp) {
    String fullDate = timestamp.substring(0, 8);
    String year = fullDate.substring(0, 4);
    String month = fullDate.substring(4, 6);
    String day = fullDate.substring(6, 8);
    return "${monthNames[int.parse(month) - 1]} $day $year";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 1.h),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, size: 21.sp),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return RoutePage();
                        },
                      ));
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.w),
                    child: Text('Explore Blogs', style: GoogleFonts.syne(color: const Color.fromRGBO(30, 30, 30, 1), fontSize: 21.sp, fontWeight: FontWeight.w600)),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                child: Card(
                  elevation: 10,
                  color: Colors.white,
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      iconColor: const Color.fromRGBO(22, 103, 128, 1),
                      focusColor: Colors.white,
                      hoverColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 12),
                        child: Image.asset(
                          // height: 0.h,
                          'images/search-normal (3).png',
                        ),
                      ),
                      hintText: 'Search',
                      hintStyle: GoogleFonts.syne(
                        color: Colors.black,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      suffixIcon: Image.asset('images/flowbite_filter-outline (1).png'),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Explore Categories',
                    style: GoogleFonts.syne(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                  Container(
                    width: 25.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      border: Border.all(color: const Color.fromARGB(255, 233, 232, 232), width: 2),
                    ),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                      ),
                      child: Text(
                        'See All',
                        style: GoogleFonts.syne(color: const Color.fromRGBO(22, 103, 128, 1), fontSize: 15.sp, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              SizedBox(
                height: 5.h,
                child: FutureBuilder(
                  future: ApiService().getBlogsData(context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!['data'][0]['feature_categories'].length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2.w),
                            child: Container(
                              height: 4.h,
                              width: 50.w,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(22, 103, 128, 1),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 1),
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    snapshot.data!['data'][0]['feature_categories'][index],
                                    style: GoogleFonts.syne(
                                      fontSize: 17.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Text('No Data Found');
                    }
                  },
                ),
              ),
              SizedBox(height: 3.h),
              Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 5.w),
                        child: Text(
                          'Newest',
                          style: GoogleFonts.syne(fontSize: 20.sp, fontWeight: FontWeight.w600, color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 45.w),
                        child: Container(
                          width: 25.w,
                          height: 4.h,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            border: Border.all(color: const Color.fromARGB(255, 233, 232, 232), width: 2),
                          ),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                            ),
                            child: Text(
                              'See All',
                              style: GoogleFonts.syne(color: const Color.fromRGBO(22, 103, 128, 1), fontSize: 15.sp, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 2.h),
                  SizedBox(
                    height: 53.h,
                    width: 95.w,
                    child: FutureBuilder(
                      future: ApiService().getBlogsData(context),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data!['data'].length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 1.5.w),
                                child: SizedBox(
                                  width: 75.w,
                                  child: Card(
                                    color: Colors.white,
                                    elevation: 30,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Stack(
                                            children: [
                                              Image.network(
                                                fit: BoxFit.fill,
                                                // 'images/Rectangle 6717.png',
                                                snapshot.data!['data'][index]['post_image'],
                                                height: 22.h,
                                                width: 95.w,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 3.h),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                // 'UI DESIGN',
                                                snapshot.data!['data'][index]['post_category'],
                                                style: GoogleFonts.syne(color: const Color.fromRGBO(5, 129, 121, 1), fontSize: 17.sp, fontWeight: FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 63.w,
                                                child: Text(
                                                  // overflow: TextOverflow.ellipsis,
                                                  maxLines: null,
                                                  // 'Why UX Design is More\nImportant Then UI Design',
                                                  snapshot.data!['data'][index]['post_title'],
                                                  style: GoogleFonts.syne(color: const Color.fromRGBO(0, 0, 0, 1), fontSize: 17.sp, fontWeight: FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 2.h),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              CircleAvatar(
                                                radius: 20.sp,
                                                backgroundImage: NetworkImage(
                                                  snapshot.data!['data'][index]['user_photo'],
                                                ),
                                              ),
                                              SizedBox(width: 3.w),
                                              Text(
                                                // name[index],
                                                snapshot.data!['data'][index]['last_name'],
                                                style: GoogleFonts.syne(color: Colors.black, fontSize: 17.sp, fontWeight: FontWeight.w700),
                                              ),
                                              SizedBox(width: 9.w),
                                              // Image.asset('images/Ellipse 185 (3).png'),
                                              Container(
                                                height: 0.8.h,
                                                width: 2.5.w,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.grey.shade400,
                                                ),
                                              ),
                                              SizedBox(width: 1.w),
                                              Text(
                                                // '1 hour ago',
                                                getDateFromTimestamp(snapshot.data!['data'][index]['post_start_date']),
                                                style: GoogleFonts.syne(color: Colors.grey, fontSize: 15.sp, fontWeight: FontWeight.w400),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return const Text('Data not Found');
                        }
                      },
                    ),
                  ),

                  SizedBox(height: 1.5.h),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 4.w),
                        child: Text(
                          'Most Popular',
                          style: GoogleFonts.syne(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(width: 25.w),
                      Container(
                        width: 25.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          border: Border.all(color: const Color.fromARGB(255, 233, 232, 232), width: 2),
                        ),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                          ),
                          child: Text(
                            'See All',
                            style: GoogleFonts.syne(color: const Color.fromRGBO(22, 103, 128, 1), fontSize: 15.sp, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  SizedBox(
                    height: 47.h,
                    width: 97.w,
                    child: ListView.builder(
                      itemCount: 3,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 1.5.w),
                          child: SizedBox(
                            width: 75.w,
                            child: Card(
                              color: Colors.white,
                              elevation: 20,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        Image.asset(
                                          blogImages[index],
                                          height: 22.h,
                                          width: 95.w,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 1.h),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'UI DESIGN',
                                          style: GoogleFonts.syne(color: const Color.fromRGBO(5, 129, 121, 1), fontSize: 16.sp, fontWeight: FontWeight.w600, letterSpacing: 4),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 1.5.h),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Why UX Design is More\nImportant Then UI Design',
                                          style: GoogleFonts.syne(color: const Color.fromRGBO(0, 0, 0, 1), fontSize: 17.sp, fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 2.5.h),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        const CircleAvatar(
                                          radius: 25,
                                          backgroundImage: AssetImage('images/Ellipse 185 (2).png'),
                                        ),
                                        SizedBox(width: 2.w),
                                        Text(
                                          'Raizo',
                                          style: GoogleFonts.syne(color: const Color.fromRGBO(0, 0, 0, 1), fontSize: 17.sp, fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(width: 7.w),
                                        Image.asset('images/Ellipse 185 (4).png'),
                                        SizedBox(width: 1.5.w),
                                        Text(
                                          '1 hour ago',
                                          style: GoogleFonts.syne(color: Colors.grey, fontSize: 17.sp, fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  //3rd
                  SizedBox(height: 1.5.h),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 4.w),
                        child: Text(
                          'Top Rated',
                          style: GoogleFonts.syne(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(width: 34.w),
                      Container(
                        width: 25.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          border: Border.all(color: const Color.fromARGB(255, 233, 232, 232), width: 2),
                        ),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                          ),
                          child: Text(
                            'See All',
                            style: GoogleFonts.syne(color: const Color.fromRGBO(22, 103, 128, 1), fontSize: 15.sp, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  SizedBox(
                    height: 47.h,
                    width: 97.w,
                    child: ListView.builder(
                      itemCount: 3,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 1.5.w),
                          child: SizedBox(
                            width: 75.w,
                            child: Card(
                              color: Colors.white,
                              elevation: 20,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        Image.asset(
                                          blogImages[index],
                                          height: 22.h,
                                          width: 95.w,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 1.h),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'UI DESIGN',
                                          style: GoogleFonts.syne(color: const Color.fromRGBO(5, 129, 121, 1), fontSize: 16.sp, fontWeight: FontWeight.w600, letterSpacing: 4),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 1.5.h),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Why UX Design is More\nImportant Then UI Design',
                                          style: GoogleFonts.syne(color: const Color.fromRGBO(0, 0, 0, 1), fontSize: 17.sp, fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 2.5.h),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        const CircleAvatar(
                                          radius: 25,
                                          backgroundImage: AssetImage('images/Ellipse 185 (2).png'),
                                        ),
                                        SizedBox(width: 2.w),
                                        Text(
                                          'Raizo',
                                          style: GoogleFonts.syne(color: const Color.fromRGBO(0, 0, 0, 1), fontSize: 17.sp, fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(width: 7.w),
                                        Image.asset('images/Ellipse 185 (4).png'),
                                        SizedBox(width: 1.5.w),
                                        Text(
                                          '1 hour ago',
                                          style: GoogleFonts.syne(color: Colors.grey, fontSize: 17.sp, fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 5.h),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
