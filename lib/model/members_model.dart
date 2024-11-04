// class MembersModel {
//   String? status;
//   String? message;
//   Data? data;
//   String? query;

//   MembersModel({this.status, this.message, this.data, this.query});

//   MembersModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ? Data.fromJson(json['data']) : null;
//     query = json['query'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     data['message'] = message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     data['query'] = query;
//     return data;
//   }
// }

// class Data {
//   int? total;
//   List<Data1>? data;

//   Data({this.total, this.data});

//   Data.fromJson(Map<String, dynamic> json) {
//     total = json['total'];
//     if (json['data'] != null) {
//       data = <Data1>[];
//       json['data'].forEach((v) {
//         data!.add(Data1.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['total'] = total;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Data1 {
//   String? userId;
//   String? firstName;
//   String? lastName;
//   String? email;
//   String? company;
//   String? agentLikes;
//   String? phoneNumber;
//   String? address1;
//   String? address2;
//   String? city;
//   String? zipCode;
//   String? stateCode;
//   String? stateLn;
//   String? countryCode;
//   String? countryLn;
//   String? website;
//   String? twitter;
//   String? youtube;
//   String? facebook;
//   String? linkedin;
//   String? blog;
//   String? quote;
//   String? experience;
//   String? affiliation;
//   String? awards;
//   String? aboutMe;
//   String? featured;
//   String? modtime;
//   String? subscriptionId;
//   String? filename;
//   String? password;
//   String? active;
//   String? token;
//   String? refCode;
//   String? signupDate;
//   String? cookie;
//   String? lastLogin;
//   String? position;
//   String? instagram;
//   String? credentials;
//   String? bitly;
//   String? professionId;
//   String? facebookId;
//   String? googleId;
//   String? verified;
//   String? pinterest;
//   String? nationwide;
//   String? cv;
//   String? workExperience;
//   String? repMatters;
//   String? gmap;
//   String? listingType;
//   String? lat;
//   String? lon;
//   String? noGeo;
//   String? userConsent;
//   String? searchDescription;
//   String? geoState;
//   String? signUpOrigin;
//   String? createNewCategories;
//   String? fullName;
//   String? fullNameShort;
//   String? countryName;
//   String? stateName;
//   String? name;
//   String? userLocation;
//   String? gmapZoom;
//   String? memberSince;
//   String? signupDateFormat;
//   String? serviceName;
//   String? photoFile;
//   String? logoFile;
//   String? imageMainFile;
//   String? coverPhoto;
//   String? memberLoginLink;
//   bool? defaultCategoryImage;
//   Null reviewCount;
//   String? lastLoginIp;
//   String? loggedUser;
//   String? location;
//   String? professionName;
//   String? profession;
//   String? allSubcategories;
//   String? clientid;
//   String? isSubscriptionActive;
//   String? filenameHidden;
//   String? seoPageTitleHidden;
//   String? seoPageKeywordsHidden;
//   String? seoPageDescriptionHidden;
//   String? seoSocialPageTitleHidden;
//   String? seoSocialPageDescriptionHidden;
//   String? service;
//   String? result;
//   String? faction;
//   String? save;
//   String? userid;
//   String? form;
//   String? formname;
//   String? sized;
//   String? tiktok;
//   String? bookingLink;
//   String? snapchat;
//   String? whatsapp;
//   String? memberNotes;
//   String? contentCss;

