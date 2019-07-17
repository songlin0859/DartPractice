import 'dart:async';

void main() {
  print("now!");
  printWithDelay("Delay 1 seconds");
  printWithDelay1("").then((_) {
    print("Delay 2 seconds");
  });
}

Future<Null> printWithDelay(String message) async {
  await new Future.delayed(const Duration(seconds: 1));
  print(message);
}

Future<Null> printWithDelay1(String message) async {
  return new Future.delayed(const Duration(seconds: 2));
}
