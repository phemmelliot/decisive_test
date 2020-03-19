import 'package:decisive_app/base/base_model.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseWidget<T extends BaseModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget child) builder;
  final Function fetchInitialData;
  final bool initData;
  final Widget child;
  final T model;
  final bool inheritModel;
  final T inheritedModel;

  const BaseWidget({
    Key key,
    this.builder,
    this.initData = false,
    this.fetchInitialData,
    this.model,
    this.child,
    this.inheritModel = false,
    this.inheritedModel,
  }) : super(key: key);

  @override
  _BaseWidgetState<T> createState() => _BaseWidgetState<T>();
}

class _BaseWidgetState<T extends BaseModel> extends State<BaseWidget<T>> {
  T model;
  Flushbar flushBar;

  @override
  void initState() {
    super.initState();

    model = widget.model;

    fetchData();

    if (widget.fetchInitialData != null) {
      widget.fetchInitialData();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void fetchData() async {
    if (widget.initData == true) {
      bool isSuccessful = await model.fetchInitialData();
      if (isSuccessful) {
      } else {
        // Helper.showGenericError(() => model.fetchInitialData(), context, model, flushBar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print('BaseWidget Build ${widget.model.runtimeType}');

    if (widget.inheritModel) {
      return ChangeNotifierProvider<T>.value(
        value: widget.inheritedModel,
        child: Consumer<T>(
          builder: widget.builder,
          child: widget.child,
        ),
      );
    }

    return ChangeNotifierProvider<T>(
      create: (context) => model,
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}
