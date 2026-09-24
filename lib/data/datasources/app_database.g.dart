// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PaketsTable extends Pakets with TableInfo<$PaketsTable, Paket> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaketsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _namaPaketMeta =
      const VerificationMeta('namaPaket');
  @override
  late final GeneratedColumn<String> namaPaket = GeneratedColumn<String>(
      'nama_paket', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _jumlahFotoMeta =
      const VerificationMeta('jumlahFoto');
  @override
  late final GeneratedColumn<int> jumlahFoto = GeneratedColumn<int>(
      'jumlah_foto', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _jumlahCetakMeta =
      const VerificationMeta('jumlahCetak');
  @override
  late final GeneratedColumn<int> jumlahCetak = GeneratedColumn<int>(
      'jumlah_cetak', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _durasiSesiMeta =
      const VerificationMeta('durasiSesi');
  @override
  late final GeneratedColumn<int> durasiSesi = GeneratedColumn<int>(
      'durasi_sesi', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _hargaMeta = const VerificationMeta('harga');
  @override
  late final GeneratedColumn<double> harga = GeneratedColumn<double>(
      'harga', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _deskripsiMeta =
      const VerificationMeta('deskripsi');
  @override
  late final GeneratedColumn<String> deskripsi = GeneratedColumn<String>(
      'deskripsi', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _aktifMeta = const VerificationMeta('aktif');
  @override
  late final GeneratedColumn<bool> aktif = GeneratedColumn<bool>(
      'aktif', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("aktif" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        namaPaket,
        jumlahFoto,
        jumlahCetak,
        durasiSesi,
        harga,
        deskripsi,
        aktif
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pakets';
  @override
  VerificationContext validateIntegrity(Insertable<Paket> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nama_paket')) {
      context.handle(_namaPaketMeta,
          namaPaket.isAcceptableOrUnknown(data['nama_paket']!, _namaPaketMeta));
    } else if (isInserting) {
      context.missing(_namaPaketMeta);
    }
    if (data.containsKey('jumlah_foto')) {
      context.handle(
          _jumlahFotoMeta,
          jumlahFoto.isAcceptableOrUnknown(
              data['jumlah_foto']!, _jumlahFotoMeta));
    } else if (isInserting) {
      context.missing(_jumlahFotoMeta);
    }
    if (data.containsKey('jumlah_cetak')) {
      context.handle(
          _jumlahCetakMeta,
          jumlahCetak.isAcceptableOrUnknown(
              data['jumlah_cetak']!, _jumlahCetakMeta));
    } else if (isInserting) {
      context.missing(_jumlahCetakMeta);
    }
    if (data.containsKey('durasi_sesi')) {
      context.handle(
          _durasiSesiMeta,
          durasiSesi.isAcceptableOrUnknown(
              data['durasi_sesi']!, _durasiSesiMeta));
    } else if (isInserting) {
      context.missing(_durasiSesiMeta);
    }
    if (data.containsKey('harga')) {
      context.handle(
          _hargaMeta, harga.isAcceptableOrUnknown(data['harga']!, _hargaMeta));
    } else if (isInserting) {
      context.missing(_hargaMeta);
    }
    if (data.containsKey('deskripsi')) {
      context.handle(_deskripsiMeta,
          deskripsi.isAcceptableOrUnknown(data['deskripsi']!, _deskripsiMeta));
    }
    if (data.containsKey('aktif')) {
      context.handle(
          _aktifMeta, aktif.isAcceptableOrUnknown(data['aktif']!, _aktifMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Paket map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Paket(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      namaPaket: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nama_paket'])!,
      jumlahFoto: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}jumlah_foto'])!,
      jumlahCetak: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}jumlah_cetak'])!,
      durasiSesi: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}durasi_sesi'])!,
      harga: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}harga'])!,
      deskripsi: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}deskripsi']),
      aktif: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}aktif'])!,
    );
  }

  @override
  $PaketsTable createAlias(String alias) {
    return $PaketsTable(attachedDatabase, alias);
  }
}

class Paket extends DataClass implements Insertable<Paket> {
  final int id;
  final String namaPaket;
  final int jumlahFoto;
  final int jumlahCetak;
  final int durasiSesi;
  final double harga;
  final String? deskripsi;
  final bool aktif;
  const Paket(
      {required this.id,
      required this.namaPaket,
      required this.jumlahFoto,
      required this.jumlahCetak,
      required this.durasiSesi,
      required this.harga,
      this.deskripsi,
      required this.aktif});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nama_paket'] = Variable<String>(namaPaket);
    map['jumlah_foto'] = Variable<int>(jumlahFoto);
    map['jumlah_cetak'] = Variable<int>(jumlahCetak);
    map['durasi_sesi'] = Variable<int>(durasiSesi);
    map['harga'] = Variable<double>(harga);
    if (!nullToAbsent || deskripsi != null) {
      map['deskripsi'] = Variable<String>(deskripsi);
    }
    map['aktif'] = Variable<bool>(aktif);
    return map;
  }

  PaketsCompanion toCompanion(bool nullToAbsent) {
    return PaketsCompanion(
      id: Value(id),
      namaPaket: Value(namaPaket),
      jumlahFoto: Value(jumlahFoto),
      jumlahCetak: Value(jumlahCetak),
      durasiSesi: Value(durasiSesi),
      harga: Value(harga),
      deskripsi: deskripsi == null && nullToAbsent
          ? const Value.absent()
          : Value(deskripsi),
      aktif: Value(aktif),
    );
  }

  factory Paket.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Paket(
      id: serializer.fromJson<int>(json['id']),
      namaPaket: serializer.fromJson<String>(json['namaPaket']),
      jumlahFoto: serializer.fromJson<int>(json['jumlahFoto']),
      jumlahCetak: serializer.fromJson<int>(json['jumlahCetak']),
      durasiSesi: serializer.fromJson<int>(json['durasiSesi']),
      harga: serializer.fromJson<double>(json['harga']),
      deskripsi: serializer.fromJson<String?>(json['deskripsi']),
      aktif: serializer.fromJson<bool>(json['aktif']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'namaPaket': serializer.toJson<String>(namaPaket),
      'jumlahFoto': serializer.toJson<int>(jumlahFoto),
      'jumlahCetak': serializer.toJson<int>(jumlahCetak),
      'durasiSesi': serializer.toJson<int>(durasiSesi),
      'harga': serializer.toJson<double>(harga),
      'deskripsi': serializer.toJson<String?>(deskripsi),
      'aktif': serializer.toJson<bool>(aktif),
    };
  }

  Paket copyWith(
          {int? id,
          String? namaPaket,
          int? jumlahFoto,
          int? jumlahCetak,
          int? durasiSesi,
          double? harga,
          Value<String?> deskripsi = const Value.absent(),
          bool? aktif}) =>
      Paket(
        id: id ?? this.id,
        namaPaket: namaPaket ?? this.namaPaket,
        jumlahFoto: jumlahFoto ?? this.jumlahFoto,
        jumlahCetak: jumlahCetak ?? this.jumlahCetak,
        durasiSesi: durasiSesi ?? this.durasiSesi,
        harga: harga ?? this.harga,
        deskripsi: deskripsi.present ? deskripsi.value : this.deskripsi,
        aktif: aktif ?? this.aktif,
      );
  Paket copyWithCompanion(PaketsCompanion data) {
    return Paket(
      id: data.id.present ? data.id.value : this.id,
      namaPaket: data.namaPaket.present ? data.namaPaket.value : this.namaPaket,
      jumlahFoto:
          data.jumlahFoto.present ? data.jumlahFoto.value : this.jumlahFoto,
      jumlahCetak:
          data.jumlahCetak.present ? data.jumlahCetak.value : this.jumlahCetak,
      durasiSesi:
          data.durasiSesi.present ? data.durasiSesi.value : this.durasiSesi,
      harga: data.harga.present ? data.harga.value : this.harga,
      deskripsi: data.deskripsi.present ? data.deskripsi.value : this.deskripsi,
      aktif: data.aktif.present ? data.aktif.value : this.aktif,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Paket(')
          ..write('id: $id, ')
          ..write('namaPaket: $namaPaket, ')
          ..write('jumlahFoto: $jumlahFoto, ')
          ..write('jumlahCetak: $jumlahCetak, ')
          ..write('durasiSesi: $durasiSesi, ')
          ..write('harga: $harga, ')
          ..write('deskripsi: $deskripsi, ')
          ..write('aktif: $aktif')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, namaPaket, jumlahFoto, jumlahCetak,
      durasiSesi, harga, deskripsi, aktif);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Paket &&
          other.id == this.id &&
          other.namaPaket == this.namaPaket &&
          other.jumlahFoto == this.jumlahFoto &&
          other.jumlahCetak == this.jumlahCetak &&
          other.durasiSesi == this.durasiSesi &&
          other.harga == this.harga &&
          other.deskripsi == this.deskripsi &&
          other.aktif == this.aktif);
}

class PaketsCompanion extends UpdateCompanion<Paket> {
  final Value<int> id;
  final Value<String> namaPaket;
  final Value<int> jumlahFoto;
  final Value<int> jumlahCetak;
  final Value<int> durasiSesi;
  final Value<double> harga;
  final Value<String?> deskripsi;
  final Value<bool> aktif;
  const PaketsCompanion({
    this.id = const Value.absent(),
    this.namaPaket = const Value.absent(),
    this.jumlahFoto = const Value.absent(),
    this.jumlahCetak = const Value.absent(),
    this.durasiSesi = const Value.absent(),
    this.harga = const Value.absent(),
    this.deskripsi = const Value.absent(),
    this.aktif = const Value.absent(),
  });
  PaketsCompanion.insert({
    this.id = const Value.absent(),
    required String namaPaket,
    required int jumlahFoto,
    required int jumlahCetak,
    required int durasiSesi,
    required double harga,
    this.deskripsi = const Value.absent(),
    this.aktif = const Value.absent(),
  })  : namaPaket = Value(namaPaket),
        jumlahFoto = Value(jumlahFoto),
        jumlahCetak = Value(jumlahCetak),
        durasiSesi = Value(durasiSesi),
        harga = Value(harga);
  static Insertable<Paket> custom({
    Expression<int>? id,
    Expression<String>? namaPaket,
    Expression<int>? jumlahFoto,
    Expression<int>? jumlahCetak,
    Expression<int>? durasiSesi,
    Expression<double>? harga,
    Expression<String>? deskripsi,
    Expression<bool>? aktif,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (namaPaket != null) 'nama_paket': namaPaket,
      if (jumlahFoto != null) 'jumlah_foto': jumlahFoto,
      if (jumlahCetak != null) 'jumlah_cetak': jumlahCetak,
      if (durasiSesi != null) 'durasi_sesi': durasiSesi,
      if (harga != null) 'harga': harga,
      if (deskripsi != null) 'deskripsi': deskripsi,
      if (aktif != null) 'aktif': aktif,
    });
  }

  PaketsCompanion copyWith(
      {Value<int>? id,
      Value<String>? namaPaket,
      Value<int>? jumlahFoto,
      Value<int>? jumlahCetak,
      Value<int>? durasiSesi,
      Value<double>? harga,
      Value<String?>? deskripsi,
      Value<bool>? aktif}) {
    return PaketsCompanion(
      id: id ?? this.id,
      namaPaket: namaPaket ?? this.namaPaket,
      jumlahFoto: jumlahFoto ?? this.jumlahFoto,
      jumlahCetak: jumlahCetak ?? this.jumlahCetak,
      durasiSesi: durasiSesi ?? this.durasiSesi,
      harga: harga ?? this.harga,
      deskripsi: deskripsi ?? this.deskripsi,
      aktif: aktif ?? this.aktif,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (namaPaket.present) {
      map['nama_paket'] = Variable<String>(namaPaket.value);
    }
    if (jumlahFoto.present) {
      map['jumlah_foto'] = Variable<int>(jumlahFoto.value);
    }
    if (jumlahCetak.present) {
      map['jumlah_cetak'] = Variable<int>(jumlahCetak.value);
    }
    if (durasiSesi.present) {
      map['durasi_sesi'] = Variable<int>(durasiSesi.value);
    }
    if (harga.present) {
      map['harga'] = Variable<double>(harga.value);
    }
    if (deskripsi.present) {
      map['deskripsi'] = Variable<String>(deskripsi.value);
    }
    if (aktif.present) {
      map['aktif'] = Variable<bool>(aktif.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaketsCompanion(')
          ..write('id: $id, ')
          ..write('namaPaket: $namaPaket, ')
          ..write('jumlahFoto: $jumlahFoto, ')
          ..write('jumlahCetak: $jumlahCetak, ')
          ..write('durasiSesi: $durasiSesi, ')
          ..write('harga: $harga, ')
          ..write('deskripsi: $deskripsi, ')
          ..write('aktif: $aktif')
          ..write(')'))
        .toString();
  }
}

class $FramesTable extends Frames with TableInfo<$FramesTable, Frame> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FramesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _namaFrameMeta =
      const VerificationMeta('namaFrame');
  @override
  late final GeneratedColumn<String> namaFrame = GeneratedColumn<String>(
      'nama_frame', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pathFileMeta =
      const VerificationMeta('pathFile');
  @override
  late final GeneratedColumn<String> pathFile = GeneratedColumn<String>(
      'path_file', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _kategoriMeta =
      const VerificationMeta('kategori');
  @override
  late final GeneratedColumn<String> kategori = GeneratedColumn<String>(
      'kategori', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _aktifMeta = const VerificationMeta('aktif');
  @override
  late final GeneratedColumn<bool> aktif = GeneratedColumn<bool>(
      'aktif', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("aktif" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns =>
      [id, namaFrame, pathFile, kategori, aktif];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'frames';
  @override
  VerificationContext validateIntegrity(Insertable<Frame> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nama_frame')) {
      context.handle(_namaFrameMeta,
          namaFrame.isAcceptableOrUnknown(data['nama_frame']!, _namaFrameMeta));
    } else if (isInserting) {
      context.missing(_namaFrameMeta);
    }
    if (data.containsKey('path_file')) {
      context.handle(_pathFileMeta,
          pathFile.isAcceptableOrUnknown(data['path_file']!, _pathFileMeta));
    } else if (isInserting) {
      context.missing(_pathFileMeta);
    }
    if (data.containsKey('kategori')) {
      context.handle(_kategoriMeta,
          kategori.isAcceptableOrUnknown(data['kategori']!, _kategoriMeta));
    } else if (isInserting) {
      context.missing(_kategoriMeta);
    }
    if (data.containsKey('aktif')) {
      context.handle(
          _aktifMeta, aktif.isAcceptableOrUnknown(data['aktif']!, _aktifMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Frame map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Frame(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      namaFrame: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nama_frame'])!,
      pathFile: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path_file'])!,
      kategori: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}kategori'])!,
      aktif: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}aktif'])!,
    );
  }

  @override
  $FramesTable createAlias(String alias) {
    return $FramesTable(attachedDatabase, alias);
  }
}

class Frame extends DataClass implements Insertable<Frame> {
  final int id;
  final String namaFrame;
  final String pathFile;
  final String kategori;
  final bool aktif;
  const Frame(
      {required this.id,
      required this.namaFrame,
      required this.pathFile,
      required this.kategori,
      required this.aktif});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nama_frame'] = Variable<String>(namaFrame);
    map['path_file'] = Variable<String>(pathFile);
    map['kategori'] = Variable<String>(kategori);
    map['aktif'] = Variable<bool>(aktif);
    return map;
  }

  FramesCompanion toCompanion(bool nullToAbsent) {
    return FramesCompanion(
      id: Value(id),
      namaFrame: Value(namaFrame),
      pathFile: Value(pathFile),
      kategori: Value(kategori),
      aktif: Value(aktif),
    );
  }

  factory Frame.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Frame(
      id: serializer.fromJson<int>(json['id']),
      namaFrame: serializer.fromJson<String>(json['namaFrame']),
      pathFile: serializer.fromJson<String>(json['pathFile']),
      kategori: serializer.fromJson<String>(json['kategori']),
      aktif: serializer.fromJson<bool>(json['aktif']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'namaFrame': serializer.toJson<String>(namaFrame),
      'pathFile': serializer.toJson<String>(pathFile),
      'kategori': serializer.toJson<String>(kategori),
      'aktif': serializer.toJson<bool>(aktif),
    };
  }

  Frame copyWith(
          {int? id,
          String? namaFrame,
          String? pathFile,
          String? kategori,
          bool? aktif}) =>
      Frame(
        id: id ?? this.id,
        namaFrame: namaFrame ?? this.namaFrame,
        pathFile: pathFile ?? this.pathFile,
        kategori: kategori ?? this.kategori,
        aktif: aktif ?? this.aktif,
      );
  Frame copyWithCompanion(FramesCompanion data) {
    return Frame(
      id: data.id.present ? data.id.value : this.id,
      namaFrame: data.namaFrame.present ? data.namaFrame.value : this.namaFrame,
      pathFile: data.pathFile.present ? data.pathFile.value : this.pathFile,
      kategori: data.kategori.present ? data.kategori.value : this.kategori,
      aktif: data.aktif.present ? data.aktif.value : this.aktif,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Frame(')
          ..write('id: $id, ')
          ..write('namaFrame: $namaFrame, ')
          ..write('pathFile: $pathFile, ')
          ..write('kategori: $kategori, ')
          ..write('aktif: $aktif')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, namaFrame, pathFile, kategori, aktif);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Frame &&
          other.id == this.id &&
          other.namaFrame == this.namaFrame &&
          other.pathFile == this.pathFile &&
          other.kategori == this.kategori &&
          other.aktif == this.aktif);
}

class FramesCompanion extends UpdateCompanion<Frame> {
  final Value<int> id;
  final Value<String> namaFrame;
  final Value<String> pathFile;
  final Value<String> kategori;
  final Value<bool> aktif;
  const FramesCompanion({
    this.id = const Value.absent(),
    this.namaFrame = const Value.absent(),
    this.pathFile = const Value.absent(),
    this.kategori = const Value.absent(),
    this.aktif = const Value.absent(),
  });
  FramesCompanion.insert({
    this.id = const Value.absent(),
    required String namaFrame,
    required String pathFile,
    required String kategori,
    this.aktif = const Value.absent(),
  })  : namaFrame = Value(namaFrame),
        pathFile = Value(pathFile),
        kategori = Value(kategori);
  static Insertable<Frame> custom({
    Expression<int>? id,
    Expression<String>? namaFrame,
    Expression<String>? pathFile,
    Expression<String>? kategori,
    Expression<bool>? aktif,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (namaFrame != null) 'nama_frame': namaFrame,
      if (pathFile != null) 'path_file': pathFile,
      if (kategori != null) 'kategori': kategori,
      if (aktif != null) 'aktif': aktif,
    });
  }

  FramesCompanion copyWith(
      {Value<int>? id,
      Value<String>? namaFrame,
      Value<String>? pathFile,
      Value<String>? kategori,
      Value<bool>? aktif}) {
    return FramesCompanion(
      id: id ?? this.id,
      namaFrame: namaFrame ?? this.namaFrame,
      pathFile: pathFile ?? this.pathFile,
      kategori: kategori ?? this.kategori,
      aktif: aktif ?? this.aktif,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (namaFrame.present) {
      map['nama_frame'] = Variable<String>(namaFrame.value);
    }
    if (pathFile.present) {
      map['path_file'] = Variable<String>(pathFile.value);
    }
    if (kategori.present) {
      map['kategori'] = Variable<String>(kategori.value);
    }
    if (aktif.present) {
      map['aktif'] = Variable<bool>(aktif.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FramesCompanion(')
          ..write('id: $id, ')
          ..write('namaFrame: $namaFrame, ')
          ..write('pathFile: $pathFile, ')
          ..write('kategori: $kategori, ')
          ..write('aktif: $aktif')
          ..write(')'))
        .toString();
  }
}

class $SesisTable extends Sesis with TableInfo<$SesisTable, Sesi> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SesisTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _kodeSesiMeta =
      const VerificationMeta('kodeSesi');
  @override
  late final GeneratedColumn<String> kodeSesi = GeneratedColumn<String>(
      'kode_sesi', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _idPaketMeta =
      const VerificationMeta('idPaket');
  @override
  late final GeneratedColumn<int> idPaket = GeneratedColumn<int>(
      'id_paket', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _idFrameMeta =
      const VerificationMeta('idFrame');
  @override
  late final GeneratedColumn<int> idFrame = GeneratedColumn<int>(
      'id_frame', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _tanggalMeta =
      const VerificationMeta('tanggal');
  @override
  late final GeneratedColumn<int> tanggal = GeneratedColumn<int>(
      'tanggal', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _totalBayarMeta =
      const VerificationMeta('totalBayar');
  @override
  late final GeneratedColumn<double> totalBayar = GeneratedColumn<double>(
      'total_bayar', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _metodeBayarMeta =
      const VerificationMeta('metodeBayar');
  @override
  late final GeneratedColumn<String> metodeBayar = GeneratedColumn<String>(
      'metode_bayar', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('qris'));
  static const VerificationMeta _statusBayarMeta =
      const VerificationMeta('statusBayar');
  @override
  late final GeneratedColumn<String> statusBayar = GeneratedColumn<String>(
      'status_bayar', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('berlangsung'));
  static const VerificationMeta _folderCloudUrlMeta =
      const VerificationMeta('folderCloudUrl');
  @override
  late final GeneratedColumn<String> folderCloudUrl = GeneratedColumn<String>(
      'folder_cloud_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _midtransOrderIdMeta =
      const VerificationMeta('midtransOrderId');
  @override
  late final GeneratedColumn<String> midtransOrderId = GeneratedColumn<String>(
      'midtrans_order_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        kodeSesi,
        idPaket,
        idFrame,
        tanggal,
        totalBayar,
        metodeBayar,
        statusBayar,
        status,
        folderCloudUrl,
        midtransOrderId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sesis';
  @override
  VerificationContext validateIntegrity(Insertable<Sesi> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('kode_sesi')) {
      context.handle(_kodeSesiMeta,
          kodeSesi.isAcceptableOrUnknown(data['kode_sesi']!, _kodeSesiMeta));
    } else if (isInserting) {
      context.missing(_kodeSesiMeta);
    }
    if (data.containsKey('id_paket')) {
      context.handle(_idPaketMeta,
          idPaket.isAcceptableOrUnknown(data['id_paket']!, _idPaketMeta));
    } else if (isInserting) {
      context.missing(_idPaketMeta);
    }
    if (data.containsKey('id_frame')) {
      context.handle(_idFrameMeta,
          idFrame.isAcceptableOrUnknown(data['id_frame']!, _idFrameMeta));
    }
    if (data.containsKey('tanggal')) {
      context.handle(_tanggalMeta,
          tanggal.isAcceptableOrUnknown(data['tanggal']!, _tanggalMeta));
    } else if (isInserting) {
      context.missing(_tanggalMeta);
    }
    if (data.containsKey('total_bayar')) {
      context.handle(
          _totalBayarMeta,
          totalBayar.isAcceptableOrUnknown(
              data['total_bayar']!, _totalBayarMeta));
    } else if (isInserting) {
      context.missing(_totalBayarMeta);
    }
    if (data.containsKey('metode_bayar')) {
      context.handle(
          _metodeBayarMeta,
          metodeBayar.isAcceptableOrUnknown(
              data['metode_bayar']!, _metodeBayarMeta));
    }
    if (data.containsKey('status_bayar')) {
      context.handle(
          _statusBayarMeta,
          statusBayar.isAcceptableOrUnknown(
              data['status_bayar']!, _statusBayarMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('folder_cloud_url')) {
      context.handle(
          _folderCloudUrlMeta,
          folderCloudUrl.isAcceptableOrUnknown(
              data['folder_cloud_url']!, _folderCloudUrlMeta));
    }
    if (data.containsKey('midtrans_order_id')) {
      context.handle(
          _midtransOrderIdMeta,
          midtransOrderId.isAcceptableOrUnknown(
              data['midtrans_order_id']!, _midtransOrderIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Sesi map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Sesi(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      kodeSesi: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}kode_sesi'])!,
      idPaket: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_paket'])!,
      idFrame: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_frame']),
      tanggal: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tanggal'])!,
      totalBayar: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_bayar'])!,
      metodeBayar: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}metode_bayar'])!,
      statusBayar: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status_bayar'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      folderCloudUrl: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}folder_cloud_url']),
      midtransOrderId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}midtrans_order_id']),
    );
  }

  @override
  $SesisTable createAlias(String alias) {
    return $SesisTable(attachedDatabase, alias);
  }
}

class Sesi extends DataClass implements Insertable<Sesi> {
  final int id;
  final String kodeSesi;
  final int idPaket;
  final int? idFrame;
  final int tanggal;
  final double totalBayar;
  final String metodeBayar;
  final String statusBayar;
  final String status;
  final String? folderCloudUrl;
  final String? midtransOrderId;
  const Sesi(
      {required this.id,
      required this.kodeSesi,
      required this.idPaket,
      this.idFrame,
      required this.tanggal,
      required this.totalBayar,
      required this.metodeBayar,
      required this.statusBayar,
      required this.status,
      this.folderCloudUrl,
      this.midtransOrderId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['kode_sesi'] = Variable<String>(kodeSesi);
    map['id_paket'] = Variable<int>(idPaket);
    if (!nullToAbsent || idFrame != null) {
      map['id_frame'] = Variable<int>(idFrame);
    }
    map['tanggal'] = Variable<int>(tanggal);
    map['total_bayar'] = Variable<double>(totalBayar);
    map['metode_bayar'] = Variable<String>(metodeBayar);
    map['status_bayar'] = Variable<String>(statusBayar);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || folderCloudUrl != null) {
      map['folder_cloud_url'] = Variable<String>(folderCloudUrl);
    }
    if (!nullToAbsent || midtransOrderId != null) {
      map['midtrans_order_id'] = Variable<String>(midtransOrderId);
    }
    return map;
  }

  SesisCompanion toCompanion(bool nullToAbsent) {
    return SesisCompanion(
      id: Value(id),
      kodeSesi: Value(kodeSesi),
      idPaket: Value(idPaket),
      idFrame: idFrame == null && nullToAbsent
          ? const Value.absent()
          : Value(idFrame),
      tanggal: Value(tanggal),
      totalBayar: Value(totalBayar),
      metodeBayar: Value(metodeBayar),
      statusBayar: Value(statusBayar),
      status: Value(status),
      folderCloudUrl: folderCloudUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(folderCloudUrl),
      midtransOrderId: midtransOrderId == null && nullToAbsent
          ? const Value.absent()
          : Value(midtransOrderId),
    );
  }

  factory Sesi.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Sesi(
      id: serializer.fromJson<int>(json['id']),
      kodeSesi: serializer.fromJson<String>(json['kodeSesi']),
      idPaket: serializer.fromJson<int>(json['idPaket']),
      idFrame: serializer.fromJson<int?>(json['idFrame']),
      tanggal: serializer.fromJson<int>(json['tanggal']),
      totalBayar: serializer.fromJson<double>(json['totalBayar']),
      metodeBayar: serializer.fromJson<String>(json['metodeBayar']),
      statusBayar: serializer.fromJson<String>(json['statusBayar']),
      status: serializer.fromJson<String>(json['status']),
      folderCloudUrl: serializer.fromJson<String?>(json['folderCloudUrl']),
      midtransOrderId: serializer.fromJson<String?>(json['midtransOrderId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'kodeSesi': serializer.toJson<String>(kodeSesi),
      'idPaket': serializer.toJson<int>(idPaket),
      'idFrame': serializer.toJson<int?>(idFrame),
      'tanggal': serializer.toJson<int>(tanggal),
      'totalBayar': serializer.toJson<double>(totalBayar),
      'metodeBayar': serializer.toJson<String>(metodeBayar),
      'statusBayar': serializer.toJson<String>(statusBayar),
      'status': serializer.toJson<String>(status),
      'folderCloudUrl': serializer.toJson<String?>(folderCloudUrl),
      'midtransOrderId': serializer.toJson<String?>(midtransOrderId),
    };
  }

  Sesi copyWith(
          {int? id,
          String? kodeSesi,
          int? idPaket,
          Value<int?> idFrame = const Value.absent(),
          int? tanggal,
          double? totalBayar,
          String? metodeBayar,
          String? statusBayar,
          String? status,
          Value<String?> folderCloudUrl = const Value.absent(),
          Value<String?> midtransOrderId = const Value.absent()}) =>
      Sesi(
        id: id ?? this.id,
        kodeSesi: kodeSesi ?? this.kodeSesi,
        idPaket: idPaket ?? this.idPaket,
        idFrame: idFrame.present ? idFrame.value : this.idFrame,
        tanggal: tanggal ?? this.tanggal,
        totalBayar: totalBayar ?? this.totalBayar,
        metodeBayar: metodeBayar ?? this.metodeBayar,
        statusBayar: statusBayar ?? this.statusBayar,
        status: status ?? this.status,
        folderCloudUrl:
            folderCloudUrl.present ? folderCloudUrl.value : this.folderCloudUrl,
        midtransOrderId: midtransOrderId.present
            ? midtransOrderId.value
            : this.midtransOrderId,
      );
  Sesi copyWithCompanion(SesisCompanion data) {
    return Sesi(
      id: data.id.present ? data.id.value : this.id,
      kodeSesi: data.kodeSesi.present ? data.kodeSesi.value : this.kodeSesi,
      idPaket: data.idPaket.present ? data.idPaket.value : this.idPaket,
      idFrame: data.idFrame.present ? data.idFrame.value : this.idFrame,
      tanggal: data.tanggal.present ? data.tanggal.value : this.tanggal,
      totalBayar:
          data.totalBayar.present ? data.totalBayar.value : this.totalBayar,
      metodeBayar:
          data.metodeBayar.present ? data.metodeBayar.value : this.metodeBayar,
      statusBayar:
          data.statusBayar.present ? data.statusBayar.value : this.statusBayar,
      status: data.status.present ? data.status.value : this.status,
      folderCloudUrl: data.folderCloudUrl.present
          ? data.folderCloudUrl.value
          : this.folderCloudUrl,
      midtransOrderId: data.midtransOrderId.present
          ? data.midtransOrderId.value
          : this.midtransOrderId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Sesi(')
          ..write('id: $id, ')
          ..write('kodeSesi: $kodeSesi, ')
          ..write('idPaket: $idPaket, ')
          ..write('idFrame: $idFrame, ')
          ..write('tanggal: $tanggal, ')
          ..write('totalBayar: $totalBayar, ')
          ..write('metodeBayar: $metodeBayar, ')
          ..write('statusBayar: $statusBayar, ')
          ..write('status: $status, ')
          ..write('folderCloudUrl: $folderCloudUrl, ')
          ..write('midtransOrderId: $midtransOrderId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      kodeSesi,
      idPaket,
      idFrame,
      tanggal,
      totalBayar,
      metodeBayar,
      statusBayar,
      status,
      folderCloudUrl,
      midtransOrderId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Sesi &&
          other.id == this.id &&
          other.kodeSesi == this.kodeSesi &&
          other.idPaket == this.idPaket &&
          other.idFrame == this.idFrame &&
          other.tanggal == this.tanggal &&
          other.totalBayar == this.totalBayar &&
          other.metodeBayar == this.metodeBayar &&
          other.statusBayar == this.statusBayar &&
          other.status == this.status &&
          other.folderCloudUrl == this.folderCloudUrl &&
          other.midtransOrderId == this.midtransOrderId);
}

class SesisCompanion extends UpdateCompanion<Sesi> {
  final Value<int> id;
  final Value<String> kodeSesi;
  final Value<int> idPaket;
  final Value<int?> idFrame;
  final Value<int> tanggal;
  final Value<double> totalBayar;
  final Value<String> metodeBayar;
  final Value<String> statusBayar;
  final Value<String> status;
  final Value<String?> folderCloudUrl;
  final Value<String?> midtransOrderId;
  const SesisCompanion({
    this.id = const Value.absent(),
    this.kodeSesi = const Value.absent(),
    this.idPaket = const Value.absent(),
    this.idFrame = const Value.absent(),
    this.tanggal = const Value.absent(),
    this.totalBayar = const Value.absent(),
    this.metodeBayar = const Value.absent(),
    this.statusBayar = const Value.absent(),
    this.status = const Value.absent(),
    this.folderCloudUrl = const Value.absent(),
    this.midtransOrderId = const Value.absent(),
  });
  SesisCompanion.insert({
    this.id = const Value.absent(),
    required String kodeSesi,
    required int idPaket,
    this.idFrame = const Value.absent(),
    required int tanggal,
    required double totalBayar,
    this.metodeBayar = const Value.absent(),
    this.statusBayar = const Value.absent(),
    this.status = const Value.absent(),
    this.folderCloudUrl = const Value.absent(),
    this.midtransOrderId = const Value.absent(),
  })  : kodeSesi = Value(kodeSesi),
        idPaket = Value(idPaket),
        tanggal = Value(tanggal),
        totalBayar = Value(totalBayar);
  static Insertable<Sesi> custom({
    Expression<int>? id,
    Expression<String>? kodeSesi,
    Expression<int>? idPaket,
    Expression<int>? idFrame,
    Expression<int>? tanggal,
    Expression<double>? totalBayar,
    Expression<String>? metodeBayar,
    Expression<String>? statusBayar,
    Expression<String>? status,
    Expression<String>? folderCloudUrl,
    Expression<String>? midtransOrderId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (kodeSesi != null) 'kode_sesi': kodeSesi,
      if (idPaket != null) 'id_paket': idPaket,
      if (idFrame != null) 'id_frame': idFrame,
      if (tanggal != null) 'tanggal': tanggal,
      if (totalBayar != null) 'total_bayar': totalBayar,
      if (metodeBayar != null) 'metode_bayar': metodeBayar,
      if (statusBayar != null) 'status_bayar': statusBayar,
      if (status != null) 'status': status,
      if (folderCloudUrl != null) 'folder_cloud_url': folderCloudUrl,
      if (midtransOrderId != null) 'midtrans_order_id': midtransOrderId,
    });
  }

  SesisCompanion copyWith(
      {Value<int>? id,
      Value<String>? kodeSesi,
      Value<int>? idPaket,
      Value<int?>? idFrame,
      Value<int>? tanggal,
      Value<double>? totalBayar,
      Value<String>? metodeBayar,
      Value<String>? statusBayar,
      Value<String>? status,
      Value<String?>? folderCloudUrl,
      Value<String?>? midtransOrderId}) {
    return SesisCompanion(
      id: id ?? this.id,
      kodeSesi: kodeSesi ?? this.kodeSesi,
      idPaket: idPaket ?? this.idPaket,
      idFrame: idFrame ?? this.idFrame,
      tanggal: tanggal ?? this.tanggal,
      totalBayar: totalBayar ?? this.totalBayar,
      metodeBayar: metodeBayar ?? this.metodeBayar,
      statusBayar: statusBayar ?? this.statusBayar,
      status: status ?? this.status,
      folderCloudUrl: folderCloudUrl ?? this.folderCloudUrl,
      midtransOrderId: midtransOrderId ?? this.midtransOrderId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (kodeSesi.present) {
      map['kode_sesi'] = Variable<String>(kodeSesi.value);
    }
    if (idPaket.present) {
      map['id_paket'] = Variable<int>(idPaket.value);
    }
    if (idFrame.present) {
      map['id_frame'] = Variable<int>(idFrame.value);
    }
    if (tanggal.present) {
      map['tanggal'] = Variable<int>(tanggal.value);
    }
    if (totalBayar.present) {
      map['total_bayar'] = Variable<double>(totalBayar.value);
    }
    if (metodeBayar.present) {
      map['metode_bayar'] = Variable<String>(metodeBayar.value);
    }
    if (statusBayar.present) {
      map['status_bayar'] = Variable<String>(statusBayar.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (folderCloudUrl.present) {
      map['folder_cloud_url'] = Variable<String>(folderCloudUrl.value);
    }
    if (midtransOrderId.present) {
      map['midtrans_order_id'] = Variable<String>(midtransOrderId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SesisCompanion(')
          ..write('id: $id, ')
          ..write('kodeSesi: $kodeSesi, ')
          ..write('idPaket: $idPaket, ')
          ..write('idFrame: $idFrame, ')
          ..write('tanggal: $tanggal, ')
          ..write('totalBayar: $totalBayar, ')
          ..write('metodeBayar: $metodeBayar, ')
          ..write('statusBayar: $statusBayar, ')
          ..write('status: $status, ')
          ..write('folderCloudUrl: $folderCloudUrl, ')
          ..write('midtransOrderId: $midtransOrderId')
          ..write(')'))
        .toString();
  }
}

class $SesiFotosTable extends SesiFotos
    with TableInfo<$SesiFotosTable, SesiFoto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SesiFotosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _idSesiMeta = const VerificationMeta('idSesi');
  @override
  late final GeneratedColumn<int> idSesi = GeneratedColumn<int>(
      'id_sesi', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _pathFileLokalMeta =
      const VerificationMeta('pathFileLokal');
  @override
  late final GeneratedColumn<String> pathFileLokal = GeneratedColumn<String>(
      'path_file_lokal', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _driveFileIdMeta =
      const VerificationMeta('driveFileId');
  @override
  late final GeneratedColumn<String> driveFileId = GeneratedColumn<String>(
      'drive_file_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _urutanMeta = const VerificationMeta('urutan');
  @override
  late final GeneratedColumn<int> urutan = GeneratedColumn<int>(
      'urutan', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _pendingUploadMeta =
      const VerificationMeta('pendingUpload');
  @override
  late final GeneratedColumn<bool> pendingUpload = GeneratedColumn<bool>(
      'pending_upload', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("pending_upload" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns =>
      [id, idSesi, pathFileLokal, driveFileId, urutan, pendingUpload];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sesi_fotos';
  @override
  VerificationContext validateIntegrity(Insertable<SesiFoto> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('id_sesi')) {
      context.handle(_idSesiMeta,
          idSesi.isAcceptableOrUnknown(data['id_sesi']!, _idSesiMeta));
    } else if (isInserting) {
      context.missing(_idSesiMeta);
    }
    if (data.containsKey('path_file_lokal')) {
      context.handle(
          _pathFileLokalMeta,
          pathFileLokal.isAcceptableOrUnknown(
              data['path_file_lokal']!, _pathFileLokalMeta));
    } else if (isInserting) {
      context.missing(_pathFileLokalMeta);
    }
    if (data.containsKey('drive_file_id')) {
      context.handle(
          _driveFileIdMeta,
          driveFileId.isAcceptableOrUnknown(
              data['drive_file_id']!, _driveFileIdMeta));
    }
    if (data.containsKey('urutan')) {
      context.handle(_urutanMeta,
          urutan.isAcceptableOrUnknown(data['urutan']!, _urutanMeta));
    } else if (isInserting) {
      context.missing(_urutanMeta);
    }
    if (data.containsKey('pending_upload')) {
      context.handle(
          _pendingUploadMeta,
          pendingUpload.isAcceptableOrUnknown(
              data['pending_upload']!, _pendingUploadMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SesiFoto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SesiFoto(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      idSesi: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_sesi'])!,
      pathFileLokal: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}path_file_lokal'])!,
      driveFileId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}drive_file_id']),
      urutan: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}urutan'])!,
      pendingUpload: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}pending_upload'])!,
    );
  }

  @override
  $SesiFotosTable createAlias(String alias) {
    return $SesiFotosTable(attachedDatabase, alias);
  }
}

class SesiFoto extends DataClass implements Insertable<SesiFoto> {
  final int id;
  final int idSesi;
  final String pathFileLokal;
  final String? driveFileId;
  final int urutan;
  final bool pendingUpload;
  const SesiFoto(
      {required this.id,
      required this.idSesi,
      required this.pathFileLokal,
      this.driveFileId,
      required this.urutan,
      required this.pendingUpload});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['id_sesi'] = Variable<int>(idSesi);
    map['path_file_lokal'] = Variable<String>(pathFileLokal);
    if (!nullToAbsent || driveFileId != null) {
      map['drive_file_id'] = Variable<String>(driveFileId);
    }
    map['urutan'] = Variable<int>(urutan);
    map['pending_upload'] = Variable<bool>(pendingUpload);
    return map;
  }

  SesiFotosCompanion toCompanion(bool nullToAbsent) {
    return SesiFotosCompanion(
      id: Value(id),
      idSesi: Value(idSesi),
      pathFileLokal: Value(pathFileLokal),
      driveFileId: driveFileId == null && nullToAbsent
          ? const Value.absent()
          : Value(driveFileId),
      urutan: Value(urutan),
      pendingUpload: Value(pendingUpload),
    );
  }

  factory SesiFoto.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SesiFoto(
      id: serializer.fromJson<int>(json['id']),
      idSesi: serializer.fromJson<int>(json['idSesi']),
      pathFileLokal: serializer.fromJson<String>(json['pathFileLokal']),
      driveFileId: serializer.fromJson<String?>(json['driveFileId']),
      urutan: serializer.fromJson<int>(json['urutan']),
      pendingUpload: serializer.fromJson<bool>(json['pendingUpload']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'idSesi': serializer.toJson<int>(idSesi),
      'pathFileLokal': serializer.toJson<String>(pathFileLokal),
      'driveFileId': serializer.toJson<String?>(driveFileId),
      'urutan': serializer.toJson<int>(urutan),
      'pendingUpload': serializer.toJson<bool>(pendingUpload),
    };
  }

  SesiFoto copyWith(
          {int? id,
          int? idSesi,
          String? pathFileLokal,
          Value<String?> driveFileId = const Value.absent(),
          int? urutan,
          bool? pendingUpload}) =>
      SesiFoto(
        id: id ?? this.id,
        idSesi: idSesi ?? this.idSesi,
        pathFileLokal: pathFileLokal ?? this.pathFileLokal,
        driveFileId: driveFileId.present ? driveFileId.value : this.driveFileId,
        urutan: urutan ?? this.urutan,
        pendingUpload: pendingUpload ?? this.pendingUpload,
      );
  SesiFoto copyWithCompanion(SesiFotosCompanion data) {
    return SesiFoto(
      id: data.id.present ? data.id.value : this.id,
      idSesi: data.idSesi.present ? data.idSesi.value : this.idSesi,
      pathFileLokal: data.pathFileLokal.present
          ? data.pathFileLokal.value
          : this.pathFileLokal,
      driveFileId:
          data.driveFileId.present ? data.driveFileId.value : this.driveFileId,
      urutan: data.urutan.present ? data.urutan.value : this.urutan,
      pendingUpload: data.pendingUpload.present
          ? data.pendingUpload.value
          : this.pendingUpload,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SesiFoto(')
          ..write('id: $id, ')
          ..write('idSesi: $idSesi, ')
          ..write('pathFileLokal: $pathFileLokal, ')
          ..write('driveFileId: $driveFileId, ')
          ..write('urutan: $urutan, ')
          ..write('pendingUpload: $pendingUpload')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, idSesi, pathFileLokal, driveFileId, urutan, pendingUpload);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SesiFoto &&
          other.id == this.id &&
          other.idSesi == this.idSesi &&
          other.pathFileLokal == this.pathFileLokal &&
          other.driveFileId == this.driveFileId &&
          other.urutan == this.urutan &&
          other.pendingUpload == this.pendingUpload);
}

class SesiFotosCompanion extends UpdateCompanion<SesiFoto> {
  final Value<int> id;
  final Value<int> idSesi;
  final Value<String> pathFileLokal;
  final Value<String?> driveFileId;
  final Value<int> urutan;
  final Value<bool> pendingUpload;
  const SesiFotosCompanion({
    this.id = const Value.absent(),
    this.idSesi = const Value.absent(),
    this.pathFileLokal = const Value.absent(),
    this.driveFileId = const Value.absent(),
    this.urutan = const Value.absent(),
    this.pendingUpload = const Value.absent(),
  });
  SesiFotosCompanion.insert({
    this.id = const Value.absent(),
    required int idSesi,
    required String pathFileLokal,
    this.driveFileId = const Value.absent(),
    required int urutan,
    this.pendingUpload = const Value.absent(),
  })  : idSesi = Value(idSesi),
        pathFileLokal = Value(pathFileLokal),
        urutan = Value(urutan);
  static Insertable<SesiFoto> custom({
    Expression<int>? id,
    Expression<int>? idSesi,
    Expression<String>? pathFileLokal,
    Expression<String>? driveFileId,
    Expression<int>? urutan,
    Expression<bool>? pendingUpload,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idSesi != null) 'id_sesi': idSesi,
      if (pathFileLokal != null) 'path_file_lokal': pathFileLokal,
      if (driveFileId != null) 'drive_file_id': driveFileId,
      if (urutan != null) 'urutan': urutan,
      if (pendingUpload != null) 'pending_upload': pendingUpload,
    });
  }

  SesiFotosCompanion copyWith(
      {Value<int>? id,
      Value<int>? idSesi,
      Value<String>? pathFileLokal,
      Value<String?>? driveFileId,
      Value<int>? urutan,
      Value<bool>? pendingUpload}) {
    return SesiFotosCompanion(
      id: id ?? this.id,
      idSesi: idSesi ?? this.idSesi,
      pathFileLokal: pathFileLokal ?? this.pathFileLokal,
      driveFileId: driveFileId ?? this.driveFileId,
      urutan: urutan ?? this.urutan,
      pendingUpload: pendingUpload ?? this.pendingUpload,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (idSesi.present) {
      map['id_sesi'] = Variable<int>(idSesi.value);
    }
    if (pathFileLokal.present) {
      map['path_file_lokal'] = Variable<String>(pathFileLokal.value);
    }
    if (driveFileId.present) {
      map['drive_file_id'] = Variable<String>(driveFileId.value);
    }
    if (urutan.present) {
      map['urutan'] = Variable<int>(urutan.value);
    }
    if (pendingUpload.present) {
      map['pending_upload'] = Variable<bool>(pendingUpload.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SesiFotosCompanion(')
          ..write('id: $id, ')
          ..write('idSesi: $idSesi, ')
          ..write('pathFileLokal: $pathFileLokal, ')
          ..write('driveFileId: $driveFileId, ')
          ..write('urutan: $urutan, ')
          ..write('pendingUpload: $pendingUpload')
          ..write(')'))
        .toString();
  }
}

class $PengaturansTable extends Pengaturans
    with TableInfo<$PengaturansTable, Pengaturan> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PengaturansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pengaturans';
  @override
  VerificationContext validateIntegrity(Insertable<Pengaturan> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  Pengaturan map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Pengaturan(
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
    );
  }

  @override
  $PengaturansTable createAlias(String alias) {
    return $PengaturansTable(attachedDatabase, alias);
  }
}

class Pengaturan extends DataClass implements Insertable<Pengaturan> {
  final String key;
  final String value;
  const Pengaturan({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  PengaturansCompanion toCompanion(bool nullToAbsent) {
    return PengaturansCompanion(
      key: Value(key),
      value: Value(value),
    );
  }

  factory Pengaturan.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Pengaturan(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  Pengaturan copyWith({String? key, String? value}) => Pengaturan(
        key: key ?? this.key,
        value: value ?? this.value,
      );
  Pengaturan copyWithCompanion(PengaturansCompanion data) {
    return Pengaturan(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Pengaturan(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Pengaturan &&
          other.key == this.key &&
          other.value == this.value);
}

class PengaturansCompanion extends UpdateCompanion<Pengaturan> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const PengaturansCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PengaturansCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  })  : key = Value(key),
        value = Value(value);
  static Insertable<Pengaturan> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PengaturansCompanion copyWith(
      {Value<String>? key, Value<String>? value, Value<int>? rowid}) {
    return PengaturansCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PengaturansCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PaketsTable pakets = $PaketsTable(this);
  late final $FramesTable frames = $FramesTable(this);
  late final $SesisTable sesis = $SesisTable(this);
  late final $SesiFotosTable sesiFotos = $SesiFotosTable(this);
  late final $PengaturansTable pengaturans = $PengaturansTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [pakets, frames, sesis, sesiFotos, pengaturans];
}

typedef $$PaketsTableCreateCompanionBuilder = PaketsCompanion Function({
  Value<int> id,
  required String namaPaket,
  required int jumlahFoto,
  required int jumlahCetak,
  required int durasiSesi,
  required double harga,
  Value<String?> deskripsi,
  Value<bool> aktif,
});
typedef $$PaketsTableUpdateCompanionBuilder = PaketsCompanion Function({
  Value<int> id,
  Value<String> namaPaket,
  Value<int> jumlahFoto,
  Value<int> jumlahCetak,
  Value<int> durasiSesi,
  Value<double> harga,
  Value<String?> deskripsi,
  Value<bool> aktif,
});

class $$PaketsTableFilterComposer
    extends Composer<_$AppDatabase, $PaketsTable> {
  $$PaketsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get namaPaket => $composableBuilder(
      column: $table.namaPaket, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get jumlahFoto => $composableBuilder(
      column: $table.jumlahFoto, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get jumlahCetak => $composableBuilder(
      column: $table.jumlahCetak, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durasiSesi => $composableBuilder(
      column: $table.durasiSesi, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get harga => $composableBuilder(
      column: $table.harga, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deskripsi => $composableBuilder(
      column: $table.deskripsi, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get aktif => $composableBuilder(
      column: $table.aktif, builder: (column) => ColumnFilters(column));
}

class $$PaketsTableOrderingComposer
    extends Composer<_$AppDatabase, $PaketsTable> {
  $$PaketsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get namaPaket => $composableBuilder(
      column: $table.namaPaket, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get jumlahFoto => $composableBuilder(
      column: $table.jumlahFoto, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get jumlahCetak => $composableBuilder(
      column: $table.jumlahCetak, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durasiSesi => $composableBuilder(
      column: $table.durasiSesi, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get harga => $composableBuilder(
      column: $table.harga, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deskripsi => $composableBuilder(
      column: $table.deskripsi, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get aktif => $composableBuilder(
      column: $table.aktif, builder: (column) => ColumnOrderings(column));
}

class $$PaketsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PaketsTable> {
  $$PaketsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get namaPaket =>
      $composableBuilder(column: $table.namaPaket, builder: (column) => column);

  GeneratedColumn<int> get jumlahFoto => $composableBuilder(
      column: $table.jumlahFoto, builder: (column) => column);

  GeneratedColumn<int> get jumlahCetak => $composableBuilder(
      column: $table.jumlahCetak, builder: (column) => column);

  GeneratedColumn<int> get durasiSesi => $composableBuilder(
      column: $table.durasiSesi, builder: (column) => column);

  GeneratedColumn<double> get harga =>
      $composableBuilder(column: $table.harga, builder: (column) => column);

  GeneratedColumn<String> get deskripsi =>
      $composableBuilder(column: $table.deskripsi, builder: (column) => column);

  GeneratedColumn<bool> get aktif =>
      $composableBuilder(column: $table.aktif, builder: (column) => column);
}

class $$PaketsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PaketsTable,
    Paket,
    $$PaketsTableFilterComposer,
    $$PaketsTableOrderingComposer,
    $$PaketsTableAnnotationComposer,
    $$PaketsTableCreateCompanionBuilder,
    $$PaketsTableUpdateCompanionBuilder,
    (Paket, BaseReferences<_$AppDatabase, $PaketsTable, Paket>),
    Paket,
    PrefetchHooks Function()> {
  $$PaketsTableTableManager(_$AppDatabase db, $PaketsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaketsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaketsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaketsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> namaPaket = const Value.absent(),
            Value<int> jumlahFoto = const Value.absent(),
            Value<int> jumlahCetak = const Value.absent(),
            Value<int> durasiSesi = const Value.absent(),
            Value<double> harga = const Value.absent(),
            Value<String?> deskripsi = const Value.absent(),
            Value<bool> aktif = const Value.absent(),
          }) =>
              PaketsCompanion(
            id: id,
            namaPaket: namaPaket,
            jumlahFoto: jumlahFoto,
            jumlahCetak: jumlahCetak,
            durasiSesi: durasiSesi,
            harga: harga,
            deskripsi: deskripsi,
            aktif: aktif,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String namaPaket,
            required int jumlahFoto,
            required int jumlahCetak,
            required int durasiSesi,
            required double harga,
            Value<String?> deskripsi = const Value.absent(),
            Value<bool> aktif = const Value.absent(),
          }) =>
              PaketsCompanion.insert(
            id: id,
            namaPaket: namaPaket,
            jumlahFoto: jumlahFoto,
            jumlahCetak: jumlahCetak,
            durasiSesi: durasiSesi,
            harga: harga,
            deskripsi: deskripsi,
            aktif: aktif,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PaketsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PaketsTable,
    Paket,
    $$PaketsTableFilterComposer,
    $$PaketsTableOrderingComposer,
    $$PaketsTableAnnotationComposer,
    $$PaketsTableCreateCompanionBuilder,
    $$PaketsTableUpdateCompanionBuilder,
    (Paket, BaseReferences<_$AppDatabase, $PaketsTable, Paket>),
    Paket,
    PrefetchHooks Function()>;
typedef $$FramesTableCreateCompanionBuilder = FramesCompanion Function({
  Value<int> id,
  required String namaFrame,
  required String pathFile,
  required String kategori,
  Value<bool> aktif,
});
typedef $$FramesTableUpdateCompanionBuilder = FramesCompanion Function({
  Value<int> id,
  Value<String> namaFrame,
  Value<String> pathFile,
  Value<String> kategori,
  Value<bool> aktif,
});

class $$FramesTableFilterComposer
    extends Composer<_$AppDatabase, $FramesTable> {
  $$FramesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get namaFrame => $composableBuilder(
      column: $table.namaFrame, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get pathFile => $composableBuilder(
      column: $table.pathFile, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get kategori => $composableBuilder(
      column: $table.kategori, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get aktif => $composableBuilder(
      column: $table.aktif, builder: (column) => ColumnFilters(column));
}

class $$FramesTableOrderingComposer
    extends Composer<_$AppDatabase, $FramesTable> {
  $$FramesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get namaFrame => $composableBuilder(
      column: $table.namaFrame, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get pathFile => $composableBuilder(
      column: $table.pathFile, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get kategori => $composableBuilder(
      column: $table.kategori, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get aktif => $composableBuilder(
      column: $table.aktif, builder: (column) => ColumnOrderings(column));
}

class $$FramesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FramesTable> {
  $$FramesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get namaFrame =>
      $composableBuilder(column: $table.namaFrame, builder: (column) => column);

  GeneratedColumn<String> get pathFile =>
      $composableBuilder(column: $table.pathFile, builder: (column) => column);

  GeneratedColumn<String> get kategori =>
      $composableBuilder(column: $table.kategori, builder: (column) => column);

  GeneratedColumn<bool> get aktif =>
      $composableBuilder(column: $table.aktif, builder: (column) => column);
}

class $$FramesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FramesTable,
    Frame,
    $$FramesTableFilterComposer,
    $$FramesTableOrderingComposer,
    $$FramesTableAnnotationComposer,
    $$FramesTableCreateCompanionBuilder,
    $$FramesTableUpdateCompanionBuilder,
    (Frame, BaseReferences<_$AppDatabase, $FramesTable, Frame>),
    Frame,
    PrefetchHooks Function()> {
  $$FramesTableTableManager(_$AppDatabase db, $FramesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FramesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FramesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FramesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> namaFrame = const Value.absent(),
            Value<String> pathFile = const Value.absent(),
            Value<String> kategori = const Value.absent(),
            Value<bool> aktif = const Value.absent(),
          }) =>
              FramesCompanion(
            id: id,
            namaFrame: namaFrame,
            pathFile: pathFile,
            kategori: kategori,
            aktif: aktif,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String namaFrame,
            required String pathFile,
            required String kategori,
            Value<bool> aktif = const Value.absent(),
          }) =>
              FramesCompanion.insert(
            id: id,
            namaFrame: namaFrame,
            pathFile: pathFile,
            kategori: kategori,
            aktif: aktif,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FramesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FramesTable,
    Frame,
    $$FramesTableFilterComposer,
    $$FramesTableOrderingComposer,
    $$FramesTableAnnotationComposer,
    $$FramesTableCreateCompanionBuilder,
    $$FramesTableUpdateCompanionBuilder,
    (Frame, BaseReferences<_$AppDatabase, $FramesTable, Frame>),
    Frame,
    PrefetchHooks Function()>;
typedef $$SesisTableCreateCompanionBuilder = SesisCompanion Function({
  Value<int> id,
  required String kodeSesi,
  required int idPaket,
  Value<int?> idFrame,
  required int tanggal,
  required double totalBayar,
  Value<String> metodeBayar,
  Value<String> statusBayar,
  Value<String> status,
  Value<String?> folderCloudUrl,
  Value<String?> midtransOrderId,
});
typedef $$SesisTableUpdateCompanionBuilder = SesisCompanion Function({
  Value<int> id,
  Value<String> kodeSesi,
  Value<int> idPaket,
  Value<int?> idFrame,
  Value<int> tanggal,
  Value<double> totalBayar,
  Value<String> metodeBayar,
  Value<String> statusBayar,
  Value<String> status,
  Value<String?> folderCloudUrl,
  Value<String?> midtransOrderId,
});

class $$SesisTableFilterComposer extends Composer<_$AppDatabase, $SesisTable> {
  $$SesisTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get kodeSesi => $composableBuilder(
      column: $table.kodeSesi, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get idPaket => $composableBuilder(
      column: $table.idPaket, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get idFrame => $composableBuilder(
      column: $table.idFrame, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get tanggal => $composableBuilder(
      column: $table.tanggal, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalBayar => $composableBuilder(
      column: $table.totalBayar, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get metodeBayar => $composableBuilder(
      column: $table.metodeBayar, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get statusBayar => $composableBuilder(
      column: $table.statusBayar, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get folderCloudUrl => $composableBuilder(
      column: $table.folderCloudUrl,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get midtransOrderId => $composableBuilder(
      column: $table.midtransOrderId,
      builder: (column) => ColumnFilters(column));
}

class $$SesisTableOrderingComposer
    extends Composer<_$AppDatabase, $SesisTable> {
  $$SesisTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get kodeSesi => $composableBuilder(
      column: $table.kodeSesi, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get idPaket => $composableBuilder(
      column: $table.idPaket, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get idFrame => $composableBuilder(
      column: $table.idFrame, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get tanggal => $composableBuilder(
      column: $table.tanggal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalBayar => $composableBuilder(
      column: $table.totalBayar, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get metodeBayar => $composableBuilder(
      column: $table.metodeBayar, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get statusBayar => $composableBuilder(
      column: $table.statusBayar, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get folderCloudUrl => $composableBuilder(
      column: $table.folderCloudUrl,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get midtransOrderId => $composableBuilder(
      column: $table.midtransOrderId,
      builder: (column) => ColumnOrderings(column));
}

class $$SesisTableAnnotationComposer
    extends Composer<_$AppDatabase, $SesisTable> {
  $$SesisTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get kodeSesi =>
      $composableBuilder(column: $table.kodeSesi, builder: (column) => column);

  GeneratedColumn<int> get idPaket =>
      $composableBuilder(column: $table.idPaket, builder: (column) => column);

  GeneratedColumn<int> get idFrame =>
      $composableBuilder(column: $table.idFrame, builder: (column) => column);

  GeneratedColumn<int> get tanggal =>
      $composableBuilder(column: $table.tanggal, builder: (column) => column);

  GeneratedColumn<double> get totalBayar => $composableBuilder(
      column: $table.totalBayar, builder: (column) => column);

  GeneratedColumn<String> get metodeBayar => $composableBuilder(
      column: $table.metodeBayar, builder: (column) => column);

  GeneratedColumn<String> get statusBayar => $composableBuilder(
      column: $table.statusBayar, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get folderCloudUrl => $composableBuilder(
      column: $table.folderCloudUrl, builder: (column) => column);

  GeneratedColumn<String> get midtransOrderId => $composableBuilder(
      column: $table.midtransOrderId, builder: (column) => column);
}

class $$SesisTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SesisTable,
    Sesi,
    $$SesisTableFilterComposer,
    $$SesisTableOrderingComposer,
    $$SesisTableAnnotationComposer,
    $$SesisTableCreateCompanionBuilder,
    $$SesisTableUpdateCompanionBuilder,
    (Sesi, BaseReferences<_$AppDatabase, $SesisTable, Sesi>),
    Sesi,
    PrefetchHooks Function()> {
  $$SesisTableTableManager(_$AppDatabase db, $SesisTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SesisTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SesisTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SesisTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> kodeSesi = const Value.absent(),
            Value<int> idPaket = const Value.absent(),
            Value<int?> idFrame = const Value.absent(),
            Value<int> tanggal = const Value.absent(),
            Value<double> totalBayar = const Value.absent(),
            Value<String> metodeBayar = const Value.absent(),
            Value<String> statusBayar = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> folderCloudUrl = const Value.absent(),
            Value<String?> midtransOrderId = const Value.absent(),
          }) =>
              SesisCompanion(
            id: id,
            kodeSesi: kodeSesi,
            idPaket: idPaket,
            idFrame: idFrame,
            tanggal: tanggal,
            totalBayar: totalBayar,
            metodeBayar: metodeBayar,
            statusBayar: statusBayar,
            status: status,
            folderCloudUrl: folderCloudUrl,
            midtransOrderId: midtransOrderId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String kodeSesi,
            required int idPaket,
            Value<int?> idFrame = const Value.absent(),
            required int tanggal,
            required double totalBayar,
            Value<String> metodeBayar = const Value.absent(),
            Value<String> statusBayar = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> folderCloudUrl = const Value.absent(),
            Value<String?> midtransOrderId = const Value.absent(),
          }) =>
              SesisCompanion.insert(
            id: id,
            kodeSesi: kodeSesi,
            idPaket: idPaket,
            idFrame: idFrame,
            tanggal: tanggal,
            totalBayar: totalBayar,
            metodeBayar: metodeBayar,
            statusBayar: statusBayar,
            status: status,
            folderCloudUrl: folderCloudUrl,
            midtransOrderId: midtransOrderId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SesisTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SesisTable,
    Sesi,
    $$SesisTableFilterComposer,
    $$SesisTableOrderingComposer,
    $$SesisTableAnnotationComposer,
    $$SesisTableCreateCompanionBuilder,
    $$SesisTableUpdateCompanionBuilder,
    (Sesi, BaseReferences<_$AppDatabase, $SesisTable, Sesi>),
    Sesi,
    PrefetchHooks Function()>;
typedef $$SesiFotosTableCreateCompanionBuilder = SesiFotosCompanion Function({
  Value<int> id,
  required int idSesi,
  required String pathFileLokal,
  Value<String?> driveFileId,
  required int urutan,
  Value<bool> pendingUpload,
});
typedef $$SesiFotosTableUpdateCompanionBuilder = SesiFotosCompanion Function({
  Value<int> id,
  Value<int> idSesi,
  Value<String> pathFileLokal,
  Value<String?> driveFileId,
  Value<int> urutan,
  Value<bool> pendingUpload,
});

class $$SesiFotosTableFilterComposer
    extends Composer<_$AppDatabase, $SesiFotosTable> {
  $$SesiFotosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get idSesi => $composableBuilder(
      column: $table.idSesi, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get pathFileLokal => $composableBuilder(
      column: $table.pathFileLokal, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get driveFileId => $composableBuilder(
      column: $table.driveFileId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get urutan => $composableBuilder(
      column: $table.urutan, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get pendingUpload => $composableBuilder(
      column: $table.pendingUpload, builder: (column) => ColumnFilters(column));
}

class $$SesiFotosTableOrderingComposer
    extends Composer<_$AppDatabase, $SesiFotosTable> {
  $$SesiFotosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get idSesi => $composableBuilder(
      column: $table.idSesi, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get pathFileLokal => $composableBuilder(
      column: $table.pathFileLokal,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get driveFileId => $composableBuilder(
      column: $table.driveFileId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get urutan => $composableBuilder(
      column: $table.urutan, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get pendingUpload => $composableBuilder(
      column: $table.pendingUpload,
      builder: (column) => ColumnOrderings(column));
}

class $$SesiFotosTableAnnotationComposer
    extends Composer<_$AppDatabase, $SesiFotosTable> {
  $$SesiFotosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get idSesi =>
      $composableBuilder(column: $table.idSesi, builder: (column) => column);

  GeneratedColumn<String> get pathFileLokal => $composableBuilder(
      column: $table.pathFileLokal, builder: (column) => column);

  GeneratedColumn<String> get driveFileId => $composableBuilder(
      column: $table.driveFileId, builder: (column) => column);

  GeneratedColumn<int> get urutan =>
      $composableBuilder(column: $table.urutan, builder: (column) => column);

  GeneratedColumn<bool> get pendingUpload => $composableBuilder(
      column: $table.pendingUpload, builder: (column) => column);
}

class $$SesiFotosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SesiFotosTable,
    SesiFoto,
    $$SesiFotosTableFilterComposer,
    $$SesiFotosTableOrderingComposer,
    $$SesiFotosTableAnnotationComposer,
    $$SesiFotosTableCreateCompanionBuilder,
    $$SesiFotosTableUpdateCompanionBuilder,
    (SesiFoto, BaseReferences<_$AppDatabase, $SesiFotosTable, SesiFoto>),
    SesiFoto,
    PrefetchHooks Function()> {
  $$SesiFotosTableTableManager(_$AppDatabase db, $SesiFotosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SesiFotosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SesiFotosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SesiFotosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> idSesi = const Value.absent(),
            Value<String> pathFileLokal = const Value.absent(),
            Value<String?> driveFileId = const Value.absent(),
            Value<int> urutan = const Value.absent(),
            Value<bool> pendingUpload = const Value.absent(),
          }) =>
              SesiFotosCompanion(
            id: id,
            idSesi: idSesi,
            pathFileLokal: pathFileLokal,
            driveFileId: driveFileId,
            urutan: urutan,
            pendingUpload: pendingUpload,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int idSesi,
            required String pathFileLokal,
            Value<String?> driveFileId = const Value.absent(),
            required int urutan,
            Value<bool> pendingUpload = const Value.absent(),
          }) =>
              SesiFotosCompanion.insert(
            id: id,
            idSesi: idSesi,
            pathFileLokal: pathFileLokal,
            driveFileId: driveFileId,
            urutan: urutan,
            pendingUpload: pendingUpload,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SesiFotosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SesiFotosTable,
    SesiFoto,
    $$SesiFotosTableFilterComposer,
    $$SesiFotosTableOrderingComposer,
    $$SesiFotosTableAnnotationComposer,
    $$SesiFotosTableCreateCompanionBuilder,
    $$SesiFotosTableUpdateCompanionBuilder,
    (SesiFoto, BaseReferences<_$AppDatabase, $SesiFotosTable, SesiFoto>),
    SesiFoto,
    PrefetchHooks Function()>;
typedef $$PengaturansTableCreateCompanionBuilder = PengaturansCompanion
    Function({
  required String key,
  required String value,
  Value<int> rowid,
});
typedef $$PengaturansTableUpdateCompanionBuilder = PengaturansCompanion
    Function({
  Value<String> key,
  Value<String> value,
  Value<int> rowid,
});

class $$PengaturansTableFilterComposer
    extends Composer<_$AppDatabase, $PengaturansTable> {
  $$PengaturansTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));
}

class $$PengaturansTableOrderingComposer
    extends Composer<_$AppDatabase, $PengaturansTable> {
  $$PengaturansTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));
}

class $$PengaturansTableAnnotationComposer
    extends Composer<_$AppDatabase, $PengaturansTable> {
  $$PengaturansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$PengaturansTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PengaturansTable,
    Pengaturan,
    $$PengaturansTableFilterComposer,
    $$PengaturansTableOrderingComposer,
    $$PengaturansTableAnnotationComposer,
    $$PengaturansTableCreateCompanionBuilder,
    $$PengaturansTableUpdateCompanionBuilder,
    (Pengaturan, BaseReferences<_$AppDatabase, $PengaturansTable, Pengaturan>),
    Pengaturan,
    PrefetchHooks Function()> {
  $$PengaturansTableTableManager(_$AppDatabase db, $PengaturansTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PengaturansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PengaturansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PengaturansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PengaturansCompanion(
            key: key,
            value: value,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String key,
            required String value,
            Value<int> rowid = const Value.absent(),
          }) =>
              PengaturansCompanion.insert(
            key: key,
            value: value,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PengaturansTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PengaturansTable,
    Pengaturan,
    $$PengaturansTableFilterComposer,
    $$PengaturansTableOrderingComposer,
    $$PengaturansTableAnnotationComposer,
    $$PengaturansTableCreateCompanionBuilder,
    $$PengaturansTableUpdateCompanionBuilder,
    (Pengaturan, BaseReferences<_$AppDatabase, $PengaturansTable, Pengaturan>),
    Pengaturan,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PaketsTableTableManager get pakets =>
      $$PaketsTableTableManager(_db, _db.pakets);
  $$FramesTableTableManager get frames =>
      $$FramesTableTableManager(_db, _db.frames);
  $$SesisTableTableManager get sesis =>
      $$SesisTableTableManager(_db, _db.sesis);
  $$SesiFotosTableTableManager get sesiFotos =>
      $$SesiFotosTableTableManager(_db, _db.sesiFotos);
  $$PengaturansTableTableManager get pengaturans =>
      $$PengaturansTableTableManager(_db, _db.pengaturans);
}
