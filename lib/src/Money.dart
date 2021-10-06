class Money {
  int value = 0;

  Money(this.value);

  /**
   * 运算符重载
   */
  Money operator +(Money other) {
    return Money(this.value + other.value);
  }

  Money operator -(Money other) {
    return Money(this.value - other.value);
  }

  bool operator >(Money other) {
    return this.value > other.value;
  }
}
