import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/utils/Utils.dart';

void main(){


  test('test if correct day of the week from timestamp', () {
    var timeStamp=1663858800;
    var date= getDayOfTheWeek(timeStamp);
    expect(date, 'Thursday');
  });

  test('test if wrong day of the week from timestamp', () {
    var timeStamp=1663858800;
    var date= getDayOfTheWeek(timeStamp);
    expect(date, 'Friday');
  });


  test('test if date is understandable from time stamp',() {
  var timestamp = 1663858800;  //Sep 22, 2022
  var result = formatToHumanReadableDate(timestamp);
  expect(result,"Sep 22, 2022");
  });


  test('test if date is understandable but wrong',() {
  var timestamp = 1663858800; //Sep 22, 2022
  var result = formatToHumanReadableDate(timestamp);
  expect(result, "Sep 20, 2022");
  });


  test('test if temperature is in readable format',() {
  var temp = 4.392;
  var result = formatTemperature(temp);
  expect(result,"4.4°");
  });


  test('test if temperature is in readable format and wrong',() {
  var temp = 4.392;
  var result = formatTemperature(temp);
  expect(result,"4.3°");
  });
}