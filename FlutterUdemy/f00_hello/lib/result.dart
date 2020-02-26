import 'package:flutter/cupertino.dart';

class Result extends StatelessWidget {
  final int score;

  Result(this.score);

  String get resultPhrase {
    print("Skore : $score");
    String resultText;
    if (score <= 30) {
      resultText = 'Nedobre porobene... skus esci raz.';
    } else if (score <= 50) {
      resultText = 'Esci ci kus chyba aby si bol sveg, skus znova.';
    } else if (score <= 70) {
      resultText = 'Si uz teraz poradne sveg dobre odpovede ;)°)°)';
    } else {
      resultText = 'PERFEKTNESKORE CIKOKSO pan myšak ďakuje za vote.';
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        resultPhrase,
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
