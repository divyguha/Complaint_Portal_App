// messages.dart

import 'dart:convert' show json;

import 'package:http/http.dart' as http;

import './utils.dart';

const String TWILIO_SMS_API_BASE_URL = 'https://api.twilio.com/2010-04-01';

class Messages {
  String _accountSid = 'AC4a5f69af7bd4512a5eee2ee82835c758';
  String _authToken = '4815b150d841aaf935b0c0225a5d50b2';
  // String _phone = '+14159961519';

  // const Messages(this._accountSid, this._authToken);

  Future<Map> create(data) async {
    var client = http.Client();

    var url = Uri.https(
        TWILIO_SMS_API_BASE_URL, '/Accounts/$_accountSid/Messages.json');

    try {
      var response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Basic ' + toAuthCredentials(_accountSid, _authToken)
        },
        body: {'From': data['from'], 'To': data['to'], 'Body': data['body']},
      );

      return (json.decode(response.body));
    } catch (e) {
      return ({'Runtime Error': e});
    } finally {
      client.close();
    }
  }
}
