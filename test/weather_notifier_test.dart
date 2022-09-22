import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/viewmodel/HomePageModel.dart';

void main() {
  HomePageModel sut = HomePageModel();

  setUp(() => {});

  test(
    'Initial values',
    () {
      expect(sut.isRequestPending, false);
      expect(sut.weatherResponse, []);
    },
  );
  
  group('getCurrentWeather', () { 
    test('Get current weather using OpenWeatherService', () async{
      await sut.getLatestWeather();
      verify(()=> sut.openWeatherService.getCurrentWeather()).called(1);
    });
  });
}
