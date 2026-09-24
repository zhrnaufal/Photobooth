import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

// ── Tables ────────────────────────────────────────────────────────────────────

class Pakets extends Table {
  IntColumn get id        => integer().autoIncrement()();
  TextColumn get namaPaket  => text()();
  IntColumn get jumlahFoto  => integer()();
  IntColumn get jumlahCetak => integer()();
  IntColumn get durasiSesi  => integer()(); // seconds
  RealColumn get harga      => real()();
  TextColumn get deskripsi  => text().nullable()();
  BoolColumn get aktif      => boolean().withDefault(const Constant(true))();
}

class Frames extends Table {
  IntColumn get id        => integer().autoIncrement()();
  TextColumn get namaFrame  => text()();
  TextColumn get pathFile   => text()();
  TextColumn get kategori   => text()();
  BoolColumn get aktif      => boolean().withDefault(const Constant(true))();
}

class Sesis extends Table {
  IntColumn get id          => integer().autoIncrement()();
  TextColumn get kodeSesi   => text().unique()();
  IntColumn get idPaket     => integer()();
  IntColumn get idFrame     => integer().nullable()();
  IntColumn get tanggal     => integer()(); // epoch ms
  RealColumn get totalBayar => real()();
  TextColumn get metodeBayar  => text().withDefault(const Constant('qris'))();
  TextColumn get statusBayar  => text().withDefault(const Constant('pending'))();
  TextColumn get status       => text().withDefault(const Constant('berlangsung'))();
  TextColumn get folderCloudUrl => text().nullable()();
  TextColumn get midtransOrderId => text().nullable()();
}

class SesiFotos extends Table {
  IntColumn get id            => integer().autoIncrement()();
  IntColumn get idSesi        => integer()();
  TextColumn get pathFileLokal => text()();
  TextColumn get driveFileId  => text().nullable()();
  IntColumn get urutan        => integer()();
  BoolColumn get pendingUpload => boolean().withDefault(const Constant(true))();
}

class Pengaturans extends Table {
  TextColumn get key    => text()();
  TextColumn get value  => text()();

  @override
  Set<Column> get primaryKey => {key};
}

// ── Database ──────────────────────────────────────────────────────────────────

@DriftDatabase(tables: [Pakets, Frames, Sesis, SesiFotos, Pengaturans])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'photobooth.db');
  }

  // ── Paket ─────────────────────────────────────────────────────────────

  Stream<List<Paket>> watchAktifPakets() =>
      (select(pakets)..where((t) => t.aktif.equals(true))).watch();

  Future<Paket?> getPaketById(int id) =>
      (select(pakets)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<int> insertPaket(PaketsCompanion entry) => into(pakets).insert(entry);

  Future<bool> updatePaket(PaketsCompanion entry) => update(pakets).replace(entry);

  Future softDeletePaket(int id) =>
      (update(pakets)..where((t) => t.id.equals(id)))
          .write(const PaketsCompanion(aktif: Value(false)));

  // ── Frame ─────────────────────────────────────────────────────────────

  Stream<List<Frame>> watchAktifFrames() =>
      (select(frames)..where((t) => t.aktif.equals(true))).watch();

  Future<int> insertFrame(FramesCompanion entry) => into(frames).insert(entry);

  Future softDeleteFrame(int id) =>
      (update(frames)..where((t) => t.id.equals(id)))
          .write(const FramesCompanion(aktif: Value(false)));

  // ── Sesi ──────────────────────────────────────────────────────────────

  Stream<List<Sesi>> watchAllSesis() =>
      (select(sesis)..orderBy([(t) => OrderingTerm.desc(t.tanggal)])).watch();

  Future<Sesi?> getSesiById(int id) =>
      (select(sesis)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<Sesi?> getSesiByKode(String kode) =>
      (select(sesis)..where((t) => t.kodeSesi.equals(kode))).getSingleOrNull();

  Future<int> insertSesi(SesisCompanion entry) => into(sesis).insert(entry);

  Future updateStatusBayar(int id, String status) =>
      (update(sesis)..where((t) => t.id.equals(id)))
          .write(SesisCompanion(statusBayar: Value(status)));

  Future updateStatusSesi(int id, String status) =>
      (update(sesis)..where((t) => t.id.equals(id)))
          .write(SesisCompanion(status: Value(status)));

  Future updateFolderCloud(int id, String url) =>
      (update(sesis)..where((t) => t.id.equals(id)))
          .write(SesisCompanion(folderCloudUrl: Value(url)));

  // ── SesiFoto ──────────────────────────────────────────────────────────

  Stream<List<SesiFoto>> watchFotosBySesi(int idSesi) =>
      (select(sesiFotos)
        ..where((t) => t.idSesi.equals(idSesi))
        ..orderBy([(t) => OrderingTerm.asc(t.urutan)]))
          .watch();

  Future<List<SesiFoto>> getFotosBySesi(int idSesi) =>
      (select(sesiFotos)
        ..where((t) => t.idSesi.equals(idSesi))
        ..orderBy([(t) => OrderingTerm.asc(t.urutan)]))
          .get();

  Future<List<SesiFoto>> getPendingUpload() =>
      (select(sesiFotos)..where((t) => t.pendingUpload.equals(true))).get();

  Future<int> insertSesiFoto(SesiFotosCompanion entry) =>
      into(sesiFotos).insert(entry);

  Future markUploaded(int id, String driveId) =>
      (update(sesiFotos)..where((t) => t.id.equals(id))).write(
          SesiFotosCompanion(driveFileId: Value(driveId), pendingUpload: const Value(false)));

  // ── Pengaturan ────────────────────────────────────────────────────────

  Future<String?> getSetting(String key) async {
    final row = await (select(pengaturans)..where((t) => t.key.equals(key)))
        .getSingleOrNull();
    return row?.value;
  }

  Future setSetting(String key, String value) =>
      into(pengaturans).insertOnConflictUpdate(
          PengaturansCompanion(key: Value(key), value: Value(value)));

  Stream<List<Pengaturan>> watchAllSettings() => select(pengaturans).watch();
}

// ── Setting keys ──────────────────────────────────────────────────────────────

class SettingKeys {
  static const namaStudio        = 'nama_studio';
  static const midtransServerKey = 'midtrans_server_key';
  static const midtransEnv       = 'midtrans_env';
  static const driveFolderRootId = 'google_drive_folder_root_id';
  static const galleryBaseUrl    = 'gallery_page_base_url';
  static const adminPin          = 'admin_pin';
  static const driveRefreshToken = 'drive_refresh_token';
  static const googleEmail       = 'google_account_email';
}

// Extra helpers used by screens
extension AppDatabaseHelpers on AppDatabase {
  Future updateSesiFrame(int id, int frameId) =>
      (update(sesis)..where((t) => t.id.equals(id)))
          .write(SesisCompanion(idFrame: Value(frameId)));
}
