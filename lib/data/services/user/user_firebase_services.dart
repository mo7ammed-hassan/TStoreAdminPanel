import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:t_store_admin_panel/core/errors/firebase_error.dart';
import 'package:t_store_admin_panel/core/utils/constants/firebase_collections.dart';
import 'package:t_store_admin_panel/data/models/user/user_model.dart';
import 'package:t_store_admin_panel/data/services/user/user_manager.dart';

abstract class UserFirebaseServices {
  Future<Either<String, UserModel>> fetchAdminDetails();

  Future<Either<String, List<UserModel>>> fetchUsers();

  Future<Either<String, UserModel>> fetchSpecificUser(String userId);

  Future<Either<String, Unit>> updateUser(UserModel userModel);

  Future<Either<String, Unit>> signOut();
}

class UserFirebaseServicesImpl implements UserFirebaseServices {
  final UserManager _userManager;
  final _database = FirebaseFirestore.instance;
  final FirebaseErrorHandler _errorHandler = FirebaseErrorHandler();

  UserFirebaseServicesImpl(this._userManager);

  DocumentReference _userDocRef(String? id) =>
      _database.collection(FirebaseCollections.users).doc(id);

  CollectionReference get _userRef =>
      FirebaseFirestore.instance.collection(FirebaseCollections.users);

  @override
  Future<Either<String, UserModel>> fetchAdminDetails() async {
    return _errorHandler.handleErrorEitherAsync(() async {
      final docSnapshot = await _userDocRef(_userManager.user!.uid).get();
      return UserModel.fromSnapshot(docSnapshot);
    });
  }

  @override
  Future<Either<String, Unit>> signOut() async {
    return _errorHandler.handleErrorEitherAsync(() async {
      await _userManager.signOut();
      return unit;
    });
  }

  @override
  Future<Either<String, UserModel>> fetchSpecificUser(String userId) {
    return _errorHandler.handleErrorEitherAsync(() async {
      final docSnapshot = await _userDocRef(userId).get();
      return UserModel.fromSnapshot(docSnapshot);
    });
  }

  @override
  Future<Either<String, List<UserModel>>> fetchUsers() async {
    return _errorHandler.handleErrorEitherAsync(() async {
      final queryData = await _userRef.get();
      return queryData.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    });
  }

  @override
  Future<Either<String, Unit>> updateUser(UserModel userModel) async {
    return _errorHandler.handleErrorEitherAsync(() async {
      await _userRef.doc(userModel.userID).update(userModel.toJson());
      return unit;
    });
  }
}
