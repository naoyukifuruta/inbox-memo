import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inbox_memo/providers/flavor_provoder.dart';
import 'package:test/test.dart';

void main() {
  group('Flavor Provider', () {
    test('test dev', () {
      ProviderContainer container = ProviderContainer(
        overrides: [
          flavorProvider.overrideWithValue(Flavor.values.byName('dev')),
        ],
      );
      final flavor = container.read(flavorProvider);

      expect(flavor, Flavor.dev);

      container.dispose();
    });

    test('test stg', () {
      ProviderContainer container = ProviderContainer(
        overrides: [
          flavorProvider.overrideWithValue(Flavor.values.byName('stg')),
        ],
      );
      final flavor = container.read(flavorProvider);

      expect(flavor, Flavor.stg);

      container.dispose();
    });

    test('test prd', () {
      ProviderContainer container = ProviderContainer(
        overrides: [
          flavorProvider.overrideWithValue(Flavor.values.byName('prd')),
        ],
      );
      final flavor = container.read(flavorProvider);

      expect(flavor, Flavor.prd);

      container.dispose();
    });
  });
}
