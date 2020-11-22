
import 'package:test/test.dart';

bool _loading ;
class deleyer{
   loadingtimer(){
    _loading = false;
  }
}


void main(){
  test('loding timer testing',(){
    var name = 'abolfazl';

    expect(name, equals('abolfazl'));
  });

}