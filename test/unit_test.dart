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
      entry.updateAsMonthly(2);
      expect(entry.detailedReason, "December,\ January");
    });
    test('equipment test', () {
      entry.equipment();
      expect(entry.detailedReason, "Gloves, Kickpad");
    });
  });
}
