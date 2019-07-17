import 'dart:async';
import 'dart:io';
import 'dart:convert';

void main() async{
  /*print("now!");
  printWithDelay("Delay 1 seconds");
  printWithDelay1("").then((_) {
    print("Delay 2 seconds");
  });*/
  getOkHttp();
}

void getOkHttp() async{
  var httpClient=HttpClient();
  var uri=Uri.parse("https://publicobject.com/helloworld.txt");
  var request=await httpClient.getUrl(uri);
  var response = await request.close();
  var transform = await response.transform(Utf8Decoder());
  transform.forEach(print);
}

Future<Null> printWithDelay(String message) async {
  await new Future.delayed(const Duration(seconds: 1));
  print(message);
}

Future<Null> printWithDelay1(String message) async {
  return new Future.delayed(const Duration(seconds: 2));
}
