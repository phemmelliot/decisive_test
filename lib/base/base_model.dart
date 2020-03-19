import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class BaseModel extends ChangeNotifier {
  bool _isBusy = false;
  bool _isLoadingMore = false;
  bool _hasWidgetSpecificError = false;
  String _serverError;
  String _authorizationError;
  String _connectionError;
  String _otherError;

  bool get isBusy => _isBusy;
  bool get hasWidgetSpecificError => _hasWidgetSpecificError;
  String get serverError => _serverError;
  String get authorizationError => _authorizationError;
  String get connectionError => _connectionError;
  String get otherError => _otherError;
  bool get isLoadingMore => _isLoadingMore;

  // This is for the drawer animator
  int pageIndex = 0;
  bool isCollapsed = true;
  bool isCancelNavButtonClicked = false;
  Flushbar flushbar;

  setFlushbar(Flushbar flushbar){
    flushbar = flushbar;
  }

  setPageIndex(int index) {
    pageIndex = index;
    notifyListeners();
  }

  setCollapsedState() {
    if (!isCollapsed) {
      isCollapsed = !isCollapsed;
      isCancelNavButtonClicked = true;
      notifyListeners();
    } else {
      isCollapsed = !isCollapsed;
      isCancelNavButtonClicked = false;
      notifyListeners();
    }
  }

  set setIsLoadingMore(bool value) {
    _isLoadingMore = value;
  }

  fetchInitialData(){
    // print('I am here');
  }

  void setBusy(bool state){
    _isBusy = state;
    notifyListeners();
  }

  void setHasWidgetSpecificError() {
    _hasWidgetSpecificError = true;
    notifyListeners();
  }

  bool setCustomBusy(bool state){
    notifyListeners();
    return state;
  }

  void normalizeErrorState() {
    _hasWidgetSpecificError = false;
    _serverError = null;
    _authorizationError = null;
    _connectionError = null;
  }

//  void setGenericErrorMessage(Response response){
//    if(response.statusCode == 500) {
//      ServerError serverError = ServerError.fromJson(response.data);
//
//      _errorType = ErrorType.SERVER_ERROR;
//      _serverError = serverError.error;
//    } else if(response.statusCode == 401){
//      _errorType = ErrorType.AUTHORIZATION_ERROR;
//      _authorizationError = response.data['message'];
//    } else if(response.statusCode == 600) {
//      // Take note that 600 is not a real status code, it is used here to denote network failure
//      _errorType = ErrorType.CONNECTION_ERROR;
//      _connectionError = response.data['message'];
//    } else if(response.statusCode != 200){
//      _errorType = ErrorType.OTHER_ERROR;
//      _otherError = response.data['message'];
//    }
//  }
}
