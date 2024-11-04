import 'dart:convert';

import 'package:bd_app/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService {
  String url = "http://launch32970.directoryup.com/";

  Future<List<CategoriesModel>> getAllCategories(BuildContext context) async {
    List<CategoriesModel> data = []; // Initialize as an empty list
    String i = 'api/widget/get/html/get-category';
    String api = '$url$i';

    try {
      final response = await http.get(Uri.parse(api));
      if (response.statusCode == 200) {
        List<dynamic> items = json.decode(response.body); // Decode as a list
        data = items.map((item) => CategoriesModel.fromJson(item)).toList(); // Map each item to CategoriesModel
        return data;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error in Response")),
        );
        return [];
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
      return [];
    }
  }

  Future<Map> getProjectsData(BuildContext context) async {
    String i = 'http://launch32970.directoryup.com//api/widget/get/json/display-posts-api?data_id=73';
    try {
      final response = await http.get(Uri.parse(i), headers: {
        'Api-key': 'api-value'
      });
      if (response.statusCode == 200) {
        Map items = json.decode(response.body);
        print(items);
        return items;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error in Resonse')),
        );
        return {};
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
    return {};
  }

  Future<Map> getBlogsData(BuildContext context) async {
    String i = 'http://launch32970.directoryup.com//api/widget/get/json/display-posts-api?data_id=14';
    try {
      final response = await http.get(Uri.parse(i), headers: {
        'Api-Key': 'api-value'
      });
      if (response.statusCode == 200) {
        Map items = json.decode(response.body);
        print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$items');
        return items;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error in Response.')));
        return {};
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: SnackBar(content: Text(e.toString()))));
    }
    return {};
  }

  Future<Map> getLoginData(BuildContext context, String email, String password) async {
    String i = 'http://launch32970.directoryup.com/api/widget/get/html/new-login-api?email=$email&pass=$password';
    try {
      final response = await http.get(Uri.parse(i));
      if (response.statusCode == 200) {
        Map items = json.decode(response.body);
        return items;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid Email or password!')));
        return {};
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error in Response')));
    }
    return {};
  }

  Future<Map> signupUser(BuildContext context, Map<String, dynamic> requestBody) async {
    const String apiUrl = "http://launch32970.directoryup.com/api/v2/user/create";

    // Constructing the request body

    try {
      // Sending the POST request
      var body = requestBody.entries.map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value.toString())}').join('&');

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "X-Api-Key": "3957fab92d44931ffa74f00f7e7736d8",
          // Set the content type to JSON
        },
        body: body,
      );

      // Handle the response
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map responseData = jsonDecode(response.body);

        return responseData;
      } else {
        var errorData = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${errorData['message']}')),
        );
        return {};
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $error')),
      );
      return {};
    }
  }

  Future<Map> searchMemberbyNameAndCategory(BuildContext context, String value, int profession_id) async {
    String i = 'http://launch32970.directoryup.com/api/widget/get/json/api-testing/?q=$value&profession_id=$profession_id';
    try {
      final response = await http.get(Uri.parse(i), headers: {
        'Api-Key': '123abc',
      });
      if (response.statusCode == 200) {
        Map items = json.decode(response.body); // Decode as a list
        // data = items.map((item) => MembersModel.fromJson(item)).toList(); // Map each item to CategoriesModel
        print(items);
        return items;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error in Response")),
        );
        return {};
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
      return {};
    }
  }

  Future<Map> searchMemberbyName(BuildContext context, String value) async {
    String i = 'http://launch32970.directoryup.com/api/widget/get/json/api-testing/?q=$value';
    try {
      final response = await http.get(Uri.parse(i), headers: {
        'Api-Key': '123abc',
      });
      if (response.statusCode == 200) {
        Map items = json.decode(response.body); // Decode as a list
        // data = items.map((item) => MembersModel.fromJson(item)).toList(); // Map each item to CategoriesModel
        print(items);
        return items;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error in Response")),
        );
        return {};
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
      return {};
    }
  }

  Future<Map> searchMemberbyLocation(BuildContext context, String value) async {
    String i = 'http://launch32970.directoryup.com/api/widget/get/json/api-testing/?country_ln=$value';
    try {
      final response = await http.get(Uri.parse(i), headers: {
        'Api-Key': '123abc',
      });
      if (response.statusCode == 200) {
        Map items = json.decode(response.body); // Decode as a list
        // data = items.map((item) => MembersModel.fromJson(item)).toList(); // Map each item to CategoriesModel
        print(items);
        return items;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error in Response")),
        );
        return {};
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
      return {};
    }
  }

  Future<Map> searchMembersbyCategory(BuildContext context, int profession_id) async {
    String i = 'http://launch32970.directoryup.com/api/widget/get/json/api-testing/?profession_id=$profession_id';
    try {
      final response = await http.get(Uri.parse(i), headers: {
        'Api-Key': '123abc',
      });

      if (response.statusCode == 200) {
        Map items = json.decode(response.body);
        print(",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,${response.body}");
        return items;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error in Response')));
        return {};
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      return {};
    }
  }

  Future<Map> getMembersData(BuildContext context) async {
    // List<MembersModel> data = {; }// Initialize as an empty list
    String i = 'http://launch32970.directoryup.com/api/widget/get/json/api-testing';
    // String api = '$ur

    try {
      final response = await http.get(Uri.parse(i), headers: {
        'Api-Key': '123abc',
      });
      if (response.statusCode == 200) {
        Map items = json.decode(response.body); // Decode as a list
        // data = items.map((item) => MembersModel.fromJson(item)).toList(); // Map each item to CategoriesModel
        print(items);
        return items;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error in Response")),
        );
        return {};
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
      return {};
    }
  }

  Future<Map> getMembersProfileData(BuildContext context, int user_id) async {
    // List<MembersModel> data = {; }// Initialize as an empty list
    String i = 'http://launch32970.directoryup.com/api/widget/get/json/api-testing/?user_id=$user_id';
    // String api = '$ur

    try {
      final response = await http.get(Uri.parse(i), headers: {
        'Api-Key': '123abc',
      });
      if (response.statusCode == 200) {
        Map items = json.decode(response.body); // Decode as a list
        // data = items.map((item) => MembersModel.fromJson(item)).toList(); // Map each item to CategoriesModel
        print(items);
        return items;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error in Response")),
        );
        return {};
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
      return {};
    }
  }
}
