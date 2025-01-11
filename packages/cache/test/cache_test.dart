import 'package:cache/cache.dart';
import 'package:test/test.dart';

void main() {
  group('Cache', () {
    test('can be instantiated', () {
      expect(CacheClient(), isNotNull);
    });

    test('can write and read a value for a given key', () {
      final cache = CacheClient();
      const key = '__key__';
      const value = '__value__';
      expect(cache.read(key: key), isNull);
      cache.write(key: key, value: value);
      expect(cache.read(key: key), equals(value));
    });
  });
}
