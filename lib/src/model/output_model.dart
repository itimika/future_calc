import 'package:flutter/material.dart';

class OutputModel with ChangeNotifier{
  String _output = '0';  // 表記
  String _tmp = '';  // オペランド

  bool _isNullAtAll = true;  // 何も入力されていない
  bool _isNullAtTmp = true;  // オペランドが入力されていない
  int frag = 0;  // 操作ブロックの判別に使う
  bool showHelp = false;  // サジェスト画像を表示

  List<String> _rpnStack = [];
  List<String> _operatorStack = [];

  String get output => _output;

  // 数字の入力
  void inputNo(String no) {
    String _no;
    _no = no;
    if (no == '.') {
      // ピリオド入力だけで「0.」という表記にする.
      if (_isNullAtTmp) {
        _no = '0.';
      }
      // オペランドに２つ以上ピリオドを付けるのを避ける.
      if (_tmp.contains('.')) {
        _no = '';
      }
    }

    _tmp = _tmp + _no;
    _isNullAtTmp = false;

    if (_isNullAtAll) {
      _output = _tmp;
      _isNullAtAll = false;
    } else {
      // 「0」 → 「a」と入力した際, 「0a」という表記を避ける.
      double.tryParse(_output) == 0 && _output != '0.'
          ? _output = _no
          : _output = _output + _no;
    }
    notifyListeners();

  }

  // 演算子の入力
  void inputOpe(String operator) {
    if (!_isNullAtTmp) {
      _rpnStack.add(_tmp);
      // 演算子の重複を防ぐ
      if (double.tryParse(_rpnStack.last) != null) {
        if (_operatorStack.isNotEmpty) {
          if ('×÷'.contains(_operatorStack.last)) {
            print('through!');
            _rpnStack.add(_operatorStack.last);
            _operatorStack.removeLast();
          }
        }
        _operatorStack.add(operator);
        _output = _output + operator;
      }
      _tmp = '';
      _isNullAtTmp = true;
      notifyListeners();
    }
  }

  // 計算
  double _calculate() {
    final _noStack = <double>[];
    if (_rpnStack.isNotEmpty && _rpnStack.length > 0) {
      print(_rpnStack);
      while(_rpnStack.isNotEmpty) {
        try {
          _noStack.add(double.parse(_rpnStack.first));
        }
        on Exception catch(_) {
          final _len = _noStack.length;
          if ('+−×÷'.contains(_rpnStack.first)) {
            _noStack.add(
                _arithmeticOperation(
                  _noStack[_len-2],
                  _noStack[_len-1],
                  _rpnStack.first,
                ),
            );
            // ignore: cascade_invocations
            _noStack
              ..removeAt(_len-2)
              ..removeAt(_len-2);
          }
        }
        _rpnStack.removeAt(0);
      }
    }
    return _noStack.first;
  }

  // 演算
  double _arithmeticOperation(
      double no1, double no2, String operand
      ) { switch(operand) {
        case '+' : return no1 + no2;
        case '−' : return no1 - no2;
        case '×' : return no1 * no2;
        case '÷' : return no1 / no2;
        default  : return 0;
      }
  }

  // 答えを出力
  void outputAns() {
    if (!_isNullAtTmp) {
      if (_rpnStack.length >= 1) {
      _rpnStack.add(_tmp);
      _isNullAtAll = true;

      while (_operatorStack.isNotEmpty) {
        _rpnStack.add(_operatorStack[_operatorStack.length-1]);
        _operatorStack.removeLast();
      }

        _output = _calculate().toString();
        clear(out: false);
      }
    }
    notifyListeners();
  }

  void clear({bool out: true}) {
    _output = out ? '0' : _output;
    _tmp = '';
    _isNullAtAll = true;
    _isNullAtTmp = true;
    _rpnStack = [];
    _operatorStack = [];
    notifyListeners();
  }

  // 一つ入力を取り消す
  void backDelete() {
    // 入力が無ければパス
    if (!_isNullAtAll) {
      if (_tmp.isNotEmpty) {  // 数字入力の取り消し
        _tmp = _tmp.substring(0, _tmp.length-1);
      } else {  // 演算子入力の取り消し
        if ('×÷'.contains(_rpnStack.last)) {
          _tmp = _rpnStack[_rpnStack.length-2];
          _operatorStack
            ..removeLast()
            ..add(_rpnStack.last);
          _rpnStack
            ..removeLast()
            ..removeLast();
        } else {
          _tmp = _rpnStack.last;
          _rpnStack.removeLast();
          _operatorStack.removeLast();
        }
        _isNullAtTmp = false;
      }
      if (_output.length == 1) {
        _output = '0';
        _isNullAtTmp = true;
        _isNullAtAll = true;
      } else {
        _output = _output.substring(0, _output.length-1);
      }
      notifyListeners();
    }
  }

   void raiseAFrag(int idx) {
    if (frag == 0) {
      frag = idx;
      notifyListeners();
    }
  }

  void resetAFrag() {
    if (frag != 0) {
      frag = 0;
      notifyListeners();
    }
  }

  void changeHelp() {
    showHelp = ! showHelp;
    notifyListeners();
  }
}