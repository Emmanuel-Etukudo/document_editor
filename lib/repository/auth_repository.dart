import 'dart:convert';

import 'package:document_editor/constants.dart';
import 'package:document_editor/model/error_model.dart';
import 'package:document_editor/model/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    googleSignIn: GoogleSignIn(),
    client: Client()
  ),
);

final userProvider = StateProvider<UserModel?>((ref) => null);

class AuthRepository {
  final GoogleSignIn _googleSignIn;
  final Client _client;

  AuthRepository({required GoogleSignIn googleSignIn, required Client client})
      : _googleSignIn = googleSignIn,
        _client = client;

  Future<ErrorModel> signInWithGoogle() async {
    ErrorModel errorModel = ErrorModel(error: "Something unexpected happened", data: null);
    try {
      final user = await _googleSignIn.signIn();
      if (user != null) {
        final userAccount = UserModel(
            name: user.displayName!,
            email: user.email,
            profilePic: user.photoUrl!,
            uid: "",
            token: "");

        var res = await _client.post(Uri.http(host,'api/signup'),
            body: userAccount.toJson(),
            headers: {
              'Content-type': 'application/json; charset=UTF-8',
            });
        print(res.statusCode);
        print(res.body);

        switch(res.statusCode){
          case 200:
            final newUser = userAccount.copyWith(
              uid: jsonDecode(res.body)['user']['_id'],
            );
            errorModel = ErrorModel(error: null, data: newUser);
            break;
          default:
            throw 'Some error occurred';
        }
      }
    } catch (e) {
      errorModel = ErrorModel(error: e.toString(), data: null);
    }
    return errorModel;
  }
}
