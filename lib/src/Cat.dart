/**
 * 常量构造函数:如果类生成的对象都是不会改变的，那么可以在声明时就将其变为编译时常量。
 */
class cat {
  //实例变量必须为final
  final String name;

  //常量构造函数，不能由函数体
  const cat(this.name);
}

void main() {
  var cat1 = const cat("pony");
  var cat2 = const cat("pony");
  print('${cat1.toString()} ${cat2.toString()}');
  //identical函数检测两个引用是否一样
  print(identical(cat1, cat2));
}
