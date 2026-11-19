import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cv_flutter_steve/main.dart';

void main() {
  testWidgets('login requires an identifier and password', (tester) async {
    await tester.pumpWidget(const CvApp());

    await tester.tap(find.byKey(const Key('login-button')));
    await tester.pumpAndSettle();

    expect(find.text('Veuillez saisir votre identifiant.'), findsOneWidget);
    expect(find.text('Veuillez saisir votre mot de passe.'), findsOneWidget);
  });

  testWidgets('demo login opens profile, family and contact pages', (
    tester,
  ) async {
    await tester.pumpWidget(const CvApp());

    await tester.enterText(
      find.byKey(const Key('identifier-field')),
      'visiteur',
    );
    await tester.enterText(find.byKey(const Key('password-field')), 'demo');
    await tester.tap(find.byKey(const Key('login-button')));
    await tester.pumpAndSettle();

    expect(find.text('BISAGA KAVUNA STEVE'), findsOneWidget);

    await tester.tap(find.text('Famille'));
    await tester.pumpAndSettle();
    expect(find.text('Les personnes qui comptent'), findsOneWidget);

    await tester.tap(find.text('Contact'));
    await tester.pumpAndSettle();
    expect(find.text('Restons en contact'), findsOneWidget);

    await tester.tap(find.byTooltip('Se déconnecter'));
    await tester.pumpAndSettle();
    expect(find.text('Bienvenue'), findsOneWidget);
  });
}
