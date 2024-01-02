extension ListNullExtension<T> on List<T>? {
  bool get isNullOrEmpty {
    if (this == null) {
      return true;
    } else {
      if (this!.isEmpty) {
        return true;
      } else {
        return false;
      }
    }
  }

  Iterable<E>? mapOrNull<E>(E Function(T e) toElement) {
    return (this ?? []).isEmpty ? null : this!.map(toElement);
  }
}

extension Iterables<E> on Iterable<E> {
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) => fold(
      <K, List<E>>{},
      (Map<K, List<E>> map, E element) =>
          map..putIfAbsent(keyFunction(element), () => <E>[]).add(element));
}

extension Unique<E, Id> on List<E> {
  List<E> unique({Id Function(E element)? where, bool modifyOriginal = false}) {
    final ids = <dynamic>{};
    var list = modifyOriginal ? this : List<E>.from(this);
    list.retainWhere((x) => ids.add(where != null ? where(x) : x as Id));
    return list;
  }
}