//   Data1({
//     this.userId,
//     this.firstName,
//     this.lastName,
//     this.email,
//     this.company,
//     this.agentLikes,
//     this.phoneNumber,
//     this.address1,
//     this.address2,
//     this.city,
//     this.zipCode,
//     this.stateCode,
//     this.stateLn,
//     this.countryCode,
//     this.countryLn,
//     this.website,
//     this.twitter,
//     this.youtube,
//     this.facebook,
//     this.linkedin,
//     this.blog,
//     this.quote,
//     this.experience,
//     this.affiliation,
//     this.awards,
//     this.aboutMe,
//     this.featured,
//     this.modtime,
//     this.subscriptionId,
//     this.filename,
//     this.password,
//     this.active,
//     this.token,
//     this.refCode,
//     this.signupDate,
//     this.cookie,
//     this.lastLogin,
//     this.position,
//     this.instagram,
//     this.credentials,
//     this.bitly,
//     this.professionId,
//     this.facebookId,
//     this.googleId,
//     this.verified,
//     this.pinterest,
//     this.nationwide,
//     this.cv,
//     this.workExperience,
//     this.repMatters,
//     this.gmap,
//     this.listingType,
//     this.lat,
//     this.lon,
//     this.noGeo,
//     this.userConsent,
//     this.searchDescription,
//     this.geoState,
//     this.signUpOrigin,
//     this.createNewCategories,
//     this.fullName,
//     this.fullNameShort,
//     this.countryName,
//     this.stateName,
//     this.name,
//     this.userLocation,
//     this.gmapZoom,
//     this.memberSince,
//     this.signupDateFormat,
//     this.serviceName,
//     this.photoFile,
//     this.logoFile,
//     this.imageMainFile,
//     this.coverPhoto,
//     this.memberLoginLink,
//     this.defaultCategoryImage,
//     this.reviewCount,
//     this.lastLoginIp,
//     this.loggedUser,
//     this.location,
//     this.professionName,
//     this.profession,
//     this.allSubcategories,
//     this.clientid,
//     this.isSubscriptionActive,
//     this.filenameHidden,
//     this.seoPageTitleHidden,
//     this.seoPageKeywordsHidden,
//     this.seoPageDescriptionHidden,
//     this.seoSocialPageTitleHidden,
//     this.seoSocialPageDescriptionHidden,
//     this.service,
//     this.result,
//     this.faction,
//     this.save,
//     this.userid,
//     this.form,
//     this.formname,
//     this.sized,
//     this.tiktok,
//     this.bookingLink,
//     this.snapchat,
//     this.whatsapp,
//     this.memberNotes,
//     this.contentCss,
//   });

