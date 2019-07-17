//胖箭头 【只有一个语句的方法可以使用缩写】
//void main()=>print("=> func");
//所有的函数都返回一个值。如果没有指定返回值，则 默认把语句 return null; 作为函数的最后一个语句执行。
void main(){
  helloDart();
  sayHi("SL");
  print("吃${doubleStr("饭")}");
  optionalNameParameters("Lin");
  optionalNameParameters("Lin",age: 28);
  optionalPositionParameters("Lin");
  optionalPositionParameters("Lin",27);
  //把方法当做参数调用另外一个方法
  var map=[5,6,7];
  map.forEach(print);
}

void helloDart(){
  print('Hello Dart!');
}

void sayHi(String hi){
  print('hi $hi');
}

String doubleStr(String str){
  return str+str;
}

//方法可以有两种类型的参数：必需的和可选的。
// 必需的参数在参数列表前面， 后面是可选参数。
//可选命名参数 && 可选位置参数
//可选命名参数
void optionalNameParameters(String name,{int age=-1}){
  print('Name:name: $name age: ${age ?? 0}');
}
//可选位置参数
void optionalPositionParameters(String name,[int age=-2]){
  print('Position:name: $name age: ${age ?? 0}');
}