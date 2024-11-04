import 'package:bd_app/screens/global.dart';
import 'package:bd_app/screens/members.dart';
import 'package:bd_app/screens/route.dart';
import 'package:bd_app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProfilePage extends StatefulWidget {
  final String user_id;
  const ProfilePage({super.key, required this.user_id});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<dynamic, dynamic> profiledata = {};
  bool loader = false;
  @override
  void initState() {
    getProfileData();
    super.initState();
  }

  Future<void> getProfileData() async {
    setState(() {
      loader = true;
    });
    int id = int.parse(widget.user_id);
    profiledata = await ApiService().getMembersProfileData(context, id);
    setState(() {
      loader = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: GoogleFonts.syne(fontSize: 20.sp, fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return RoutePage();
              },
            ));
            setState(() {
              profile = false;
            });
          },
        ),
      ),
      body: loader
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Section
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(profiledata['data']['data'][0]['image_main_file']), // Replace with actual image asset
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profiledata['data']['data'][0]['full_name'],
                            style: GoogleFonts.syne(fontSize: 19.sp, fontWeight: FontWeight.bold),
                          ),
                          Text(profiledata['data']['data'][0]['profession_name'], style: GoogleFonts.syne(fontSize: 16.sp, fontWeight: FontWeight.w600)),
                          Row(
                            children: [
                              RatingBar.builder(
                                ignoreGestures: true,
                                itemSize: 18,
                                initialRating: 4.5,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding: EdgeInsets.symmetric(horizontal: 0.w),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {},
                              ),
                              const Text('4.8/5.0', style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  // About Section
                  Text(
                    'About Member',
                    style: GoogleFonts.syne(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),
                  Text(
                    '${profiledata['data']['data'][0]['full_name']} is a marketing strategist with over 8 years of experience in driving digital growth & brand success...',
                    style: GoogleFonts.syne(fontSize: 15.sp, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 24),
                  // Contact Info Section
                  Text(
                    'Contact Info',
                    style: GoogleFonts.syne(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(children: [
                    const CircleAvatar(
                      backgroundColor: Color.fromRGBO(22, 103, 128, 1),
                      child: Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '+92-123-4567890',
                      style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
                    )
                  ]),
                  const SizedBox(height: 8),
                  Row(children: [
                    const CircleAvatar(
                      backgroundColor: Color.fromRGBO(22, 103, 128, 1),
                      child: Icon(
                        Icons.email,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(profiledata['data']['data'][0]['email'], style: GoogleFonts.syne(fontSize: 15.sp, fontWeight: FontWeight.w500))
                  ]),
                  const SizedBox(height: 8),
                  Row(children: [
                    const CircleAvatar(
                      backgroundColor: Color.fromRGBO(22, 103, 128, 1),
                      child: Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text('${profiledata['data']['data'][0]['state_ln']}, ${profiledata['data']['data'][0]['country_ln']}', style: GoogleFonts.syne(fontSize: 15.sp, fontWeight: FontWeight.w500))
                  ]),
                  const SizedBox(height: 24),
                  // Experience Section
                  Text(
                    'Experience',
                    style: GoogleFonts.syne(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ...List.generate(1, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          Icon(Icons.circle_outlined, size: 21.sp, color: const Color.fromRGBO(22, 103, 128, 1)),
                          const SizedBox(width: 8),
                          Padding(
                            padding: EdgeInsets.only(left: 2.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${profiledata['data']['data'][0]['company']}', style: GoogleFonts.syne(fontSize: 17.sp, fontWeight: FontWeight.w700)),
                                Text(' 5+ years of experience', style: GoogleFonts.syne(fontSize: 16.sp, fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 24),
                  // Services Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 1.3.w),
                        child: Text('Services', style: GoogleFonts.syne(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                      ),
                      TextButton(onPressed: () {}, child: const Text('See All')),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 0.w),
                    child: SizedBox(
                      height: 5.h,
                      child: FutureBuilder(
                        future: ApiService().getAllCategories(context),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasData) {
                            return snapshot.data!.isEmpty
                                ? const Text('No Data Found')
                                : ListView.builder(
                                    // shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.length,
                                    //itemCount: image.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 1.w),
                                        child: Container(
                                          height: 4.h,
                                          width: 42.w,
                                          decoration: BoxDecoration(
                                            color: const Color.fromRGBO(22, 103, 128, 1),
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(bottom: 1),
                                              child: Text(
                                                textAlign: TextAlign.center,
                                                snapshot.data![index].name!,
                                                //categories[index],
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
                            return const Text('Data not Found');
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  // Portfolio Section
                  Padding(
                    padding: EdgeInsets.only(left: 1.3.w),
                    child: Text(
                      'Portfolio',
                      style: GoogleFonts.syne(fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  SizedBox(
                    height: 40.h,
                    width: 95.w,
                    child: FutureBuilder(
                      future: ApiService().getProjectsData(context),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data!["data"].length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      // Image.asset(
                                      //   'images/Rectangle 4.png',
                                      //   height: 30.h,
                                      //   width: 95.w,
                                      // ),
                                      Image.network(
                                        height: 30.h,
                                        width: 95.w,
                                        snapshot.data!['data'][index]['post_image'],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          SizedBox(height: 23.h),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(width: 4.w),
                                                  CircleAvatar(
                                                    radius: 19.sp,
                                                    backgroundImage: NetworkImage(
                                                      profiledata['data']['data'][0]['image_main_file'],
                                                    ),
                                                    backgroundColor: const Color.fromRGBO(46, 85, 226, 1),
                                                  ),
                                                  SizedBox(width: 3.w),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        width: 52.w,
                                                        child: Text(
                                                          // 'Company',
                                                          profiledata['data']['data'][0]['company'],
                                                          style: GoogleFonts.syne(color: Colors.white, fontSize: 17.sp, fontWeight: FontWeight.w700),
                                                        ),
                                                      ),
                                                      Text(
                                                        // 'By Christopher',
                                                        "By ${profiledata['data']['data'][0]['full_name']}",
                                                        style: GoogleFonts.syne(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w500),
                                                      ),
                                                    ],
                                                  ),
                                                  // SizedBox(width: 13.w),
                                                  SizedBox(
                                                    width: 17.w,
                                                    height: 4.h,
                                                    child: ElevatedButton(
                                                      onPressed: () {},
                                                      style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue.shade300.withOpacity(0.5)),
                                                      child: Text(
                                                        'Visit',
                                                        style: GoogleFonts.syne(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w500),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 3.w),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              // 'Marketing Stats',
                                              snapshot.data!['data'][index]['post_title'],
                                              style: GoogleFonts.syne(color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              'Excellent business opportunity!! profitable ...',
                                              style: GoogleFonts.syne(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 0.2.h),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          // crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            RatingBar.builder(
                                              ignoreGestures: true,
                                              itemSize: 19.sp,
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
                                            SizedBox(width: 2.w),
                                            Text(
                                              '4.5',
                                              style: GoogleFonts.syne(color: const Color.fromRGBO(0, 51, 129, 1), fontSize: 17.sp, fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(width: 4.w),
                                            Text(
                                              '(84) Reviews',
                                              style: GoogleFonts.syne(color: Colors.grey, fontSize: 17.sp, fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              );
                            },
                          );
                        } else {
                          return const Text('Data not Found');
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 1.h),
                  // Certifications Section
                  Padding(
                    padding: EdgeInsets.only(left: 1.5.w),
                    child: Text(
                      'Certifications',
                      style: GoogleFonts.syne(fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 1.5.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 2.h, bottom: 1.h),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 17.sp,
                                backgroundColor: const Color.fromRGBO(22, 103, 128, 1),
                                child: const ImageIcon(
                                  AssetImage('images/ph_certificate-light.png'),
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5.w),
                                child: Text(
                                  'UX Design Certification',
                                  style: GoogleFonts.syne(fontSize: 16.sp, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 1.h),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 17.sp,
                                backgroundColor: const Color.fromRGBO(22, 103, 128, 1),
                                child: const ImageIcon(
                                  AssetImage('images/ph_certificate-light.png'),
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5.w),
                                child: Text(
                                  'Flutter Certification',
                                  style: GoogleFonts.syne(fontSize: 16.sp, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 1.h),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 17.sp,
                                backgroundColor: const Color.fromRGBO(22, 103, 128, 1),
                                child: const ImageIcon(
                                  AssetImage('images/ph_certificate-light.png'),
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5.w),
                                child: Text(
                                  'Google Ads Certification',
                                  style: GoogleFonts.syne(fontSize: 16.sp, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 1.h),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 17.sp,
                                backgroundColor: const Color.fromRGBO(22, 103, 128, 1),
                                child: const ImageIcon(
                                  AssetImage('images/ph_certificate-light.png'),
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5.w),
                                child: Text(
                                  'AI Certification',
                                  style: GoogleFonts.syne(fontSize: 16.sp, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h),
                  // Tools and Technologies Section
                  Padding(
                    padding: const EdgeInsets.only(left: 1.5),
                    child: Text(
                      'Tools and Technologies',
                      style: GoogleFonts.syne(fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image(
                        image: const AssetImage('images/devicon_figma.png'),
                        height: 5.h,
                        // width: 75.w,
                      ),
                      Image(
                        image: const AssetImage('images/devicon_vscode.png'),
                        height: 5.h,
                        // width: 75.w,
                      ),
                      Image(
                        image: const AssetImage('images/vscode-icons_file-type-reactjs.png'),
                        height: 5.h,
                        // width: 75.w,
                      ),
                      Image(
                        image: const AssetImage('images/devicon_python.png'),
                        height: 5.h,
                        // width: 75.w,
                      ),
                      Image(
                        image: const AssetImage('images/devicon_nodejs.png'),
                        height: 5.h,
                        // width: 75.w,
                      ),
                    ],
                  ),
                  // Testimonials Section
                  SizedBox(height: 5.h),
                  Padding(
                    padding: EdgeInsets.only(left: 1.5.w),
                    child: Text(
                      'Testimonials',
                      style: GoogleFonts.syne(fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  ...List.generate(3, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(backgroundImage: NetworkImage(profiledata['data']['data'][0]['image_main_file'])),
                                const SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(profiledata['data']['data'][0]['full_name'], style: GoogleFonts.syne(fontWeight: FontWeight.bold)),
                                    Row(
                                      children: List.generate(5, (index) => const Icon(Icons.star, color: Colors.amber, size: 16)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${profiledata['data']['data'][0]['full_name']} crafted innovative marketing strategies that significantly enhanced our online presence...',
                              style: GoogleFonts.syne(fontSize: 15.sp, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
    );
  }
}