//   Data1.fromJson(Map<String, dynamic> json) {
//     userId = json['user_id'];
//     firstName = json['first_name'];
//     lastName = json['last_name'];
//     email = json['email'];
//     company = json['company'];
//     agentLikes = json['agent_likes'];
//     phoneNumber = json['phone_number'];
//     address1 = json['address1'];
//     address2 = json['address2'];
//     city = json['city'];
//     zipCode = json['zip_code'];
//     stateCode = json['state_code'];
//     stateLn = json['state_ln'];
//     countryCode = json['country_code'];
//     countryLn = json['country_ln'];
//     website = json['website'];
//     twitter = json['twitter'];
//     youtube = json['youtube'];
//     facebook = json['facebook'];
//     linkedin = json['linkedin'];
//     blog = json['blog'];
//     quote = json['quote'];
//     experience = json['experience'];
//     affiliation = json['affiliation'];
//     awards = json['awards'];
//     aboutMe = json['about_me'];
//     featured = json['featured'];
//     modtime = json['modtime'];
//     subscriptionId = json['subscription_id'];
//     filename = json['filename'];
//     password = json['password'];
//     active = json['active'];
//     token = json['token'];
//     refCode = json['ref_code'];
//     signupDate = json['signup_date'];
//     cookie = json['cookie'];
//     lastLogin = json['last_login'];
//     position = json['position'];
//     instagram = json['instagram'];
//     credentials = json['credentials'];
//     bitly = json['bitly'];
//     professionId = json['profession_id'];
//     facebookId = json['facebook_id'];
//     googleId = json['google_id'];
//     verified = json['verified'];
//     pinterest = json['pinterest'];
//     nationwide = json['nationwide'];
//     cv = json['cv'];
//     workExperience = json['work_experience'];
//     repMatters = json['rep_matters'];
//     gmap = json['gmap'];
//     listingType = json['listing_type'];
//     lat = json['lat'];
//     lon = json['lon'];
//     noGeo = json['no_geo'];
//     userConsent = json['user_consent'];
//     searchDescription = json['search_description'];
//     geoState = json['geo_state'];
//     signUpOrigin = json['sign_up_origin'];
//     createNewCategories = json['create_new_categories'];
//     fullName = json['full_name'];
//     fullNameShort = json['full_name_short'];
//     countryName = json['country_name'];
//     stateName = json['state_name'];
//     name = json['name'];
//     userLocation = json['user_location'];
//     gmapZoom = json['gmap_zoom'];
//     memberSince = json['member_since'];
//     signupDateFormat = json['signup_date_format'];
//     serviceName = json['service_name'];
//     photoFile = json['photo_file'];
//     logoFile = json['logo_file'];
//     imageMainFile = json['image_main_file'];
//     coverPhoto = json['cover_photo'];
//     memberLoginLink = json['member_login_link'];
//     defaultCategoryImage = json['default_category_image'];
//     reviewCount = json['review_count'];
//     lastLoginIp = json['last_login_ip'];
//     loggedUser = json['logged_user'];
//     location = json['location'];
//     professionName = json['profession_name'];
//     profession = json['profession'];
//     allSubcategories = json['all_subcategories'];
//     clientid = json['clientid'];
//     isSubscriptionActive = json['is_subscription_active'];
//     filenameHidden = json['filename_hidden'];
//     seoPageTitleHidden = json['seo_page_title_hidden'];
//     seoPageKeywordsHidden = json['seo_page_keywords_hidden'];
//     seoPageDescriptionHidden = json['seo_page_description_hidden'];
//     seoSocialPageTitleHidden = json['seo_social_page_title_hidden'];
//     seoSocialPageDescriptionHidden = json['seo_social_page_description_hidden'];
//     service = json['service'];
//     result = json['result'];
//     faction = json['faction'];
//     save = json['save'];
//     userid = json['userid'];
//     form = json['form'];
//     formname = json['formname'];
//     sized = json['sized'];
//     tiktok = json['tiktok'];
//     bookingLink = json['booking_link'];
//     snapchat = json['snapchat'];
//     whatsapp = json['whatsapp'];
//     memberNotes = json['member_notes'];
//     contentCss = json['content_css'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['user_id'] = userId;
//     data['first_name'] = firstName;
//     data['last_name'] = lastName;
//     data['email'] = email;
//     data['company'] = company;
//     data['agent_likes'] = agentLikes;
//     data['phone_number'] = phoneNumber;
//     data['address1'] = address1;
//     data['address2'] = address2;
//     data['city'] = city;
//     data['zip_code'] = zipCode;
//     data['state_code'] = stateCode;
//     data['state_ln'] = stateLn;
//     data['country_code'] = countryCode;
//     data['country_ln'] = countryLn;
//     data['website'] = website;
//     data['twitter'] = twitter;
//     data['youtube'] = youtube;
//     data['facebook'] = facebook;
//     data['linkedin'] = linkedin;
//     data['blog'] = blog;
//     data['quote'] = quote;
//     data['experience'] = experience;
//     data['affiliation'] = affiliation;
//     data['awards'] = awards;
//     data['about_me'] = aboutMe;
//     data['featured'] = featured;
//     data['modtime'] = modtime;
//     data['subscription_id'] = subscriptionId;
//     data['filename'] = filename;
//     data['password'] = password;
//     data['active'] = active;
//     data['token'] = token;
//     data['ref_code'] = refCode;
//     data['signup_date'] = signupDate;
//     data['cookie'] = cookie;
//     data['last_login'] = lastLogin;
//     data['position'] = position;
//     data['instagram'] = instagram;
//     data['credentials'] = credentials;
//     data['bitly'] = bitly;
//     data['profession_id'] = professionId;
//     data['facebook_id'] = facebookId;
//     data['google_id'] = googleId;
//     data['verified'] = verified;
//     data['pinterest'] = pinterest;
//     data['nationwide'] = nationwide;
//     data['cv'] = cv;
//     data['work_experience'] = workExperience;
//     data['rep_matters'] = repMatters;
//     data['gmap'] = gmap;
//     data['listing_type'] = listingType;
//     data['lat'] = lat;
//     data['lon'] = lon;
//     data['no_geo'] = noGeo;
//     data['user_consent'] = userConsent;
//     data['search_description'] = searchDescription;
//     data['geo_state'] = geoState;
//     data['sign_up_origin'] = signUpOrigin;
//     data['create_new_categories'] = createNewCategories;
//     data['full_name'] = fullName;
//     data['full_name_short'] = fullNameShort;
//     data['country_name'] = countryName;
//     data['state_name'] = stateName;
//     data['name'] = name;
//     data['user_location'] = userLocation;
//     data['gmap_zoom'] = gmapZoom;
//     data['member_since'] = memberSince;
//     data['signup_date_format'] = signupDateFormat;
//     data['service_name'] = serviceName;
//     data['photo_file'] = photoFile;
//     data['logo_file'] = logoFile;
//     data['image_main_file'] = imageMainFile;
//     data['cover_photo'] = coverPhoto;
//     data['member_login_link'] = memberLoginLink;
//     data['default_category_image'] = defaultCategoryImage;
//     data['review_count'] = reviewCount;
//     data['last_login_ip'] = lastLoginIp;
//     data['logged_user'] = loggedUser;
//     data['location'] = location;
//     data['profession_name'] = professionName;
//     data['profession'] = profession;
//     data['all_subcategories'] = allSubcategories;
//     data['clientid'] = clientid;
//     data['is_subscription_active'] = isSubscriptionActive;
//     data['filename_hidden'] = filenameHidden;
//     data['seo_page_title_hidden'] = seoPageTitleHidden;
//     data['seo_page_keywords_hidden'] = seoPageKeywordsHidden;
//     data['seo_page_description_hidden'] = seoPageDescriptionHidden;
//     data['seo_social_page_title_hidden'] = seoSocialPageTitleHidden;
//     data['seo_social_page_description_hidden'] = seoSocialPageDescriptionHidden;
//     data['service'] = service;
//     data['result'] = result;
//     data['faction'] = faction;
//     data['save'] = save;
//     data['userid'] = userid;
//     data['form'] = form;
//     data['formname'] = formname;
//     data['sized'] = sized;
//     data['tiktok'] = tiktok;
//     data['booking_link'] = bookingLink;
//     data['snapchat'] = snapchat;
//     data['whatsapp'] = whatsapp;
//     data['member_notes'] = memberNotes;
//     data['content_css'] = contentCss;
//     return data;
//   }
// }

