### Dart语法学习 [Dart编程语言中文网](http://dart.goodev.org/)
> 配置好Dart环境后，新建Dart工程 工程的依赖在pubspec.yaml中配置、Dart代码位于lib文件夹中
### *Hello Wrold* 个人觉得Dart比Kotlin更像Java语法
```
void main(){
  print("Hello World");
}
//对于只有一个表达式的方法，你可以选择 使用缩写语法来定义 *胖箭头*
void main()=>print("Hello World");
```
---
### Dart 语法预览
### 重要的概念
1. 所有能够使用变量引用的都是** 对象***， 每个对象都是一个类的实例。在 Dart 中 甚至连 数字、方法和 null 都是对象。所有的对象都继承于***Object*** 类。
2. 使用静态类型(例如前面示例中的 num ) 可以更清晰的表明你的意图，并且可以让静态分析工具来分析你的代码， 但这并不是强制性的。（在调试代码的时候你可能注意到 没有指定类型的变量的类型为 *dynamic*。）
3. Dart 在运行之前会先解析你的代码。你可以通过使用 类型或者编译时常量来帮助 Dart 去捕获异常以及 让代码运行的更高效。
4. Dart 支持顶级方法 (例如 main())，同时还支持在类中定义函数。 （静态函数和实例函数）。 你还可以在方法中定义方法 （嵌套方法或者局部方法）。
5. 同样，Dart 还支持顶级变量，以及 在类中定义变量（静态变量和实例变量）。 实例变量有时候被称之为域（Fields）或者属性（Properties）。
6. ***和 Java 不同的是，Dart 没有 public、 protected、 和 private 关键字。如果一个标识符以 (_) 开头，则该标识符 在库内是私有的***详情请参考： 库和可见性。
7. 标识符可以以字母或者 _ 下划线开头，后面可以是 其他字符和数字的组合。
8. 有时候 表达式 expression 和 语句 statement 是有区别的，所以这种情况我们会分别指明每种情况。
9. Dart 工具可以指出两种问题：警告和错误。 警告只是说你的代码可能有问题， 但是并不会阻止你的代码执行。 错误可以是编译时错误也可以是运行时错误。遇到编译时错误时，代码将 无法执行；运行时错误将会在运行代码的时候导致一个 异常。
### 变量
定义变量
```
void main(){
  var name= "sl";
  //A value of type 'int' can't be assigned to a variable of type 'String'
  name=23;//error！！<=====
  
  const age =23;
  final desc= "dashuaibi";
  num n = 12;
  n=12.1;
  
  String str ="this is a string";
  //动态类型
  dynamic d = "dynamic";
  d=666;
}
```
### 默认值
没有初始化的变量自动获取一个默认值为 null
### 可选的类型
在声明变量的时候，你可以选择加上具体 类型 也可用不加直接使用var
### Final and const
如果你以后不打算修改一个变量，使用 final 或者 const。 一个 final 变量只能赋值一次；一个 const 变量是编译时常量。 （Const 变量同时也是 final 变量。） 顶级的 final 变量或者类中的 final 变量在 第一次使用的时候初始化。
### 内置的类型
Dart 内置支持下面这些类型：
1. numbers
2. strings
3. booleans
4. lists (也被称之为 arrays)
5. maps
6. runes (用于在字符串中表示 Unicode 字符)
7. symbols
### Numbers（数值）
> 支持两种类型的数字 int 整数值，其取值通常位于 -253 和 253 之间。double 64-bit (双精度) 浮点数，符合 IEEE 754 标准。int 和 double 都是 num 的子类。
### Strings（字符串）
>  可以使用单引号或者双引号来创建字符串 可以在字符串中使用表达式，用法是这样的： ${expression}。可以使用 + 操作符来把多个字符串链接为一个;使用三个单引号或者双引号也可以 创建多行字符串对象;通过提供一个 r 前缀可以创建一个 “原始 raw” 字符串;
```
void main(){
  String str1= "str1";
  String str2= 'str2';
  String str3= 'str2 is $str2';
  String str4= '''str2
    str3
    str4
  ''';
  String str5= """str2
  str3
  str5
  """;
  String str6= r'str6 raw str \r\n\t';

  print(str1);
  print(str2);
  print(str3);
  print(str4);
  print(str5);
  print(str6);
}
输出：
str1
str2
str2 is str2
str2
    str3
    str4
  
str2
  str3
  str5
  
str6 raw str \r\n\t
```
### Booleans（布尔值）
> 为了代表布尔值，Dart 有一个名字为 bool 的类型。 只有两个对象是布尔类型的：true 和 false 所创建的对象， 这两个对象也都是编译时常量。
### Lists（列表）
> 在 Dart 中数组就是 List 对象。所以 通常我们都称之为 lists。
```
void main(){
  final list = [1,2,3];
  list.map((t){
    return t*t;
  }).forEach((t){
    print('t is $t');
  });
}
```
### Maps
> Map 是一个键值对相关的对象。 键和值可以是任何类型的对象。每个 键 只出现一次， 而一个值则可以出现多次。
```
void main(){
  final map = {
    "xing":"chen",
    "ming":"songlin",
    "age" :28
  };
  map.forEach((k,v){
    print('key:$k,value:$v');
  });
}
```
### Runes
> 在 Dart 中，runes 代表字符串的 UTF-32 code points。 ==不懂
---
### [Functions（方法）](http://dart.goodev.org/guides/language/language-tour#functions%E6%96%B9%E6%B3%95)
> Dart 是一个真正的面向对象语言，方法也是对象并且具有一种 类型， Function。 这意味着，方法可以赋值给变量，也可以当做其他方法的参数。 也可以把 Dart 类的实例当做方法来调用。
方法格式 *返回值 方法名（【参数列表】）{方法体}*
```
String desc(String name){
  return "desc>name:$name";
}

```

