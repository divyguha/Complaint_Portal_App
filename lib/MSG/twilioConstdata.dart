const String TWILIO_SMS_API_BASE_URL = 'https://api.twilio.com/2010-04-01';

class DGtwilio {
  String _sid = 'AC4a5f69af7bd4512a5eee2ee82835c758';
  String _tokan = '4815b150d841aaf935b0c0225a5d50b2';
  String _phone = '+14159961519';
  String get id {
    return _sid;
  }
  String get token {
    return _tokan;
  }
  String get number {
    return _phone;
  }
}
