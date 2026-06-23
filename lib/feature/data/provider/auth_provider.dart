import 'package:flutter/widgets.dart';

import '../AuthServices/auth_services.dart';


class AuthProvider extends ChangeNotifier{
  final AuthServices _authServices= AuthServices();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool>signUp(String email, String password)async{
    _isLoading=true;
    notifyListeners();
    try{
      await _authServices.signUp(email, password);
      _isLoading=false;
      notifyListeners();
      return true;
    }catch(e){
      debugPrint(e.toString());
      _isLoading=false;
      notifyListeners();
      return false;
    }
  }

  Future<bool>signIn(String email,String password)async{
    _isLoading = true;
    notifyListeners();
    try{
      await _authServices.signIn(email, password);
      _isLoading=false;
      notifyListeners();
      return true;
    }catch (e){
      debugPrint(e.toString());
      _isLoading=false;
      notifyListeners();
      return false;
    }
  }

  Future<void>signOut()async{
    await _authServices.signOut();
  }




}