对于只有一个表达式的方法，你可以选择 使用缩写语法来定义
```
String desc(String name)=>"desc>name:$name";
```
### 可选参数
> 可选参数可以是命名参数或者基于位置的参数，但是这两种参数不能同时当做可选参数。
### 可选命名参数
```
void main(){
  //调用方法的时候，你可以使用这种形式 paramName: value 来指定命名参数
  desc(name: "Lin");
  desc(name: "Lin",age: 23);
  desc(age: 23);
}
//在定义方法的时候，使用 {param1, param2, …} 的形式来指定命名参数
void desc({String name,int age}){
  print('name:$name age:$age');
}
-----------------
name:Lin age:null
name:Lin age:23
name:null age:23
```
### 可选位置参数
> 把一些方法的参数放到 [] 中就变成可选 位置参数了
```
void main(){
  desc( "Lin");
  desc( "Lin", 23);
  //这样不行！！！！
  desc(23);
}

void desc([String name,int age]){
  print('name:$name age:$age');
}
```
### 默认参数值
> 在定义方法的时候，可以使用 = 来定义可选参数的默认值。 默认值只能是编译时常量。 如果没有提供默认值，则默认值为 null。
```
void desc({String name="n",int age=1}){
  print('name:$name age:$age'); 
}
```
### main() function（入口函数）
> 每个应用都需要有个顶级的 main() 入口方法才能执行。 main() 方法的返回值为 void 并且有个可选的 List<String> 参数。
### 一等方法对象
> 可以把方法当做参数调用另外一个方法。方法也可以赋值给一个变量;
### 匿名方法 * lambda 或者 closure 闭包*
### 返回值
> 所有的函数都返回一个值。如果没有指定返回值，则 默认把语句 return null; 作为函数的最后一个语句执行。
```
void main(){
  var f=desc(name: "Lin");
  print(f);
}
String desc({String name="n",int age=1}){
  print('name:$name age:$age');
}
-----------
name:Lin age:1
null
```


















