// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthStore on _AuthStore, Store {
  late final _$userAtom = Atom(name: '_AuthStore.user', context: context);

  @override
  User? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(User? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$docRefAtom = Atom(name: '_AuthStore.docRef', context: context);

  @override
  String? get docRef {
    _$docRefAtom.reportRead();
    return super.docRef;
  }

  @override
  set docRef(String? value) {
    _$docRefAtom.reportWrite(value, super.docRef, () {
      super.docRef = value;
    });
  }

  late final _$circulerAtom =
      Atom(name: '_AuthStore.circuler', context: context);

  @override
  bool get circuler {
    _$circulerAtom.reportRead();
    return super.circuler;
  }

  @override
  set circuler(bool value) {
    _$circulerAtom.reportWrite(value, super.circuler, () {
      super.circuler = value;
    });
  }

  late final _$notelistAtom =
      Atom(name: '_AuthStore.notelist', context: context);

  @override
  ObservableList<dynamic> get notelist {
    _$notelistAtom.reportRead();
    return super.notelist;
  }

  @override
  set notelist(ObservableList<dynamic> value) {
    _$notelistAtom.reportWrite(value, super.notelist, () {
      super.notelist = value;
    });
  }

  late final _$isDeviceConnectedAtom =
      Atom(name: '_AuthStore.isDeviceConnected', context: context);

  @override
  bool get isDeviceConnected {
    _$isDeviceConnectedAtom.reportRead();
    return super.isDeviceConnected;
  }

  @override
  set isDeviceConnected(bool value) {
    _$isDeviceConnectedAtom.reportWrite(value, super.isDeviceConnected, () {
      super.isDeviceConnected = value;
    });
  }

  late final _$signUpWithEmailAndPasswordAsyncAction =
      AsyncAction('_AuthStore.signUpWithEmailAndPassword', context: context);

  @override
  Future<bool> signUpWithEmailAndPassword(String email, String password,
      Function onSignUpSuccess, void Function(String?) onerror) {
    return _$signUpWithEmailAndPasswordAsyncAction.run(() => super
        .signUpWithEmailAndPassword(email, password, onSignUpSuccess, onerror));
  }

  late final _$signInWithEmailAndPasswordAsyncAction =
      AsyncAction('_AuthStore.signInWithEmailAndPassword', context: context);

  @override
  Future<bool> signInWithEmailAndPassword(String email, String password,
      Function onSignInSuccess, void Function(String?) onerror) {
    return _$signInWithEmailAndPasswordAsyncAction.run(() => super
        .signInWithEmailAndPassword(email, password, onSignInSuccess, onerror));
  }

  late final _$signOutUserAsyncAction =
      AsyncAction('_AuthStore.signOutUser', context: context);

  @override
  Future<void> signOutUser() {
    return _$signOutUserAsyncAction.run(() => super.signOutUser());
  }

  late final _$LoadNoteAsyncAction =
      AsyncAction('_AuthStore.LoadNote', context: context);

  @override
  Future<void> LoadNote() {
    return _$LoadNoteAsyncAction.run(() => super.LoadNote());
  }

  late final _$DeltenoteAsyncAction =
      AsyncAction('_AuthStore.Deltenote', context: context);

  @override
  Future<void> Deltenote(String nid) {
    return _$DeltenoteAsyncAction.run(() => super.Deltenote(nid));
  }

  late final _$_AuthStoreActionController =
      ActionController(name: '_AuthStore', context: context);

  @override
  String? getuid() {
    final _$actionInfo =
        _$_AuthStoreActionController.startAction(name: '_AuthStore.getuid');
    try {
      return super.getuid();
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void subscription() {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.subscription');
    try {
      return super.subscription();
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
user: ${user},
docRef: ${docRef},
circuler: ${circuler},
notelist: ${notelist},
isDeviceConnected: ${isDeviceConnected}
    ''';
  }
}
