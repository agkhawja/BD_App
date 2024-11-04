import 'package:bd_app/screens/blog.dart';
import 'package:bd_app/screens/explore_projects.dart';
import 'package:bd_app/screens/filtered_members.dart';
import 'package:bd_app/screens/global.dart';
import 'package:bd_app/screens/members.dart';
import 'package:bd_app/screens/profile.dart';
import 'package:bd_app/screens/route.dart';
import 'package:bd_app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeScreen extends StatefulWidget {
  // final bool homeScreenVariable;
  final VoidCallback exploreMembersFunction;
  const HomeScreen({super.key, required this.exploreMembersFunction});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController youLookingFortextEditingController = TextEditingController();
  TextEditingController locationTextEditingController = TextEditingController();
  TextEditingController categoryTextEditingController = TextEditingController();
  final MapController _mapController = MapController();

  String selectedLocationAddress = '';
  List<Marker> mapMarkers = [];
  LatLng? selectedLocation;

  ApiService apiService = ApiService();
  bool canPopHomeScreen = false;
  bool canPopMemberScreen = false;
  bool homeSceeen = false;
  String? categoryName;
  bool project = false;
  bool blogs = false;
  bool search = false;

  // ignore: prefer_typing_uninitialized_variables
  var initialValue;
  // ignore: non_constant_identifier_names
  int? profession_id;
  // ignore: prefer_typing_uninitialized_variables
  var categoryList;
  // ignore: prefer_typing_uninitialized_variables
  var categoryId;
  bool color = false;
  var _searchResults = <Placemark>[];
  void clearSearchResults() {
    setState(() {
      _searchResults = [];
    });
  }

  String _formatPlacemarkAddress(Placemark place) {
    // Only add relevant address parts: state (administrative area), capital/locality, and country.
    List<String> addressParts = [
      place.administrativeArea, // State name
      place.locality, // Capital or locality name
      place.country, // Country name
    ].whereType<String>().where((part) => part.isNotEmpty).toList();

    print('Filtered addressParts: $addressParts');
    return addressParts.join(", ");
  }

  Future<void> searchLocation() async {
    final query = locationTextEditingController.text.trim();
    if (query.isNotEmpty) {
      try {
        final locations = await locationFromAddress(query);
        if (locations.isNotEmpty) {
          final humanReadableAddress = await placemarkFromCoordinates(locations.first.latitude, locations.first.longitude);
          setState(() {
            _searchResults = humanReadableAddress.where((address) {
              return _formatPlacemarkAddress(address).isNotEmpty;
            }).toList();
          });
        } else {
          clearSearchResults();
        }
      } catch (e) {
        print(e.toString());
        clearSearchResults();
      }
    } else {
      clearSearchResults();
    }
  }

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

  String getDateFromTimestamp(String timestamp) {
    String fullDate = timestamp.substring(0, 8);
    int year = int.parse(fullDate.substring(0, 4));
    int month = int.parse(fullDate.substring(4, 6));
    int day = int.parse(fullDate.substring(6, 8));
    String returnDate = "${monthNames[month - 1]} $day $year";
    return returnDate;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: homeSceeen
            ? Members()
            : profile == true
                ? ProfilePage(user_id: user_id)
                : project == true
                    ? ExploreProjects()
                    : blogs == true
                        ? Blog()
                        : search == true
                            ? FilteredMembers(
                                value: youLookingFortextEditingController.text,
                                profession_id: (profession_id) ?? null,
                                categoryName: categoryName,
                                location: locationTextEditingController.text,
                              )
                            : SingleChildScrollView(
                                child: SizedBox(
                                  // height: 100.h,
                                  child: Stack(
                                    children: [
                                      Image.asset('images/Ellipse 3 (1).png'),
                                      Column(
                                        children: [
                                          Container(
                                            // height: 25.h,
                                            decoration: const BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.elliptical(5, 50),
                                                bottomRight: Radius.elliptical(100, 100),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 15),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(bottom: 120),
                                                    child: Image.asset(
                                                      'images/Metaviz Logo SVG1 1.png',
                                                      height: 8.h,
                                                    ),
                                                  ),
                                                  CircleAvatar(
                                                    radius: 5.h,
                                                    backgroundColor: const Color.fromRGBO(22, 103, 128, 1),
                                                    backgroundImage: const AssetImage('images/Image.png'),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            //  height: 100.h,
                                            decoration: const BoxDecoration(color: Colors.white),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  SizedBox(height: 23.h),
                                                  SizedBox(
                                                    height: 7.h,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      children: [
                                                        Text(
                                                          'Explore Categories',
                                                          style: GoogleFonts.syne(fontSize: 19.sp, color: Colors.black, fontWeight: FontWeight.w700),
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
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(left: 2.7.w),
                                                    child: SizedBox(
                                                      height: 5.h,
                                                      child: FutureBuilder(
                                                        future: apiService.getAllCategories(context),
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
                                                  SizedBox(height: 4.h),
                                                  Stack(
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.only(left: 3.w),
                                                        child: Image.asset(
                                                          'images/Mask group (3).png',
                                                          height: 27.h,
                                                        ),
                                                      ),
                                                      Column(
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets.only(top: 5.h),
                                                            child: Center(
                                                              child: Text(
                                                                textAlign: TextAlign.center,
                                                                'Discover more  And\nget updated',
                                                                style: GoogleFonts.syne(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.white),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(height: 3.h),
                                                          ElevatedButton(
                                                            onPressed: () {},
                                                            style: TextButton.styleFrom(backgroundColor: Colors.transparent, side: BorderSide(color: Colors.white, width: 0.5.w)),
                                                            child: Text(
                                                              'Keep Exploring',
                                                              style: GoogleFonts.syne(fontSize: 17.sp, fontWeight: FontWeight.bold, color: Colors.white),
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(height: 5.h),
                                                  Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets.only(left: 2.w),
                                                            child: Text(
                                                              'Explore Members',
                                                              style: GoogleFonts.syne(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.sp),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 25.w,
                                                            child: Container(
                                                              width: 25.w,
                                                              height: 4.h,
                                                              decoration: BoxDecoration(
                                                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                                                                border: Border.all(color: const Color.fromARGB(255, 233, 232, 232), width: 2),
                                                              ),
                                                              child: ElevatedButton(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    homeSceeen = true;
                                                                  });
                                                                  // Navigator.push(
                                                                  //   context,
                                                                  //   MaterialPageRoute(
                                                                  //     builder: (context) {
                                                                  //       return const Members();
                                                                  //     },
                                                                  //   ),
                                                                  // );
                                                                },
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
                                                      SizedBox(height: 3.h),
                                                      SizedBox(
                                                        height: 25.h,
                                                        child: FutureBuilder(
                                                          future: apiService.getMembersData(context),
                                                          builder: (context, snapshot) {
                                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                                              return const Center(
                                                                child: CircularProgressIndicator(),
                                                              );
                                                            } else if (snapshot.hasData) {
                                                              return ListView.builder(
                                                                //shrinkWrap: true,
                                                                itemCount: snapshot.data!['data']['data'].length,
                                                                scrollDirection: Axis.horizontal,
                                                                itemBuilder: (context, index) {
                                                                  return GestureDetector(
                                                                    onTap: () {
                                                                      setState(() {
                                                                        profile = true;
                                                                        print(profile);

                                                                        user_id = snapshot.data!['data']['data'][index]['user_id'];
                                                                        print(user_id);
                                                                      });
                                                                      // Navigator.push(
                                                                      //   context,
                                                                      //   MaterialPageRoute(
                                                                      //     builder: (context) {
                                                                      //       return RoutePage();
                                                                      //     },
                                                                      //   ),
                                                                      // );
                                                                    },
                                                                    child: Padding(
                                                                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                                                                      child: Column(
                                                                        children: [
                                                                          ClipOval(
                                                                            child: Image.network(
                                                                              snapshot.data!['data']['data'][index]['image_main_file'],
                                                                              height: 90,
                                                                              width: 90,
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                          ),
                                                                          SizedBox(height: 2.h),
                                                                          Text(
                                                                            "${snapshot.data!['data']['data'][index]['first_name']} ${snapshot.data!['data']['data'][index]['last_name']}",
                                                                            //mainText[index],
                                                                            style: GoogleFonts.syne(color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.bold),
                                                                          ),
                                                                          SizedBox(height: 0.3.h),
                                                                          Text(
                                                                            snapshot.data!['data']['data'][index]['profession_name'] ?? "",
                                                                            style: GoogleFonts.syne(color: Colors.grey, fontSize: 16.sp, fontWeight: FontWeight.w500),
                                                                          ),
                                                                          SizedBox(height: 2.h),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                            } else {
                                                              return const Center(child: Text("No Data Found"));
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                      Stack(
                                                        children: [
                                                          Transform.scale(
                                                            scale: 1,
                                                            child: Image.asset(
                                                              'images/Mask group (5).png',
                                                            ),
                                                          ),
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets.only(top: 90, left: 7.w),
                                                                child: Text('Want to grow your\nbusiness you are\nright place', style: GoogleFonts.syne(color: Colors.white, fontSize: 22.sp, fontWeight: FontWeight.bold)),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(top: 10, left: 8.w),
                                                                child: Text('Get started now!', style: GoogleFonts.syne(color: Colors.white, fontSize: 19.sp, fontWeight: FontWeight.w600)),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(left: 9.w, top: 25),
                                                                child: ElevatedButton(
                                                                  onPressed: () {},
                                                                  style: TextButton.styleFrom(backgroundColor: Colors.white, side: BorderSide(color: Colors.white, width: 0.5.w)),
                                                                  child: Text(
                                                                    'Know More',
                                                                    style: GoogleFonts.syne(fontSize: 17.sp, fontWeight: FontWeight.bold, color: Colors.black),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 3.h),
                                                      Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets.only(left: 5.w),
                                                                child: Text(
                                                                  'Latest Projects',
                                                                  style: GoogleFonts.syne(fontSize: 19.sp, fontWeight: FontWeight.bold, color: Colors.black),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(left: 20.w),
                                                                child: SizedBox(
                                                                  width: 25.w,
                                                                  height: 4.h,
                                                                  child: Container(
                                                                    //width: 100.w,
                                                                    height: 4.h,
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                                                                      border: Border.all(color: const Color.fromARGB(255, 233, 232, 232), width: 2),
                                                                    ),
                                                                    child: ElevatedButton(
                                                                      onPressed: () {
                                                                        setState(() {
                                                                          project = true;
                                                                        });
                                                                        // Navigator.push(
                                                                        //   context,
                                                                        //   MaterialPageRoute(
                                                                        //     builder: (context) {
                                                                        //       setState(() {
                                                                        //         project = true;
                                                                        //       });
                                                                        //       return ExploreProjects();
                                                                        //     },
                                                                        //   ),
                                                                        // );
                                                                      },
                                                                      style: ElevatedButton.styleFrom(
                                                                        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                                                                      ),
                                                                      child: Text(
                                                                        'See All',
                                                                        style: GoogleFonts.syne(color: const Color.fromRGBO(22, 103, 128, 1), fontSize: 15.sp, fontWeight: FontWeight.w700),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(height: 3.h),
                                                      SizedBox(
                                                        height: 45.h,
                                                        width: 95.w,
                                                        child: FutureBuilder(
                                                          future: apiService.getProjectsData(context),
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
                                                                                        radius: 30,
                                                                                        backgroundImage: NetworkImage(
                                                                                          snapshot.data!['data'][index]['user_photo'],
                                                                                        ),
                                                                                        backgroundColor: const Color.fromRGBO(46, 85, 226, 1),
                                                                                      ),
                                                                                      SizedBox(width: 3.w),
                                                                                      Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          Text(
                                                                                            // 'Company',
                                                                                            snapshot.data!['data'][index]['company'],
                                                                                            style: GoogleFonts.syne(color: Colors.white, fontSize: 19.sp, fontWeight: FontWeight.w700),
                                                                                          ),
                                                                                          Text(
                                                                                            // 'By Christopher',
                                                                                            "By ${snapshot.data!['data'][index]['full_name']}",
                                                                                            style: GoogleFonts.syne(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w500),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                      SizedBox(width: 13.w),
                                                                                      SizedBox(
                                                                                        width: 20.w,
                                                                                        height: 4.h,
                                                                                        child: ElevatedButton(
                                                                                          onPressed: () {},
                                                                                          style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue.shade300.withOpacity(0.5)),
                                                                                          child: Text(
                                                                                            'Visit',
                                                                                            style: GoogleFonts.syne(color: Colors.white, fontSize: 17.sp, fontWeight: FontWeight.w500),
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
                                                                                  style: GoogleFonts.syne(color: Colors.black, fontSize: 19.sp, fontWeight: FontWeight.w600),
                                                                                ),
                                                                                Text(
                                                                                  'Excellent business opportunity!! profitable ...',
                                                                                  style: GoogleFonts.syne(color: Colors.black, fontSize: 17.sp, fontWeight: FontWeight.w400),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            SizedBox(height: 1.h),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              // crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                RatingBar.builder(
                                                                                  ignoreGestures: true,
                                                                                  itemSize: 33,
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
                                                                                  style: GoogleFonts.syne(color: const Color.fromRGBO(0, 51, 129, 1), fontSize: 19.sp, fontWeight: FontWeight.w600),
                                                                                ),
                                                                                SizedBox(width: 4.w),
                                                                                Text(
                                                                                  '(84) Reviews',
                                                                                  style: GoogleFonts.syne(color: Colors.grey, fontSize: 19.sp, fontWeight: FontWeight.w600),
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
                                                      SizedBox(height: 2.h),
                                                      Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets.only(left: 6.w),
                                                                child: Text(
                                                                  'Recent Blogs',
                                                                  style: GoogleFonts.syne(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.black),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(left: 20.w),
                                                                child: SizedBox(
                                                                  width: 25.w,
                                                                  height: 4.h,
                                                                  child: Container(
                                                                    width: 25.w,
                                                                    height: 4.h,
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                                                                      border: Border.all(color: const Color.fromARGB(255, 233, 232, 232), width: 2),
                                                                    ),
                                                                    child: ElevatedButton(
                                                                      onPressed: () {
                                                                        setState(() {
                                                                          blogs = true;
                                                                        });
                                                                        // Navigator.push(
                                                                        //   context,
                                                                        //   MaterialPageRoute(
                                                                        //     builder: (context) {
                                                                        //       return const Blog();
                                                                        //     },
                                                                        //   ),
                                                                        // );
                                                                      },
                                                                      style: ElevatedButton.styleFrom(
                                                                        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                                                                      ),
                                                                      child: Text(
                                                                        'See All',
                                                                        style: GoogleFonts.syne(color: const Color.fromRGBO(22, 103, 128, 1), fontSize: 15.sp, fontWeight: FontWeight.w700),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(height: 1.5.h),
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
                                                      SizedBox(height: 5.h),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Positioned(
                                        top: 12.h,
                                        left: 8.w,
                                        child: Card(
                                          elevation: 10,
                                          child: Container(
                                            width: 85.w,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Column(
                                              children: [
                                                SizedBox(height: 2.h),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                                  child: TextFormField(
                                                    controller: youLookingFortextEditingController,
                                                    decoration: InputDecoration(
                                                      fillColor: Colors.white,
                                                      filled: true,
                                                      enabledBorder: const UnderlineInputBorder(
                                                        borderSide: BorderSide(color: Colors.grey),
                                                      ),
                                                      focusedBorder: const UnderlineInputBorder(
                                                        borderSide: BorderSide(color: Colors.white),
                                                      ),
                                                      prefixIcon: Padding(
                                                        padding: const EdgeInsets.only(right: 15),
                                                        child: Image.asset(
                                                          'images/hugeicons_service.png',
                                                          height: 20,
                                                          width: 20,
                                                        ),
                                                      ),
                                                      prefixIconConstraints: const BoxConstraints(
                                                        minWidth: 40,
                                                        minHeight: 40,
                                                      ),
                                                      hintText: 'You looking for?',
                                                      hintStyle: GoogleFonts.syne(
                                                        color: Colors.black,
                                                        fontSize: 17.sp,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(left: 2.w),
                                                      child: const Icon(Icons.category_outlined),
                                                    ),
                                                    SizedBox(width: 5.w),
                                                    SizedBox(
                                                      height: 5.5.h,
                                                      width: 65.w,
                                                      child: FutureBuilder(
                                                        future: ApiService().getAllCategories(context),
                                                        builder: (context, snapshot) {
                                                          // Ensure the Future is complete and has data
                                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                                            return const Center(child: CircularProgressIndicator()); // Loading indicator
                                                          } else if (snapshot.hasError) {
                                                            return Text('Error: ${snapshot.error}');
                                                          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                                            return const Text('No categories available');
                                                          } else {
                                                            // Extract categories from the snapshot
                                                            var categories = snapshot.data!;
                                                            categoryList = categories.map((category) => category.name).toList();
                                                            categoryId = categories.map((category) => int.parse(category.id!)).toList();

                                                            // Check if initialValue is present in the fetched data
                                                            if (!categories.map((category) => category.name).contains(initialValue)) {
                                                              // Set initialValue to null or to a default value if it does not match any category
                                                              initialValue = null; // Optionally set to categories[0].name for default selection
                                                            }

                                                            return DropdownButton<String>(
                                                              isExpanded: true,
                                                              value: initialValue, // Ensure this matches one of the items in the dropdown
                                                              hint: Text(initialValue ?? 'Select a category'),
                                                              items: categories.map<DropdownMenuItem<String>>(
                                                                (category) {
                                                                  return DropdownMenuItem<String>(
                                                                    value: category.name, // Assuming category has a 'name' property
                                                                    child: Text(category.name!),
                                                                  );
                                                                },
                                                              ).toList(),
                                                              onChanged: (String? newValue) {
                                                                setState(() {
                                                                  initialValue = newValue!;
                                                                  categoryName = newValue;
                                                                  profession_id = categoryList.indexWhere((category) => category == newValue);
                                                                  profession_id = categoryId[profession_id];

                                                                  // initialValue = newValue!; // Update selected value
                                                                });
                                                              },
                                                            );
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                                                  child: const Divider(color: Colors.grey, thickness: 1, height: 1),
                                                ),
                                                SizedBox(height: 1.7.h),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                                                  child: TextFormField(
                                                    onChanged: (value) {
                                                      searchLocation();
                                                    },
                                                    controller: locationTextEditingController,
                                                    decoration: InputDecoration(
                                                      suffixIcon: locationTextEditingController.text.isNotEmpty
                                                          ? IconButton(
                                                              icon: const Icon(Icons.close, color: Colors.white),
                                                              onPressed: () {
                                                                setState(() {
                                                                  locationTextEditingController.clear();
                                                                });
                                                              },
                                                            )
                                                          : const SizedBox(),
                                                      fillColor: Colors.white,
                                                      filled: true,
                                                      enabledBorder: const UnderlineInputBorder(
                                                        borderSide: BorderSide(color: Colors.grey),
                                                      ),
                                                      focusedBorder: const UnderlineInputBorder(
                                                        borderSide: BorderSide(color: Colors.white),
                                                      ),
                                                      prefixIcon: Padding(
                                                        padding: const EdgeInsets.only(right: 15),
                                                        child: Image.asset(
                                                          'images/fluent_my-location-20-regular.png',
                                                          height: 20,
                                                          width: 20,
                                                        ),
                                                      ),
                                                      prefixIconConstraints: const BoxConstraints(
                                                        minWidth: 40,
                                                        minHeight: 40,
                                                      ),
                                                      hintText: 'Location',
                                                      hintStyle: GoogleFonts.syne(
                                                        color: Colors.black,
                                                        fontSize: 17.sp,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                if (locationTextEditingController.text.isNotEmpty)
                                                  ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: _searchResults.length,
                                                    itemBuilder: (context, index) {
                                                      final address = _formatPlacemarkAddress(_searchResults[index]);
                                                      return ListTile(
                                                        title: Text(address),
                                                        onTap: () {
                                                          locationTextEditingController.text = address;

                                                          clearSearchResults();
                                                        },
                                                      );
                                                    },
                                                  ),
                                                SizedBox(height: 2.h),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 25).copyWith(bottom: 20),
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      if (youLookingFortextEditingController.text.isEmpty && profession_id == null && locationTextEditingController.text.isEmpty) {
                                                        ScaffoldMessenger.of(context).showSnackBar(
                                                          SnackBar(
                                                            backgroundColor: Colors.red,
                                                            content: Text('Please Select a Category or Search by Member Name or Company Name or Location', style: TextStyle(fontSize: 15.sp)),
                                                          ),
                                                        );
                                                      }
                                                      // else if(youLookingFortextEditingController.text.isNotEmpty && profession_id != null){

                                                      // }
                                                      else {
                                                        setState(() {
                                                          search = true;
                                                        });
                                                      }
                                                    },
                                                    style: TextButton.styleFrom(
                                                      backgroundColor: const Color.fromRGBO(248, 163, 29, 1),
                                                      minimumSize: Size(60.w, 5.h),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Image.asset(
                                                            'images/search-normal.png',
                                                            color: Colors.white,
                                                            height: 22,
                                                            width: 22,
                                                          ),
                                                        ),
                                                        Text(
                                                          'Search',
                                                          style: GoogleFonts.syne(fontSize: 20.sp, color: Colors.white),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
      ),
    );
  }
}








// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';

// class MapScreen extends StatefulWidget {
//   const MapScreen({super.key});

//   @override
//   State<MapScreen> createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   final MapController _mapController = MapController();
//   final TextEditingController _searchController = TextEditingController();
//   var _searchResults = <Placemark>[];
//   String selectedLocationAddress = '';
//   List<Marker> mapMarkers = [];
//   LatLng? selectedLocation;

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Column(
//           children: [
//             // CustomTopBanner(
//             //     showBackButton: true,
//             //     onBack: () {
//             //       Navigator.pop(context);
//             //     }),
//             Container(
//               color: const Color(0xff122750),
//               child: Container(
//                 margin: EdgeInsets.all(20.sp),
//                 height: 6.h,
//                 width: double.infinity,
//                 child: TextField(
//                   style: TextStyle(
//                       fontSize: 15.sp,
//                       color: Colors.white,
//                       fontWeight: FontWeight.w500),
//                   controller: _searchController,
//                   decoration: InputDecoration(
//                     focusedBorder: const OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.greenAccent)),
//                     disabledBorder: const OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.white)),
//                     enabledBorder: const OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.white)),
//                     labelText: 'Search location',
//                     labelStyle: TextStyle(
//                         fontSize: 15.sp,
//                         color: Colors.white,
//                         fontWeight: FontWeight.w500),  
//                     prefixIcon: const Icon(Icons.search, color: Colors.white),
//                     suffixIcon: _searchController.text.isNotEmpty
//                         ? IconButton(
//                             icon: const Icon(Icons.close, color: Colors.white),
//                             onPressed: () {
//                               setState(() {
//                                 _searchController.clear();
//                               });
//                             },
//                           )
//                         : const SizedBox(),
//                   ),
//                   onChanged: (value) {
//                     searchLocation();
//                   },
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Stack(
//                 children: [
//                   FlutterMap(
//                     mapController: _mapController,
//                     options: MapOptions(
//                       initialZoom: 16,
//                       minZoom: 2,
//                       maxZoom: 18,
//                       initialCenter: LatLng(31.5925, 74.3095),
//                       onTap: (tapPosition, point) async {
//                         setState(() {
//                           selectedLocation = point;
//                           mapMarkers.clear();
//                           mapMarkers.add(Marker(
//                             point: point,
//                             child: const Icon(Icons.location_on,
//                                 color: Colors.red, size: 40),
//                           ));
//                         });
//                         List<Placemark> list = await placemarkFromCoordinates(
//                             point.latitude, point.longitude);
//                         selectedLocationAddress =
//                             _formatPlacemarkAddress(list.first);
//                       },
//                     ),
//                     children: [
//                       TileLayer(
//                         maxZoom: 18,
//                         minZoom: 2,
//                         urlTemplate:
//                             'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//                       ),
//                       MarkerLayer(markers: mapMarkers),
//                     ],
//                   ),
//                   Container(
//                     color: Colors.white,
//                     child: ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: _searchResults.length,
//                       itemBuilder: (context, index) {
//                         final place = _searchResults[index];
//                         return ListTile(
//                           leading: const Icon(Icons.pin_drop_outlined),
//                           title: Text(
//                             _formatPlacemarkAddress(place),
//                             style: TextStyle(
//                                 fontSize: 15.sp,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w400),
//                           ),
//                           onTap: () => selectLocation(place),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             if (selectedLocationAddress.isNotEmpty)
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 color: const Color(0xff122750),
//                 width: double.infinity,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       overflow: TextOverflow.visible,
//                       'Selected Location',
//                       style: TextStyle(
//                           fontSize: 16.sp,
//                           color: Colors.white,
//                           fontWeight: FontWeight.w600),
//                     ),
//                     Text(
//                       overflow: TextOverflow.visible,
//                       selectedLocationAddress,
//                       style: TextStyle(
//                           fontSize: 15.sp,
//                           color: Colors.white,
//                           fontWeight: FontWeight.normal),
//                     ),
//                   ],
//                 ),
//               )
//           ],
//         ),
//       ),
//     );
//   }

//   String _formatPlacemarkAddress(Placemark place) {
//     List<String> addressParts = [
//       place.name,
//       place.locality,
//       place.administrativeArea,
//       place.country,
//     ].whereType<String>().where((part) => part.isNotEmpty).toList();
//     return addressParts.join(", ");
//   }

//   Future<void> searchLocation() async {
//     final query = _searchController.text.trim();
//     if (query.isNotEmpty) {
//       try {
//         final locations = await locationFromAddress("$query, Pakistan");
//         if (locations.isNotEmpty) {
//           final humanReadableAddress = await placemarkFromCoordinates(
//               locations.first.latitude, locations.first.longitude);
//           setState(() {
//             _searchResults = humanReadableAddress.where((address) {
//               return _formatPlacemarkAddress(address).isNotEmpty &&
//                   address.country?.toLowerCase() == 'pakistan';
//             }).toList();
//           });
//         } else {
//           clearSearchResults();
//         }
//       } catch (e) {
//         print(e.toString());
//         clearSearchResults();
//       }
//     } else {
//       clearSearchResults();
//     }
//   }

//   void clearSearchResults() {
//     setState(() {
//       _searchResults = [];
//     });
//   }

//   Future<void> selectLocation(Placemark placemark) async {
//     setState(() {
//       selectedLocationAddress = _formatPlacemarkAddress(placemark);
//       _searchController.text = selectedLocationAddress;
//     });
//     try {
//       final locations =
//           await locationFromAddress(_formatPlacemarkAddress(placemark));
//       print(locations);
//       if (locations.isNotEmpty) {
//         setState(() {
//           _searchResults = [];
//           mapMarkers.clear();
//           mapMarkers.add(Marker(
//             child: const Icon(Icons.location_on, color: Colors.red, size: 40),
//             point: LatLng(locations.first.latitude, locations.first.longitude),
//           ));
//         });
//         _mapController.move(
//             LatLng(locations.first.latitude, locations.first.longitude), 15);
//       }
//     } catch (e) {
//       print('Error selecting location: $e');
//     }
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:google_fonts/google_fonts.dart';

// class LocationSearch extends StatefulWidget {
//   @override
//   _LocationSearchState createState() => _LocationSearchState();
// }

// class _LocationSearchState extends State<LocationSearch> {
//   final TextEditingController locationTextEditingController = TextEditingController();
//   List<Placemark> _searchResults = [];

//   Future<void> searchLocation() async {
//     final query = locationTextEditingController.text.trim();
//     if (query.isNotEmpty) {
//       try {
//         final locations = await locationFromAddress("$query, Pakistan");
//         if (locations.isNotEmpty) {
//           final humanReadableAddress = await placemarkFromCoordinates(locations.first.latitude, locations.first.longitude);
//           setState(() {
//             _searchResults = humanReadableAddress.where((address) {
//               return _formatPlacemarkAddress(address).isNotEmpty && address.country?.toLowerCase() == 'pakistan';
//             }).toList();
//           });
//         } else {
//           clearSearchResults();
//         }
//       } catch (e) {
//         print(e.toString());
//         clearSearchResults();
//       }
//     } else {
//       clearSearchResults();
//     }
//   }

//   void clearSearchResults() {
//     setState(() {
//       _searchResults.clear();
//     });
//   }

//   String _formatPlacemarkAddress(Placemark place) {
//     List<String> addressParts = [
//       place.name,
//       place.locality,
//       place.administrativeArea,
//       place.country,
//     ].whereType<String>().where((part) => part.isNotEmpty).toList();
//     return addressParts.join(", ");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TextFormField(
//           controller: locationTextEditingController,
//           onChanged: (value) => searchLocation(),
//           decoration: InputDecoration(
//             fillColor: Colors.white,
//             filled: true,
//             enabledBorder: const UnderlineInputBorder(
//               borderSide: BorderSide(color: Colors.grey),
//             ),
//             focusedBorder: const UnderlineInputBorder(
//               borderSide: BorderSide(color: Colors.white),
//             ),
//             prefixIcon: Padding(
//               padding: const EdgeInsets.only(right: 15),
//               child: Image.asset(
//                 'images/hugeicons_service.png',
//                 height: 20,
//                 width: 20,
//               ),
//             ),
//             prefixIconConstraints: const BoxConstraints(
//               minWidth: 40,
//               minHeight: 40,
//             ),
//             hintText: 'You looking for?',
//             hintStyle: GoogleFonts.syne(
//               color: Colors.black,
//               fontSize: 17,
//             ),
//           ),
//         ),
//         Expanded(
//           child: ListView.builder(
//             shrinkWrap: true,
//             itemCount: _searchResults.length,
//             itemBuilder: (context, index) {
//               final address = _formatPlacemarkAddress(_searchResults[index]);
//               return ListTile(
//                 title: Text(address),
//                 onTap: () {
//                   locationTextEditingController.text = address;
//                   clearSearchResults();
//                 },
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
