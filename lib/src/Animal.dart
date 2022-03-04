/// 继承（extends）、混入（with）、实现（implements）
/// 1.都能继承 成员变量 和 成员方法
/// 2.私有的（以"_"开头）变量和方法无法继承
/// 3.实现（implements）必须重写 成员方法 和 成员变量
/// 4.继承（extends）、混入（with）可以重写，也可以不重写
///
/// 参考：Horse、Dog
class Animal {

  /// 私有变量和私有方法不能被继承（extends）
  int _weight = 10;

  void eat() {
    print('eat');
  }
}
