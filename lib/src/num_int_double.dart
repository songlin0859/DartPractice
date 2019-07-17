void main() {
  // num int double
  num numA = 1;
  print('numA is $numA and type is ${numA.runtimeType.toString()}');
  numA = 12.01;
  print('numA is $numA and type is ${numA.runtimeType.toString()}');

  int intA = 12;
  //A value of type 'double' can't be assigned to a variable of type 'int'.
  //intA=12.001;

  double doubleA = 12.0;
  double doubleB = 1.01;
  //doubleA = 12;
  //doubleB = 12;
  print("----------------");
  print('doubleA type ${doubleA.runtimeType.toString()}');
  print('doubleB type ${doubleB.runtimeType.toString()}');

  intA = doubleA.toInt();
  doubleB = intA.toDouble();
  print("----------------");
  print('doubleA type ${doubleA.runtimeType.toString()}');
  print('doubleB type ${doubleB.runtimeType.toString()}');
}
