import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TennisRoomRecord extends FirestoreRecord {
  TennisRoomRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "RoomID" field.
  String? _roomID;
  String get roomID => _roomID ?? '';
  bool hasRoomID() => _roomID != null;

  // "RoomName" field.
  String? _roomName;
  String get roomName => _roomName ?? '';
  bool hasRoomName() => _roomName != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  void _initializeFields() {
    _roomID = snapshotData['RoomID'] as String?;
    _roomName = snapshotData['RoomName'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _phoneNumber = snapshotData['phone_number'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('TennisRoom');

  static Stream<TennisRoomRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TennisRoomRecord.fromSnapshot(s));

  static Future<TennisRoomRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TennisRoomRecord.fromSnapshot(s));

  static TennisRoomRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TennisRoomRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TennisRoomRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TennisRoomRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TennisRoomRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TennisRoomRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTennisRoomRecordData({
  String? roomID,
  String? roomName,
  DateTime? createdTime,
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  String? phoneNumber,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'RoomID': roomID,
      'RoomName': roomName,
      'created_time': createdTime,
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'phone_number': phoneNumber,
    }.withoutNulls,
  );

  return firestoreData;
}

class TennisRoomRecordDocumentEquality implements Equality<TennisRoomRecord> {
  const TennisRoomRecordDocumentEquality();

  @override
  bool equals(TennisRoomRecord? e1, TennisRoomRecord? e2) {
    return e1?.roomID == e2?.roomID &&
        e1?.roomName == e2?.roomName &&
        e1?.createdTime == e2?.createdTime &&
        e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.phoneNumber == e2?.phoneNumber;
  }

  @override
  int hash(TennisRoomRecord? e) => const ListEquality().hash([
        e?.roomID,
        e?.roomName,
        e?.createdTime,
        e?.email,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.phoneNumber
      ]);

  @override
  bool isValidKey(Object? o) => o is TennisRoomRecord;
}
