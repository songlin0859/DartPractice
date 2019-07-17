import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async{
  var response = await getHistory();
  String history = response.body;
  print(history);

  var weather = await getWeather();
  //print(weather.body);
  var decode = await json.decode(weather.body);
  print(decode["city"]);

  var data = decode["data"];
  //print(data);
  //data's type is List<dynamic>
  //print(data.runtimeType.toString());

  var data0 = data[0];

  print(data0["date"]);
  print(data0["tem"]);
  print(data0["air_tips"]);
}
///获取发过干货日期接口
Future<http.Response> getHistory() async {
  return await http.get("http://gank.io/api/day/history");
}

Future<http.Response> getWeather() async{
  String baseUrl="https://www.tianqiapi.com/api/?version=v1&city=九江";
  return http.get(baseUrl);
}
