//定义一个和类名字一样的方法就定义了一个构造函数
class Point {
  num x;
  num y;

  /*Point(num x, num y) {
    this.x = x;
    this.y = y;
  }*/
  Point(this.x,this.y);
  //命名构造函数
 /* Point.fromJson(Map json) {
    x = json['x'];
    y = json['y'];
  }*/
  Point.fromJson(Map json):this(json['x'],json['y']);
}


class ImmutablePoint {
  final num x;
  final num y;
  const ImmutablePoint(this.x, this.y);
  static final ImmutablePoint origin =
  const ImmutablePoint(0, 0);
}

void main(){
  //如果你没有定义构造函数，则会有个默认构造函数。
  // 默认构造函数没有参数，并且会调用超类的 没有参数的构造函数。
  //Point point=Point();
  //构造函数不会继承 子类不会继承超类的构造函数。 子类如果没有定义构造函数，则只有一个默认构造函数 （没有名字没有参数）。

  //命名构造函数
  //使用命名构造函数可以为一个类实现多个构造函数， 或者使用命名构造函数来更清晰的表明你的意图
  var point=Point.fromJson({"x":10,"y":11});
  print('x:${point.x} y:${point.y}');

  //var y = ImmutablePoint.origin.y;
}