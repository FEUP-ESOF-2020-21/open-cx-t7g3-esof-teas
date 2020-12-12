import 'package:flutter_test/flutter_test.dart';
import '../lib/pages/keywords.dart';
import 'package:hello/classes/person.dart' as person;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mockito/mockito.dart';

class MockAttendee extends Mock implements person.Atendee {}


void main(){
 testWidgets('Choosing keywords as an attendee', (tester) async {
    //TODO mockAttendee
    MockAttendee mockAttendee = MockAttendee();
    List<String> interestsList = ['kw1', 'kw2', 'kw3'];
    await tester.pumpWidget(MaterialApp(home: chooseKeywords(mockAttendee, interestsList),));

    Finder keyword1 = find.text('kw1');
    Finder keyword2 = find.text('kw2');
    Finder keyword3 = find.text('kw3');
    await tester.tap(keyword1);
    await tester.pump();
    expect(keyword1, findsOneWidget);
    expect(keyword2, findsNothing);
    expect(keyword3, findsNothing);

  });
}