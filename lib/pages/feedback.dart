import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';



class FeedbackComponent extends StatefulWidget {
  @override
  _FeedbackComponentState createState() => _FeedbackComponentState();
}

class _FeedbackComponentState extends State<FeedbackComponent> {
  int _selectedRating = 0;
  String _feedback = '';
  String thanks = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help us be better'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'How satisfied are you with our service?',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 1; i <= 5; i++)
                  GestureDetector(
                    onTap: () => _selectRating(i),
                    child: Icon(
                      i <= _selectedRating ? Icons.sentiment_satisfied : Icons.sentiment_satisfied_alt_outlined,
                      size: 40.0,
                      color: Colors.amber,
                    ),
                  ),
              ],
            ),
            SizedBox(height: 16.0),
            TextField(
              onChanged: (value) {
                setState(() {
                  _feedback = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Enter your feedback',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: ()async {

                  String res = await _submitFeedback( _feedback, _selectedRating);
                  setState(() {
                    print(_selectedRating);
                    print(_feedback);
                    _selectedRating = 0;
                    _feedback = '';
                    thanks = "Thank you for your feedback";
                    print(_selectedRating);
                    print(_feedback);
                  });

                 },

              child: Text('Submit'),
            ),
            SizedBox(height: 16.0),
            Text(
              thanks,
              style: TextStyle(fontSize: 18.0, color: Colors.green),

            ),
          ],
        ),
      ),
    );
  }
  void _selectRating(int rating) {
    setState(() {
      _selectedRating = rating;
    });
  }

  Future<String> _submitFeedback(String text, int value) async{

    // return item;
    // access api
    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Content-Type': 'application/json'
    };

    // deduct item from vending machine and increase income
    var url = Uri.parse('https://dvm-dq1y.onrender.com/feedback/createfb');
    var body = {'feedback':text, 'rating': value};

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    try {
      var res2 = await req.send();
    } on Exception catch (_) {
    }
    return 'succecful';

  }
}


/*
import 'package:flutter/material.dart';

class FeedbackForm extends StatefulWidget {
  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {


  void _submitFeedback() {
    // TODO: Implement the logic to submit the feedback
    print('Feedback submitted: $_feedback');
    // Reset the feedback field after submission
    setState(() {
      _feedback = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback Form'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [

            ElevatedButton(
              onPressed: _submitFeedback,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
*/