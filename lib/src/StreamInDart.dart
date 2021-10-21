import 'dart:async';

/// 参考文章:
/// 1.[异步编程：使用 stream](https://dart.cn/tutorials/language/streams)
/// 2.[在 Dart 里使用 Stream](https://dart.cn/articles/libraries/creating-streams)

// Future 和 Stream 类是 Dart 异步编程的核心。

// Future 表示一个不会立即完成的计算过程。与普通函数直接返回结果不同的是异步函数返回一个将会包含结果的 Future。该 Future 会在结果准备好时
// 通知调用者。

// Stream 是一系列异步事件的序列。其类似于一个异步的 Iterable，不同的是当你向 Iterable 获取下一个事件时它会立即给你，但是 Stream 则不会
// 立即给你而是在它准备好时告诉你。

// 像使用 for 循环 迭代一个 Iterable 一样，我们可以使用 异步 for 循环 （通常我们直接称之为 await for）来迭代 Stream 中的事件
Future<int> sumStream(Stream<int> stream) async {
  var sum = 0;
  await for (final value in stream) {
    // 当一次循环体结束时，函数会暂停直到下一个事件到达或 Stream 完成。
    sum += value;
  }
  return sum;
}

// 使用 async* 函数生成一个简单的整型 Stream
Stream<int> countStream(int to) async* {
  for (int i = 1; i <= to; i++) {
    yield i; // 向Stream中发射数据
  }
}

// 处理错误
Future<int> sumStream1(Stream<int> stream) async {
  var sum = 0;
  try {
    await for (final value in stream) {
      // 收到异常后，循环就终止，并抛出异常
      sum += value;
    }
  } catch (e) {
    return -1;
  }
  return sum;
}

// 抛出错误
Stream<int> countStream1(int to) async* {
  for (int i = 1; i <= to; i++) {
    if (i == 4) {
      throw Exception('Intentional exception');
    } else {
      yield i;
    }
  }
}

/// 创建 Stream

// 转换现有的Stream
Stream<int> counterStream =
    Stream<int>.periodic(const Duration(seconds: 1), (x) => x).take(15);

Stream<String> transformStream() {
  return counterStream.map((event) => event.toString()); //很简单，和RxJava一样
}

// 从零创建
Stream<int> timedCounter1(Duration interval, [int? maxCount]) async* {
  int i = 0;
  while (true) {
    await Future.delayed(interval);
    yield i++;
    if (i == maxCount) break;
  }
}

// 使用 StreamController
Stream<int> timedCounter2(Duration interval, [int? maxCount]) {
  late StreamController<int> controller;
  Timer? timer;
  int counter = 0;

  void tick(_) {
    counter++;
    controller.add(counter); // Ask stream to send counter values as event.
    if (counter == maxCount) {
      timer?.cancel();
      controller.close(); // Ask stream to shut down and tell listeners.
    }
  }

  void startTimer() {
    timer = Timer.periodic(interval, tick);
  }

  void stopTimer() {
    timer?.cancel();
    timer = null;
  }

  controller = StreamController<int>(
      onListen: startTimer,
      onPause: stopTimer,
      onResume: startTimer,
      onCancel: stopTimer);

  return controller.stream;
}

// 订阅Stream
void listenWithPause() {
  var counterStream = timedCounter2(const Duration(seconds: 1), 15);
  late StreamSubscription<int> subscription;

  subscription = counterStream.listen((int counter) {
    print(counter); // Print an integer every second.
    if (counter == 5) {
      // After 5 ticks, pause for five seconds, then resume.
      subscription.pause(Future.delayed(const Duration(seconds: 5)));
    }
  });
}

Future<void> main() async {
  var stream = countStream(10);
  var sum = await sumStream(stream);
  print(sum); // 55
}
