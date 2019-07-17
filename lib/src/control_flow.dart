import 'dart:math';
void main(){
  //1
  int x= /*new*/ Random().nextInt(150);
  print('if-else if-else');
  if(x>100){
    print('$x lagre 100');
  }else if(x>50){
    print('$x lagre 50');
  }else{
    print('$x less 50');
  }
  //2
  print("for");
  //不赋值就是null！！
  var sum=0;
  for(var i=0;i<10;i++){
    sum+=i;
  }
  print('sum=$sum');
  //3
  print("while do-while");
  //var times=10;
  int times=10;
  while(times-->5){
    print('times is $times');
  }
  //do while
  do{
    print('do:times is $times');
  }while(times-->0);
  //4
  print("continue breake");
  int numX=20;
  for(int i=0;i<numX;i++){
    if(i%2==0){
      continue;
    }else if(i%15==0){
      break;
    }else{
      print('i is $i');
    }
  }

  //5
  print("switch case");
  int val=Random().nextInt(5);
  //integer、string、或者编译时常量
  switch(val){
    case 5:
      print('val is 5');
      break;
    case 4:
      print('val is 4');
      break;
    case 3:
      print('val is 3');
      break;
    case 2:
      print('val is 2');
      break;
    case 1:
      print('val is 1');
      break;
    default:
      print('val is defalut:$val');
      break;
  }
}