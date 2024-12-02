import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Dio POST Request Example')),
        body: Center(child: PostRequestWidget()),
      ),
    );
  }
}

class PostRequestWidget extends StatefulWidget {
  @override
  _PostRequestWidgetState createState() => _PostRequestWidgetState();
}

class _PostRequestWidgetState extends State<PostRequestWidget> {
  String _responseMessage = '';

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Define the model class for the response

  // Function to make the POST request
  Future<void> makePostRequest() async {
    // Create a Dio instance
    final dio = Dio();

    // Define the endpoint URL
    final url =
        'https://fressery.b4production.com/index.php?route=api/register';

    // Define the request payload as form data
    final formData = FormData.fromMap({
      'firstname': _firstNameController.text,
      'lastname': _lastNameController.text,
      'email': _emailController.text,
      'password': _passwordController.text,
      'Telephone': _telephoneController.text,
    });

    try {
      // Make the POST request
      final response = await dio.post(url, data: formData);
      print("response---------$response");
      // Handle the response
      if (response.statusCode == 200) {
        // Parse the response data
        final responseData = response.data;

        // Convert JSON to model
        final apiResponse = ApiResponse.fromJson(responseData);

        if (apiResponse.success == 'text_success') {
          setState(() {
            _responseMessage = 'Request was successful!';
          });
        } else {
          setState(() {
            _responseMessage = 'Request failed with response: ${responseData}';
          });
        }
      } else {
        setState(() {
          _responseMessage = 'Error: ${response.statusCode}';
        });
      }
    } catch (e) {
      // Handle any errors
      setState(() {
        _responseMessage = 'Exception: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                    label: Text(
                      "First Name",
                    ),
                    border: OutlineInputBorder()),
                controller: _firstNameController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                    label: Text("Lastname Name"), border: OutlineInputBorder()),
                controller: _lastNameController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                    label: Text("Email ID"), border: OutlineInputBorder()),
                controller: _emailController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                    label: Text("Password"), border: OutlineInputBorder()),
                controller: _passwordController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                    label: Text("Telephone"), border: OutlineInputBorder()),
                controller: _telephoneController,
              ),
            ),
            ElevatedButton(
              onPressed: makePostRequest,
              child: const Text('Make POST Request'),
            ),
            const SizedBox(height: 20),
            Text(_responseMessage),
          ],
        ),
      ),
    );
  }
}

class ApiResponse {
  final String? success;

  ApiResponse({required this.success});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      success: json['success'] as String?,
    );
  }
}