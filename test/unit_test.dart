import 'package:akounter/locator.dart';
import 'package:akounter/provider/add_entry_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setup();
  final entry = locator<AddEntryProvider>();

  group('add entry tests', () {
    test("to test examination subtotal", () {
      entry.updateAsExam(5);
      expect(entry.getSubtotal, 900);
    });
    test('months tests', () {
      entry.updateAsMonthly();
      expect(entry.getDetailedReason, "December,\ January");
    });
    test('equipment test', () {
      entry.equipment();
      expect(entry.getDetailedReason, "Gloves, Kickpad");
    });
  });
}
