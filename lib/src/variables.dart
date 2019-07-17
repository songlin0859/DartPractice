void main() {
  //动态类型
  dynamic dVar = "dynamic String";
  print('dVar is $dVar->' + dVar.runtimeType.toString());
  dVar = 2019;
  print('dVar is $dVar->' + dVar.runtimeType.toString());

  var vVar="vVar";
  print("vVar is $vVar");
  //报错
  //vVar=23;

  final fVar="233333";
  print('fVar is $fVar');
  //报错
  //fVar=23333;

  //Members can't be declared to be both 'const' and 'final'.
  const cfVar="23333";
  print('cfVar is $cfVar');
  //报错
  //cfVar="33333"
}
