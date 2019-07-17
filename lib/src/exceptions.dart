void main(){
  //使用 on 来指定异常类型，使用 catch 来 捕获异常对象。
  try{
    //throw FormatException("format exception");
    //throw Exception("exception");
    throw "just throw";
  } on FormatException catch(e){
    //对应一个异常类型
    print("FormatException=>"+e.toString());
  } on Exception catch(e){
    //捕获任何异常类型
    print("Exception=>"+e.toString());
  }catch(e){
    print("e:"+e.toString());
  }

  //使用 on 来指定异常类型，使用 catch 来 捕获异常对象。
  try{
    throw FormatException("format exception");
    //throw Exception("exception");
    //throw "just throw";
  } on FormatException catch(e,s){
    //对应一个异常类型
    print("FormatException=>"+e.toString()+" s:"+s.toString());
  } on Exception catch(e,s){
    //捕获任何异常类型
    print("Exception=>"+e.toString()+" s:"+s.toString());
  }catch(e,s){
    print("e:"+e.toString()+" s:"+s.toString());
  }
}