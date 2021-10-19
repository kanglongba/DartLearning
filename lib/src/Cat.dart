/**
 * 如果你的类生成的对象永远都不会更改，则可以让这些对象成为编译时常量。为此，请定义 const 构造方法并确保所有实例变量都是 final 的。
 * 对象一旦创建，就不可修改。
 */
class cat {
  //实例变量必须为final
  final String name;

  //常量构造函数，不能有函数体
  const cat(this.name);
}

void main() {
  var cat1 = const cat("pony");
  var cat2 = const cat("pony");
  var cat3 = const cat("jack");
  print('${cat1.toString()} ${cat2.toString()}');
  //identical函数检测两个引用是否一样
  print(identical(cat1, cat2)); //true
  print(identical(cat1, cat3)); //false
}