// class MembersModel1 {
//   String? status;
//   String? message;
//   Data? data;
//   String? query;

//   MembersModel1({this.status, this.message, this.data, this.query});

//   MembersModel1.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ? Data.fromJson(json['data']) : null;
//     query = json['query'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     data['message'] = message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     data['query'] = query;
//     return data;
//   }
// }

// class Data2 {
//   int? total;
//   List<Data3>? data;

//   Data2({this.total, this.data});

//   Data2.fromJson(Map<String, dynamic> json) {
//     total = json['total'];
//     if (json['data'] != null) {
//       data = <Data3>[];
//       json['data'].forEach((v) {
//         data!.add(Data3.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['total'] = total;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Data3 {
//   String? userId;
//   String? firstName;
//   String? lastName;
//   String? email;
//   String? company;
//   String? agentLikes;
//   String? phoneNumber;
//   String? address1;
//   String? address2;
//   String? city;
//   String? zipCode;
//   String? stateCode;
//   String? stateLn;
//   String? countryCode;
//   String? countryLn;
//   String? website;
//   String? twitter;
//   String? youtube;
//   String? facebook;
//   String? linkedin;
//   String? blog;
//   String? quote;
//   String? experience;
//   String? affiliation;
//   String? awards;
//   String? aboutMe;
//   String? featured;
//   String? modtime;
//   String? subscriptionId;
//   String? filename;
//   String? password;
//   String? active;
//   String? token;
//   String? refCode;
//   String? signupDate;
//   String? cookie;
//   String? lastLogin;
//   String? position;
//   String? instagram;
//   String? credentials;
//   String? bitly;
//   String? professionId;
//   String? facebookId;
//   String? googleId;
//   String? verified;
//   String? pinterest;
//   String? nationwide;
//   String? cv;
//   String? workExperience;
//   String? repMatters;
//   String? gmap;
//   String? listingType;
//   String? lat;
//   String? lon;
//   String? noGeo;
//   String? userConsent;
//   String? searchDescription;
//   String? geoState;
//   String? signUpOrigin;
//   String? createNewCategories;
//   String? fullName;
//   String? fullNameShort;
//   String? countryName;
//   String? stateName;
//   String? name;
//   String? userLocation;
//   String? gmapZoom;
//   String? memberSince;
//   String? signupDateFormat;
//   String? serviceName;
//   String? photoFile;
//   String? logoFile;
//   String? imageMainFile;
//   String? coverPhoto;
//   String? memberLoginLink;
//   bool? defaultCategoryImage;
//   Null reviewCount;
//   String? lastLoginIp;
//   String? loggedUser;
//   String? location;
//   String? professionName;
//   String? profession;
//   String? allSubcategories;
//   String? clientid;
//   String? isSubscriptionActive;
//   String? filenameHidden;
//   String? seoPageTitleHidden;
//   String? seoPageKeywordsHidden;
//   String? seoPageDescriptionHidden;
//   String? seoSocialPageTitleHidden;
//   String? seoSocialPageDescriptionHidden;
//   String? service;
//   String? result;
//   String? faction;
//   String? save;
//   String? userid;
//   String? form;
//   String? formname;
//   String? sized;
//   String? tiktok;
//   String? bookingLink;
//   String? snapchat;
//   String? whatsapp;
//   String? memberNotes;
//   String? contentCss;

