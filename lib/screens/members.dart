import 'package:bd_app/screens/filtered_members.dart';
import 'package:bd_app/screens/global.dart';
import 'package:bd_app/screens/profile.dart';
import 'package:bd_app/screens/route.dart';
import 'package:bd_app/services/api_services.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Members extends StatefulWidget {
  const Members({super.key});

  @override
  State<Members> createState() => _MembersState();
}

class _MembersState extends State<Members> {
  // ignore: non_constant_identifier_names
  TextEditingController YouLookingFortextEditingController = TextEditingController();
  // ignore: non_constant_identifier_names
  //TextEditingController LocationtextEditingController = TextEditingController();
  TextEditingController locationTextEditingController = TextEditingController();
  var categoryList;
  var categoryId;
  var initialValue;
  String? categoryName;
  int? profession_id;
  //bool search = false;
  var _searchResults = <Placemark>[];
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

  void clearSearchResults() {
    setState(() {
      _searchResults = [];
    });
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
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, size: 21.sp),
                    onPressed: () {
                      setState(() {
                        profile = false;
                      });
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return RoutePage();
                        },
                      ));
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Text('Explore Members', style: GoogleFonts.syne(color: const Color.fromRGBO(30, 30, 30, 1), fontSize: 20.sp, fontWeight: FontWeight.w700)),
                  )
                ],
              ),
              Card(
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
                          controller: YouLookingFortextEditingController,
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
                            if (YouLookingFortextEditingController.text.isEmpty && profession_id == null && locationTextEditingController.text.isEmpty) {
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return FilteredMembers(
                                      value: YouLookingFortextEditingController.text,
                                      profession_id: (profession_id) ?? null,
                                      categoryName: categoryName,
                                      location: locationTextEditingController.text,
                                    );
                                  },
                                ),
                              );
                              // setState(() {
                              //   search = true;
                              // });
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Explore Categories',
                    style: GoogleFonts.syne(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.w700),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'See All',
                      style: GoogleFonts.syne(color: const Color.fromRGBO(22, 103, 128, 1), fontSize: 16.sp, fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
              SizedBox(height: 2.h),
              SizedBox(
                height: 5.h,
                child: FutureBuilder(
                  future: ApiService().getAllCategories(context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length,
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
                      return const Text('Data Not Found.');
                    }
                  },
                ),
              ),
              SizedBox(height: 2.h),
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: SizedBox(
                    child: FutureBuilder(
                      future: ApiService().getMembersData(
                        context,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
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
                                              initialRating: 4.5,
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
