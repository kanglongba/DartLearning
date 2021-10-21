/// 参考文章：[异步编程：使用 Future 和 async-await](https://dart.cn/codelabs/async-await)

// Future要素：
// 1.A Future<T> instance produces a value of type T.
// 2.If a future doesn’t produce a usable value, then the future’s type is Future<void>.
// 3.A future can be in one of two states: uncompleted or completed.
// 4.When you call a function that returns a future, the function queues up work to be done and returns an uncompleted
// future.（当调用一个返回Future的函数时，函数会把把任务塞到队列[Dart的单线程模型]里，并且立即返回一个未完成的Future对象。）
// 5.When a future’s operation finishes, the future completes with a value or with an error.

// Completing wit a usable value
Future<String> fetchUserOrder1() =>
    // Imagine that this function is more complex and slow.
    Future.delayed(
      const Duration(seconds: 2),
      () => 'Large Latte',
    );

// Completing wit a unusable value
Future<void> fetchUserOrder2() {
  // Imagine that this function is fetching user info from another service or database.
  return Future.delayed(const Duration(seconds: 2), () => print('Large Latte'));
}

// Completing with an error
Future<void> fetchUserOrder3() {
// Imagine that this function is fetching user info but encounters a bug
  return Future.delayed(const Duration(seconds: 2),
      () => throw Exception('Logout failed: user ID is invalid'));
}

// async-await
// Remember these two basic guidelines when using async and await:
// 1.To define an async function, add async before the function body:
// 2.The await keyword works only in async functions.

// 要素：
// 1.async: You can use the async keyword before a function’s body to mark it as asynchronous.
// 2.async function: An async function is a function labeled with the async keyword.
// 3.await: You can use the await keyword to get the completed result of an asynchronous expression. The await keyword
// only works within an async function.

String createOrderMessage() {
  var order = fetchUserOrder1();
  return 'Your order is: $order';
}

Future<String> createOrderMessage1() async {
  //async关键字让直接让函数变成了异步函数，并且函数返回值自动变成了 Future<T>
  print('Awaiting user order...');
  var order = await fetchUserOrder1();
  print('Fetching ...'); //await阻塞了执行，会等fetchUserOrder1()完成再打印
  return 'Your order is: $order';
}

Future<String> createOrderMessage2() async {
  print('Awaiting user order...');
  var order = fetchUserOrder1();
  print('Fetching ...'); //立即打印
  return 'Your order is: $order';
}

// Handle Error
// 处理错误
Future<void> printOrderMessage() async {
  try {
    print('Awaiting user order...');
    var order = await fetchUserOrder4();
    print(order);
  } catch (err) {
    print('Caught error: $err');
  }
}

Future<String> fetchUserOrder4() {
  // Imagine that this function is more complex.
  var str = Future.delayed(
      const Duration(seconds: 4), () => throw 'Cannot locate user order');
  return str;
}

void main() {
  print('Fetching user order...');
  // print(createOrderMessage1());
  printOrderMessage();
  print('Receive user order...');
}
