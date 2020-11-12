import 'package:cloud_firestore/cloud_firestore.dart';

import '../extensions/date_extention.dart';
import '../models/entry_model.dart';
import '../services/entry_sevices.dart';

class EntryProvider {
  EntryServices _entries = EntryServices();

  List<EntryModel> entries;

  Future<List<EntryModel>> fetchEntries() async {
    var result = await _entries.getDataCollection();
    entries = result.docs
        .map((doc) => EntryModel.fromJson(doc.data(), doc.id))
        .toList();
    return entries;
  }

  Future<List<EntryModel>> fetchEntriesBetween(
      DateTime startDate, DateTime endDate) async {
    var result = await _entries.entriesBetween(
      startDate.toTimestamp(),
      endDate.toTimestamp(),
    );
    entries = result.docs
        .map((doc) => EntryModel.fromJson(doc.data(), doc.id))
        .toList();
    return entries;
  }

  Stream<QuerySnapshot> fetchEntriesAsStream() {
    return _entries.streamDataCollection();
  }

  Stream<QuerySnapshot> fetchAllEntriesAsStream(DateTime date) {
    return _entries.streamAllEntriesCollection(date.toTimestamp());
  }

  Future<EntryModel> getEntryById(String id) async {
    var doc = await _entries.getEntryById(id);
    return EntryModel.fromJson(doc.data(), doc.id);
  }

  Future removeEntry(String id) async {
    await _entries.removeEntry(id);
    return;
  }

  Future updateEntry(EntryModel data, String id) async {
    await _entries.updateEntry(data.toJson(), id);
    return;
  }

  Future addEntry(EntryModel _student) async {
    await _entries.addEntry(_student.toJson());
    return;
  }
}
