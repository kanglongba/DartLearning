/**
 * Dart是一个面向对象的语言，支持单继承和mixin继承。定义类的关键字是class。
 * 如果定义类的时候没有提供构造方法，系统会自动生成一个无参数的构造方法。
 * 如果提供了有参数的构造方法，无参构造方法会失效，除非我们自己定义了无参构造。
 * 类由构造函数、实例变量和实例方法、类变量和类方法构成。没有析构函数。
 * 枚举类型是一种特殊的类。
 */
class Person {
  //静态变量
  static String COUNTRY = "china";

  /**
   * Dart中没有public private protected等访问修饰符，变量和方法默认都是public的
   */
  var name;
  int age = 10;

  /**
   * 变量前面加'_'，是私有变量
   */
  int _height = 100;

  /**
   * 如果没有声明构造函数，那么 Dart 会自动生成一个无参数的构造函数并且该构造函数会调用其父类的无参数构造方法。
   *
   * 主构造函数。
   * 一个类中只能有一个主构造函数。
   * 这个是简略写法，相当于下面被注释的构造函数
   *
   */
  Person(this.name) {
    // Initialization code goes here.
    // 如果没有初始化代码，也可以直接省略函数体
  }

  // Person(String name) {
  //   this.name = name;
  // }

  /**
   * 命名构造函数。
   * 一个类中可以有多个命名构造函数。
   *
   * 构造函数是不能被继承的，这将意味着子类不能继承父类的命名构造函数，如果你想在子类中提供一个与父类命名构造函数名字
   * 一样的命名构造函数，则需要在子类中显式地声明。
   */
  Person.info(String name, int age) {
    this.name = name;
    this.age = age;
  }

  /**
   * 重定向构造函数
   * 有时候类中的构造函数会调用类中其它的构造函数，该重定向构造函数没有函数体，只需在函数签名后使用（:）指定需要重定向到
   * 的其它构造函数即可.
   */
  Person.simple(String name) : this(name);

  /**
   * 工厂构造函数
   * 使用 factory 关键字标识类的构造函数将会令该构造函数变为工厂构造函数，这将意味着使用该构造函数构造类的实例时并非总
   * 是会返回新的实例对象。
   */
  factory Person.of(int age) {
    return Person.info('pony', age);
  }

  /**
   * 初始化参数列表列表
   * 有时，当你在实现构造函数时，您需要在构造函数体执行之前进行一些初始化。例如，final 修饰的字段必须在构造函数体执行之前赋值。在初始化列表
   * 中执行此操作，该列表位于构造函数的签名与其函数体之间。
   * 1.可插入赋值语句，对参数进行初始化，此时无法访问 this
   * 2.可插入断言
   * 3.插入 super 语句调用父类构造函数，这个语句必须放到最后面
   * 4.可插入 this()重定向到本类的其他构造函数，但不可与其他语句混用
   *
   * 默认情况下，构造函数内部会根据继承关系有个调用顺序：
   * 1.初始化列表
   * 2.父类无参构造函数
   * 3.主类无参构造函数
   */
  Person.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        //函数签名之后，函数体之前，就是初始化参数列表
        age = json['age'] {
    //本例中，name和age就是初始化参数列表
    print('In Person.fromJson(): ($name, $age)');
  }

  String greet() => 'I am $name';

  /**
   * 函数的返回类型，可以省略。类似Kotlin。
   */
  sayHello() => "hello";

  printName() {
    print('the name is $name');
  }

  /**
   * 方法前面加'_'，是私有方法
   */
  // ignore: not call
  _printHeight() {
    print('身高=$_height');
  }

  /**
   * get函数
   * height123的名称随意，不过推荐和私有变量名一致
   */
  int get height123 {
    return _height;
  }

  /**
   * set函数
   * height789的名称随意，不过推荐和私有变量名一致
   */
  set height789(int value) {
    this._height = value;
  }

  /**
   * 静态方法
   */
  static printCountry() {
    print(COUNTRY);
  }
}
