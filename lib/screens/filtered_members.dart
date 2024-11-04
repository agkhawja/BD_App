import 'package:bd_app/screens/global.dart';
import 'package:bd_app/screens/home_screen%20.dart';
import 'package:bd_app/screens/profile.dart';
import 'package:bd_app/screens/route.dart';
import 'package:bd_app/services/api_services.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FilteredMembers extends StatefulWidget {
  final String? value;
  // ignore: non_constant_identifier_names
  final int? profession_id;
  final String? categoryName;
  final String? location;

  // ignore: non_constant_identifier_names
  const FilteredMembers({super.key, this.value, this.profession_id, this.categoryName, this.location});

  @override
  State<FilteredMembers> createState() => _FilteredMembersState();
}

class _FilteredMembersState extends State<FilteredMembers> {
  bool onTap = false;
  TextEditingController youLookingFortextEditingController = TextEditingController();
  TextEditingController locationTextEditingController = TextEditingController();
  TextEditingController categoryTextEditingController = TextEditingController();

  ApiService apiService = ApiService();
  bool canPopHomeScreen = false;
  bool canPopMemberScreen = false;
  String? categoryName;
  // ignore: prefer_typing_uninitialized_variables
  var categoryList;
  // ignore: prefer_typing_uninitialized_variables
  var categoryId;
  // ignore: prefer_typing_uninitialized_variables
  var initialValue;
  // ignore: non_constant_identifier_names
  int? profession_id;
  TextEditingController nameTextEditingController = TextEditingController();
  // TextEditingController LocationtextEditingController = TextEditingController();
  String searchName = '';
  List<String> categories = [
    'Career & Business',
    'Money & Economics',
    'Web Development'
  ];

  String selectedLocationAddress = '';
  List<Marker> mapMarkers = [];
  LatLng? selectedLocation;

  bool project = false;
  bool blogs = false;
  bool search = false;

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 1.h),
              Stack(
                children: [
                  Row(
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
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      widget.value == '' && widget.location == ''
                          ? Text(widget.categoryName!, textAlign: TextAlign.center, style: GoogleFonts.syne(color: const Color.fromRGBO(30, 30, 30, 1), fontSize: 20.sp, fontWeight: FontWeight.w700))
                          : (widget.categoryName == null && widget.location == '')
                              ? Center(child: Text(widget.value!, textAlign: TextAlign.center, style: GoogleFonts.syne(color: const Color.fromRGBO(30, 30, 30, 1), fontSize: 20.sp, fontWeight: FontWeight.w700)))
                              : (widget.categoryName == null && widget.value == '')
                                  ? Center(child: Text(widget.location!, textAlign: TextAlign.center, style: GoogleFonts.syne(color: const Color.fromRGBO(30, 30, 30, 1), fontSize: 20.sp, fontWeight: FontWeight.w700)))
                                  : Center(child: Text(widget.categoryName!, textAlign: TextAlign.center, style: GoogleFonts.syne(color: const Color.fromRGBO(30, 30, 30, 1), fontSize: 20.sp, fontWeight: FontWeight.w700))),
                    ],
                  )
                ],
              ),

              Card(
                elevation: 10,
                child: Container(
                  height: 32.h,
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
                          onChanged: (value) {},
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
                          controller: locationTextEditingController,
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
                      SizedBox(height: 2.h),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: ElevatedButton(
                          onPressed: () {
                            if (youLookingFortextEditingController.text.isEmpty && profession_id == null && locationTextEditingController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text('Please Select a Category or Search by Member Name or Company Name or Location', style: TextStyle(fontSize: 15.sp)),
                                ),
                              );
                            } else {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return FilteredMembers(
                                      value: youLookingFortextEditingController.text,
                                      profession_id: (profession_id) ?? null,
                                      categoryName: categoryName,
                                      location: locationTextEditingController.text,
                                    );
                                  },
                                ),
                              );
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
              // : const SizedBox(),
              SizedBox(height: 2.h),
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: SizedBox(
                    child: FutureBuilder(
                      future: searchName != ''
                          ? ApiService().searchMemberbyNameAndCategory(context, nameTextEditingController.text, widget.profession_id!)
                          : widget.location != ''
                              ? ApiService().searchMemberbyLocation(context, widget.location!)
                              : widget.value == ""
                                  ? ApiService().searchMembersbyCategory(context, widget.profession_id!)
                                  : widget.value != '' && widget.profession_id != null
                                      ? ApiService().searchMemberbyNameAndCategory(context, widget.value!, widget.profession_id!)
                                      : ApiService().searchMemberbyName(context, widget.value!),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.data!['data']['total'] == 0) {
                          return SizedBox(
                            height: 60.h,
                            child: Center(
                              child: Text(
                                'No Data Found',
                                style: TextStyle(color: Colors.red, fontSize: 17.sp, fontWeight: FontWeight.w500),
                              ),
                            ),
                          );
                        } else if (snapshot.hasData) {
                          return SizedBox(
                            //height: 50.h,
                            child: DynamicHeightGridView(
                              crossAxisCount: 2,
                              physics: const NeverScrollableScrollPhysics(),
                              //gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                              shrinkWrap: true,
                              itemCount: snapshot.data!['data']['data'].length,
                              // scrollDirection: Axis.vertical,
                              builder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(top: 2.h),
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Card(
                                      color: Colors.white,
                                      elevation: 10,
                                      child: SizedBox(
                                        height: 27.h,
                                        child: Column(
                                          children: [
                                            ClipOval(
                                              child: Image.network(
                                                snapshot.data!['data']['data'][index]['image_main_file'],
                                                height: 40.sp,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(height: 1.h),
                                            Text("${snapshot.data!['data']['data'][index]['first_name']} ${snapshot.data!['data']['data'][index]['last_name']}", style: GoogleFonts.syne(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.bold)),
                                            SizedBox(height: 0.1.h),
                                            Text(
                                              snapshot.data!['data']['data'][index]['profession_name'] ?? "",
                                              style: GoogleFonts.syne(color: Colors.grey, fontSize: 16.sp, fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(height: 0.1.h),
                                            RatingBar.builder(
                                              ignoreGestures: true,
                                              itemSize: 18,
                                              initialRating: 3,
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                                              itemBuilder: (context, _) => const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (rating) {},
                                            ),
                                            SizedBox(height: 1.h),
                                            SizedBox(
                                              height: 3.h,
                                              width: 35.w,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    profile = true;
                                                    print(profile);

                                                    user_id = snapshot.data!['data']['data'][index]['user_id'];
                                                    print(user_id);
                                                  });
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) {
                                                        return RoutePage();
                                                      },
                                                    ),
                                                  );
                                                  // Navigator.push(
                                                  //   context,
                                                  //   MaterialPageRoute(
                                                  //     builder: (context) {
                                                  //       return ProfilePage(
                                                  //         user_id: snapshot.data!['data']['data'][index]['user_id'],
                                                  //       );
                                                  //     },
                                                  //   ),
                                                  // );
                                                },
                                                style: ElevatedButton.styleFrom(backgroundColor: Colors.white, side: const BorderSide(color: Colors.blue)),
                                                child: Text(
                                                  'View Profile',
                                                  style: GoogleFonts.syne(color: Colors.black, fontSize: 14.sp, fontWeight: FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 3.h),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return const Center(child: Text("No Data Found"));
                        }
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5.h),
            ],
          ),
        ),
      ),
    );
  }
}