//   Data3({
//     this.userId,
//     this.firstName,
//     this.lastName,
//     this.email,
//     this.company,
//     this.agentLikes,
//     this.phoneNumber,
//     this.address1,
//     this.address2,
//     this.city,
//     this.zipCode,
//     this.stateCode,
//     this.stateLn,
//     this.countryCode,
//     this.countryLn,
//     this.website,
//     this.twitter,
//     this.youtube,
//     this.facebook,
//     this.linkedin,
//     this.blog,
//     this.quote,
//     this.experience,
//     this.affiliation,
//     this.awards,
//     this.aboutMe,
//     this.featured,
//     this.modtime,
//     this.subscriptionId,
//     this.filename,
//     this.password,
//     this.active,
//     this.token,
//     this.refCode,
//     this.signupDate,
//     this.cookie,
//     this.lastLogin,
//     this.position,
//     this.instagram,
//     this.credentials,
//     this.bitly,
//     this.professionId,
//     this.facebookId,
//     this.googleId,
//     this.verified,
//     this.pinterest,
//     this.nationwide,
//     this.cv,
//     this.workExperience,
//     this.repMatters,
//     this.gmap,
//     this.listingType,
//     this.lat,
//     this.lon,
//     this.noGeo,
//     this.userConsent,
//     this.searchDescription,
//     this.geoState,
//     this.signUpOrigin,
//     this.createNewCategories,
//     this.fullName,
//     this.fullNameShort,
//     this.countryName,
//     this.stateName,
//     this.name,
//     this.userLocation,
//     this.gmapZoom,
//     this.memberSince,
//     this.signupDateFormat,
//     this.serviceName,
//     this.photoFile,
//     this.logoFile,
//     this.imageMainFile,
//     this.coverPhoto,
//     this.memberLoginLink,
//     this.defaultCategoryImage,
//     this.reviewCount,
//     this.lastLoginIp,
//     this.loggedUser,
//     this.location,
//     this.professionName,
//     this.profession,
//     this.allSubcategories,
//     this.clientid,
//     this.isSubscriptionActive,
//     this.filenameHidden,
//     this.seoPageTitleHidden,
//     this.seoPageKeywordsHidden,
//     this.seoPageDescriptionHidden,
//     this.seoSocialPageTitleHidden,
//     this.seoSocialPageDescriptionHidden,
//     this.service,
//     this.result,
//     this.faction,
//     this.save,
//     this.userid,
//     this.form,
//     this.formname,
//     this.sized,
//     this.tiktok,
//     this.bookingLink,
//     this.snapchat,
//     this.whatsapp,
//     this.memberNotes,
//     this.contentCss,
//   });

