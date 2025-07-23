/// Extensions for safe list operations
extension ListSafety<E> on List<E> {
  /// Checks if index is valid for this list
  @pragma('vm:prefer-inline')
  bool isValidIndex(int index) => index >= 0 && index < length;

  /// Gets element at index or null if index is invalid
  @pragma('vm:prefer-inline')
  E? elementAtOrNull(int index) => isValidIndex(index) ? this[index] : null;

  /// Safe version of removeAt()
  @pragma('vm:prefer-inline')
  void safeRemoveAt(int index) {
    if (!isValidIndex(index)) return;
    removeAt(index);
  }

  /// Safe version of operator []
  @pragma('vm:prefer-inline')
  E? getOrNull(int index) => elementAtOrNull(index);
}
