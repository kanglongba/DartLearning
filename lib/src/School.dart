import 'dart:isolate'; //引用dart内置库
import 'package:date_format/date_format.dart';
import 'package:meta/meta.dart'; //引用公共包
import 'package:intl/intl.dart' deferred as hello; //延迟加载包，允许应用在需要时再去加载代码库
import 'package:intl/number_symbols.dart' show NumberSymbols; //只导入number_symbols中的NumberSymbols
//import 'package:intl/number_symbols.dart' hide NumberSymbols; //导入number_symbols中除NumberSymbols以外的所有

import 'Person.dart'; //引用本地代码库
import 'Boy.dart' as B; //为导入的代码库指定前缀。这样做是为了解决导入的两个代码库有冲突的标识符的问题。

/**
 * import 的唯一参数是用于指定代码库的 URI
 * 对于 Dart 内置的库，使用 dart:xxx 的形式
 * 对于其它的库，可以使用一个文件系统路径或者以 package:xxx 的形式
 * package:xxx 指定的库通过包管理器（比如 pub 工具）来提供
 */
class School {
  Person? teacher;
  B.Boy? boy;

  School(this.teacher);

  /**
   * 引入meta包，使用 @required 注解 标识必要参数
   *
   * 延迟加载包：
   * 1.为了减少应用的初始化时间。
   * 2.处理 A/B 测试，比如测试各种算法的不同实现。
   * 3.加载很少会使用到的功能，比如可选的屏幕和对话框
   *
   * 注意：
   * 1.延迟加载的代码库中的常量需要在代码库被加载的时候才会导入，未加载时是不会导入的。
   * 2.导入文件的时候无法使用延迟加载库中的类型。如果你需要使用类型，则考虑把接口类型转移到另一个库中然后让两个库都分别导入这个接口库。
   */
  void holiday({int year = 2021, required int month, @required int? day}) {
    String date =
        formatDate(DateTime(year, month, day!), [yyyy, '-', mm, '-', dd]);
    print('holiday $date');

    // ?? 操作符，表示 boy 为空时才赋值，否则不赋值。
    boy ??= B.Boy('pony', 'zju');

    //下面代码运行会抛出异常：Deferred library hello was not loaded.
    //hello.NumberFormat.compact(locale: hello.Intl.defaultLocale);
  }
}