//   Data3.fromJson(Map<String, dynamic> json) {
//     userId = json['user_id'];
//     firstName = json['first_name'];
//     lastName = json['last_name'];
//     email = json['email'];
//     company = json['company'];
//     agentLikes = json['agent_likes'];
//     phoneNumber = json['phone_number'];
//     address1 = json['address1'];
//     address2 = json['address2'];
//     city = json['city'];
//     zipCode = json['zip_code'];
//     stateCode = json['state_code'];
//     stateLn = json['state_ln'];
//     countryCode = json['country_code'];
//     countryLn = json['country_ln'];
//     website = json['website'];
//     twitter = json['twitter'];
//     youtube = json['youtube'];
//     facebook = json['facebook'];
//     linkedin = json['linkedin'];
//     blog = json['blog'];
//     quote = json['quote'];
//     experience = json['experience'];
//     affiliation = json['affiliation'];
//     awards = json['awards'];
//     aboutMe = json['about_me'];
//     featured = json['featured'];
//     modtime = json['modtime'];
//     subscriptionId = json['subscription_id'];
//     filename = json['filename'];
//     password = json['password'];
//     active = json['active'];
//     token = json['token'];
//     refCode = json['ref_code'];
//     signupDate = json['signup_date'];
//     cookie = json['cookie'];
//     lastLogin = json['last_login'];
//     position = json['position'];
//     instagram = json['instagram'];
//     credentials = json['credentials'];
//     bitly = json['bitly'];
//     professionId = json['profession_id'];
//     facebookId = json['facebook_id'];
//     googleId = json['google_id'];
//     verified = json['verified'];
//     pinterest = json['pinterest'];
//     nationwide = json['nationwide'];
//     cv = json['cv'];
//     workExperience = json['work_experience'];
//     repMatters = json['rep_matters'];
//     gmap = json['gmap'];
//     listingType = json['listing_type'];
//     lat = json['lat'];
//     lon = json['lon'];
//     noGeo = json['no_geo'];
//     userConsent = json['user_consent'];
//     searchDescription = json['search_description'];
//     geoState = json['geo_state'];
//     signUpOrigin = json['sign_up_origin'];
//     createNewCategories = json['create_new_categories'];
//     fullName = json['full_name'];
//     fullNameShort = json['full_name_short'];
//     countryName = json['country_name'];
//     stateName = json['state_name'];
//     name = json['name'];
//     userLocation = json['user_location'];
//     gmapZoom = json['gmap_zoom'];
//     memberSince = json['member_since'];
//     signupDateFormat = json['signup_date_format'];
//     serviceName = json['service_name'];
//     photoFile = json['photo_file'];
//     logoFile = json['logo_file'];
//     imageMainFile = json['image_main_file'];
//     coverPhoto = json['cover_photo'];
//     memberLoginLink = json['member_login_link'];
//     defaultCategoryImage = json['default_category_image'];
//     reviewCount = json['review_count'];
//     lastLoginIp = json['last_login_ip'];
//     loggedUser = json['logged_user'];
//     location = json['location'];
//     professionName = json['profession_name'];
//     profession = json['profession'];
//     allSubcategories = json['all_subcategories'];
//     clientid = json['clientid'];
//     isSubscriptionActive = json['is_subscription_active'];
//     filenameHidden = json['filename_hidden'];
//     seoPageTitleHidden = json['seo_page_title_hidden'];
//     seoPageKeywordsHidden = json['seo_page_keywords_hidden'];
//     seoPageDescriptionHidden = json['seo_page_description_hidden'];
//     seoSocialPageTitleHidden = json['seo_social_page_title_hidden'];
//     seoSocialPageDescriptionHidden = json['seo_social_page_description_hidden'];
//     service = json['service'];
//     result = json['result'];
//     faction = json['faction'];
//     save = json['save'];
//     userid = json['userid'];
//     form = json['form'];
//     formname = json['formname'];
//     sized = json['sized'];
//     tiktok = json['tiktok'];
//     bookingLink = json['booking_link'];
//     snapchat = json['snapchat'];
//     whatsapp = json['whatsapp'];
//     memberNotes = json['member_notes'];
//     contentCss = json['content_css'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['user_id'] = userId;
//     data['first_name'] = firstName;
//     data['last_name'] = lastName;
//     data['email'] = email;
//     data['company'] = company;
//     data['agent_likes'] = agentLikes;
//     data['phone_number'] = phoneNumber;
//     data['address1'] = address1;
//     data['address2'] = address2;
//     data['city'] = city;
//     data['zip_code'] = zipCode;
//     data['state_code'] = stateCode;
//     data['state_ln'] = stateLn;
//     data['country_code'] = countryCode;
//     data['country_ln'] = countryLn;
//     data['website'] = website;
//     data['twitter'] = twitter;
//     data['youtube'] = youtube;
//     data['facebook'] = facebook;
//     data['linkedin'] = linkedin;
//     data['blog'] = blog;
//     data['quote'] = quote;
//     data['experience'] = experience;
//     data['affiliation'] = affiliation;
//     data['awards'] = awards;
//     data['about_me'] = aboutMe;
//     data['featured'] = featured;
//     data['modtime'] = modtime;
//     data['subscription_id'] = subscriptionId;
//     data['filename'] = filename;
//     data['password'] = password;
//     data['active'] = active;
//     data['token'] = token;
//     data['ref_code'] = refCode;
//     data['signup_date'] = signupDate;
//     data['cookie'] = cookie;
//     data['last_login'] = lastLogin;
//     data['position'] = position;
//     data['instagram'] = instagram;
//     data['credentials'] = credentials;
//     data['bitly'] = bitly;
//     data['profession_id'] = professionId;
//     data['facebook_id'] = facebookId;
//     data['google_id'] = googleId;
//     data['verified'] = verified;
//     data['pinterest'] = pinterest;
//     data['nationwide'] = nationwide;
//     data['cv'] = cv;
//     data['work_experience'] = workExperience;
//     data['rep_matters'] = repMatters;
//     data['gmap'] = gmap;
//     data['listing_type'] = listingType;
//     data['lat'] = lat;
//     data['lon'] = lon;
//     data['no_geo'] = noGeo;
//     data['user_consent'] = userConsent;
//     data['search_description'] = searchDescription;
//     data['geo_state'] = geoState;
//     data['sign_up_origin'] = signUpOrigin;
//     data['create_new_categories'] = createNewCategories;
//     data['full_name'] = fullName;
//     data['full_name_short'] = fullNameShort;
//     data['country_name'] = countryName;
//     data['state_name'] = stateName;
//     data['name'] = name;
//     data['user_location'] = userLocation;
//     data['gmap_zoom'] = gmapZoom;
//     data['member_since'] = memberSince;
//     data['signup_date_format'] = signupDateFormat;
//     data['service_name'] = serviceName;
//     data['photo_file'] = photoFile;
//     data['logo_file'] = logoFile;
//     data['image_main_file'] = imageMainFile;
//     data['cover_photo'] = coverPhoto;
//     data['member_login_link'] = memberLoginLink;
//     data['default_category_image'] = defaultCategoryImage;
//     data['review_count'] = reviewCount;
//     data['last_login_ip'] = lastLoginIp;
//     data['logged_user'] = loggedUser;
//     data['location'] = location;
//     data['profession_name'] = professionName;
//     data['profession'] = profession;
//     data['all_subcategories'] = allSubcategories;
//     data['clientid'] = clientid;
//     data['is_subscription_active'] = isSubscriptionActive;
//     data['filename_hidden'] = filenameHidden;
//     data['seo_page_title_hidden'] = seoPageTitleHidden;
//     data['seo_page_keywords_hidden'] = seoPageKeywordsHidden;
//     data['seo_page_description_hidden'] = seoPageDescriptionHidden;
//     data['seo_social_page_title_hidden'] = seoSocialPageTitleHidden;
//     data['seo_social_page_description_hidden'] = seoSocialPageDescriptionHidden;
//     data['service'] = service;
//     data['result'] = result;
//     data['faction'] = faction;
//     data['save'] = save;
//     data['userid'] = userid;
//     data['form'] = form;
//     data['formname'] = formname;
//     data['sized'] = sized;
//     data['tiktok'] = tiktok;
//     data['booking_link'] = bookingLink;
//     data['snapchat'] = snapchat;
//     data['whatsapp'] = whatsapp;
//     data['member_notes'] = memberNotes;
//     data['content_css'] = contentCss;
//     return data;
//   }
// }
