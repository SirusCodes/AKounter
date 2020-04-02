import 'package:akounter/models/entry_model.dart';
import 'package:akounter/services/entry_sevices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EntryProvider {
  EntryServices _entries = EntryServices();

  List<EntryModel> entries;

  Future<List<EntryModel>> fetchEntries() async {
    var result = await _entries.getDataCollection();
    entries = result.documents
        .map((doc) => EntryModel.fromJson(doc.data, doc.documentID))
        .toList();
    return entries;
  }

  Stream<QuerySnapshot> fetchEntriesAsStream() {
    return _entries.streamDataCollection();
  }

  Future<EntryModel> getEntryById(String id) async {
    var doc = await _entries.getEntryById(id);
    return EntryModel.fromJson(doc.data, doc.documentID);
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
