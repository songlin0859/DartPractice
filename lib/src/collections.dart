///也许 array （或者有序集合）是所有编程语言中最常见的集合类型。 在 Dart 中数组就是 List 对象

void main() {
  //var list=[1,2,3];
  List<int> list = [1, 2, 3, 4];
  list.forEach(print);

  //var gifts = {"name": "lin", "desc": "handsome"};
  Map<String,String> maps = {"name": "lin", "desc": "handsome"};
  maps.forEach((key,value){
    print('$key:$value');
  });

  Set<int> sets= Set();
  sets.addAll([11,22,33,44,55]);
  sets.forEach(print);

  //list map赋值和取值
  print('${list[0]}');
  print('${list[1]}');
  print('${list[2]}');
  list[3]=33;
  print('${list[3]}');

  print("${maps["name"]}");
  maps["desc"]="Lin is handsome";
  print("${maps["desc"]}");
}
