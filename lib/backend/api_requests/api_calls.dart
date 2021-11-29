import 'api_manager.dart';

Future<dynamic> testCall() {
  return ApiManager.instance.makeApiCall(
    callName: 'test',
    apiUrl:
        'https://firestore.googleapis.com/v1/projects/brw-crm-ff/databases/(default)/documents/orderItems?key=AIzaSyDQqHavu1vqT5kNSl0GGscQCprSUhozhi8',
    callType: ApiCallType.GET,
    headers: {},
    params: {},
    returnResponse: true,
  );
}

Future<dynamic> testGetListCall({
  String refString = '',
}) {
  return ApiManager.instance.makeApiCall(
    callName: 'test get list',
    apiUrl:
        'https://firestore.googleapis.com/v1/projects/brw-crm-ff/databases/(default)/documents/{refString}',
    callType: ApiCallType.GET,
    headers: {
      'key': 'AIzaSyDQqHavu1vqT5kNSl0GGscQCprSUhozhi8',
    },
    params: {
      'refString': refString,
    },
    returnResponse: true,
  );
}
