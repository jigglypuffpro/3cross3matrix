import 'package:flutter/material.dart';

void main() {
  runApp(MatrixMultiplyApp());
}

class MatrixMultiplyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Matrix Multiplier',
      home: MatrixMultiplyScreen(),
    );
  }
}

class MatrixMultiplyScreen extends StatefulWidget {
  @override
  _MatrixMultiplyScreenState createState() => _MatrixMultiplyScreenState();
}

class _MatrixMultiplyScreenState extends State<MatrixMultiplyScreen> {

  List<List<int>> s = List.generate(3, (i) => List.filled(3, 0));
  List<List<int>> t = List.generate(3, (i) => List.filled(3, 0));
  List<List<int>> p = List.generate(3, (i) => List.filled(3, 0));

  void updateS(int row, int col) {
    setState(() {
      s[row][col] = (s[row][col] + 1) % 10;
    });
  }

  void updateT(int row, int col) {
    setState(() {
      t[row][col] = (t[row][col] + 1) % 10;
    });
  }

  void _multiplyMatrices() {
    setState(() {
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          p[i][j] = 0;
          for (int k = 0; k < 3; k++) {
            p[i][j] = (p[i][j] + s[i][k] * t[k][j]) % 10;
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Matrix Multiplier'),
        backgroundColor: Colors.yellow,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: List.generate(3, (row) => Row(
                    children: List.generate(3, (col) => _buildMatrixCell(s[row][col], row, col, updateS)),
                  )),
                ),
                SizedBox(width: 50),
                Column(
                  children: List.generate(3, (row) => Row(
                    children: List.generate(3, (col) => _buildMatrixCell(t[row][col], row, col, updateT)),
                  )),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _multiplyMatrices,
              child: Text('Multiply'),
            ),
            SizedBox(height: 20),
            Text("Result:", style: TextStyle(fontSize: 30)),
            SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (row) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (col) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("${p[row][col]}", style: TextStyle(fontSize: 40)),
                )),
              )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMatrixCell(int value, int row, int col, Function(int, int) onPressed) {
    return GestureDetector(
      onTap: () => onPressed(row, col),
      child: Container(

        width: 40,
        height: 40,



        decoration: BoxDecoration(
          border: Border.all(color: Colors.orange),

        ),
        child: Center(
          child: Text(
            value.toString(),
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}
