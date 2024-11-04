import 'package:bd_app/screens/home_screen%20.dart';
import 'package:bd_app/screens/route.dart';
import 'package:bd_app/services/api_services.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ExploreProjects extends StatefulWidget {
  const ExploreProjects({super.key});

  @override
  State<ExploreProjects> createState() => _ExploreProjectsState();
}

class _ExploreProjectsState extends State<ExploreProjects> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 1.h),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, size: 21.sp),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return RoutePage();
                            },
                          ),
                        );
                      },
                    ),
                    SizedBox(width: 13.w),
                    Center(child: Text('Explore Projects', style: GoogleFonts.syne(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.bold)))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                child: Card(
                  elevation: 5,
                  child: TextFormField(
                    // controller: nameTextEditingController,
                    onEditingComplete: () {
                      setState(() {
                        // searchName = nameTextEditingController.text;
                      });
                    },
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
                          height: 0.h,
                          'images/search-normal (3).png',
                        ),
                      ),
                      hintText: 'Search',
                      hintStyle: GoogleFonts.syne(
                        color: Colors.black,
                        fontSize: 17.sp,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            // onTap = true;
                          });
                        },
                        child: Image.asset('images/flowbite_filter-outline (1).png'),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 3.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Latest Projects',
                      style: GoogleFonts.syne(color: Colors.black, fontSize: 19.sp, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: SizedBox(
                  height: 70.h,
                  //width: 47.w,
                  child: FutureBuilder(
                    future: ApiService().getProjectsData(context),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasData) {
                        return DynamicHeightGridView(
                          crossAxisCount: 2,
                          //itemCount: snapshot.data!["data"].length,
                          itemCount: 10,
                          shrinkWrap: true,
                          // scrollDirection: Axis.horizontal,
                          builder: (context, index) {
                            return SizedBox(
                              height: 32.h,
                              child: Card(
                                elevation: 10,
                                color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  //mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        // Image.asset(
                                        //   'images/Rectangle 4.png',
                                        //   height: 30.h,
                                        //   width: 95.w,
                                        // ),
                                        Image.network(
                                          height: 15.h,
                                          width: 47.w,
                                          // snapshot.data!['data'][index]['post_image'],
                                          'http://launch32970.directoryup.com/uploads/news-pictures/65--blog-post-image-20241015224652.png',
                                        ),
                                        // Column(
                                        //   crossAxisAlignment: CrossAxisAlignment.end,
                                        //   mainAxisSize: MainAxisSize.max,
                                        //   children: [
                                        //     SizedBox(height: 23.h),
                                        //     Row(
                                        //       mainAxisAlignment: MainAxisAlignment.start,
                                        //       children: [
                                        //         Row(
                                        //           children: [
                                        //             SizedBox(width: 4.w),
                                        //             CircleAvatar(
                                        //               radius: 30,
                                        //               backgroundImage: NetworkImage(
                                        //                 snapshot.data!['data'][index]['user_photo'],
                                        //               ),
                                        //               backgroundColor: const Color.fromRGBO(46, 85, 226, 1),
                                        //             ),
                                        //             SizedBox(width: 3.w),
                                        //             Column(
                                        //               crossAxisAlignment: CrossAxisAlignment.start,
                                        //               children: [
                                        //                 Text(
                                        //                   // 'Company',
                                        //                   snapshot.data!['data'][index]['company'],
                                        //                   style: GoogleFonts.syne(color: Colors.white, fontSize: 19.sp, fontWeight: FontWeight.w700),
                                        //                 ),
                                        //                 Text(
                                        //                   // 'By Christopher',
                                        //                   "By ${snapshot.data!['data'][index]['full_name']}",
                                        //                   style: GoogleFonts.syne(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w500),
                                        //                 ),
                                        //               ],
                                        //             ),
                                        //             SizedBox(width: 13.w),
                                        //             SizedBox(
                                        //               width: 20.w,
                                        //               height: 4.h,
                                        //               child: ElevatedButton(
                                        //                 onPressed: () {},
                                        //                 style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue.shade300.withOpacity(0.5)),
                                        //                 child: Text(
                                        //                   'Visit',
                                        //                   style: GoogleFonts.syne(color: Colors.white, fontSize: 17.sp, fontWeight: FontWeight.w500),
                                        //                 ),
                                        //               ),
                                        //             ),
                                        //           ],
                                        //         ),
                                        //       ],
                                        //     ),
                                        //   ],
                                        // )
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 1.w),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 1.5.h),
                                              Center(
                                                child: Padding(
                                                  padding: EdgeInsets.only(left: 0.5.w),
                                                  child: Text(
                                                    // 'Marketing Stats',
                                                    //snapshot.data!['data'][index]['post_title'],
                                                    'Marketing Stats',
                                                    style: GoogleFonts.syne(color: Colors.black, fontSize: 17.sp, fontWeight: FontWeight.w700),
                                                  ),
                                                ),
                                              ),
                                              // Text(
                                              //   'Excellent business opportunity!! profitable ...',
                                              //   style: GoogleFonts.syne(color: Colors.black, fontSize: 14.sp, fontWeight: FontWeight.w400),
                                              // ),
                                              // Text(
                                              //   // 'Company',
                                              //   snapshot.data!['data'][index]['company'],
                                              //   style: GoogleFonts.syne(color: Colors.white, fontSize: 19.sp, fontWeight: FontWeight.w700),
                                              // ),
                                              Padding(
                                                padding: EdgeInsets.only(left: 8.w, top: 0.5.h),
                                                child: Text(
                                                  // 'By Christopher',
                                                  // "By ${snapshot.data!['data'][index]['full_name']}",
                                                  'By Awais Jamil',
                                                  style: GoogleFonts.syne(color: Colors.grey, fontSize: 15.sp, fontWeight: FontWeight.w500),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 0.5.h),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            // crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(left: 9.w),
                                                child: Text(
                                                  '4.5',
                                                  style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600, color: Colors.grey),
                                                ),
                                              ),
                                              RatingBar.builder(
                                                ignoreGestures: true,
                                                itemSize: 17,
                                                initialRating: 4.5,
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemPadding: const EdgeInsets.symmetric(horizontal: 0),
                                                itemBuilder: (context, _) => const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                onRatingUpdate: (rating) {},
                                              ),
                                              // SizedBox(width: 2.w),

                                              // SizedBox(width: 1.w),
                                              // Text(
                                              //   '(84) Reviews',
                                              //   style: GoogleFonts.syne(color: Colors.grey, fontSize: 12.sp, fontWeight: FontWeight.w600),
                                              // ),
                                            ],
                                          ),
                                          SizedBox(height: 1.h),
                                          Padding(
                                            padding: EdgeInsets.only(left: 4.w),
                                            child: SizedBox(
                                              height: 3.h,
                                              width: 35.w,
                                              child: ElevatedButton(
                                                onPressed: () {},
                                                style: ElevatedButton.styleFrom(backgroundColor: Colors.white, side: const BorderSide(color: Colors.blue)),
                                                child: Text(
                                                  'View Project',
                                                  style: GoogleFonts.syne(color: Colors.black, fontSize: 14.sp, fontWeight: FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
