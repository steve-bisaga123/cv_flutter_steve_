import 'package:material_ui/material_ui.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const CvApp());

const blue = Color(0xFF4263EB);
const ink = Color(0xFF17233C);
const muted = Color(0xFF68758D);

class CvApp extends StatefulWidget {
  const CvApp({super.key});

  @override
  State<CvApp> createState() => _CvAppState();
}

class _CvAppState extends State<CvApp> {
  bool connected = false;

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'CV de Steve',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: blue),
      scaffoldBackgroundColor: const Color(0xFFF4F6FB),
    ),
    home: connected
        ? MainPage(onLogout: () => setState(() => connected = false))
        : LoginPage(onLogin: () => setState(() => connected = true)),
  );
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.onLogin});
  final VoidCallback onLogin;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final form = GlobalKey<FormState>();

  void login() {
    if (form.currentState!.validate()) widget.onLogin();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 430),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Icon(Icons.badge_rounded, color: blue, size: 48),
                    const SizedBox(height: 12),
                    Text(
                      'Bienvenue',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Connectez-vous pour découvrir mon profil.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      key: const Key('identifier-field'),
                      decoration: const InputDecoration(
                        labelText: 'Identifiant',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      validator: (v) => v == null || v.trim().isEmpty
                          ? 'Veuillez saisir votre identifiant.'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      key: const Key('password-field'),
                      obscureText: true,
                      onFieldSubmitted: (_) => login(),
                      decoration: const InputDecoration(
                        labelText: 'Mot de passe',
                        prefixIcon: Icon(Icons.lock_outline),
                      ),
                      validator: (v) => v == null || v.isEmpty
                          ? 'Veuillez saisir votre mot de passe.'
                          : null,
                    ),
                    const SizedBox(height: 20),
                    FilledButton(
                      key: const Key('login-button'),
                      onPressed: login,
                      child: const Text('Se connecter'),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Démo locale : tout identifiant et mot de passe non vides fonctionnent. Aucun serveur.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: muted, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.onLogout});
  final VoidCallback onLogout;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;
  final pages = const [CvPage(), FamilyPage(), ContactPage()];
  final titles = const ['Mon CV', 'Ma famille', 'Contact'];

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(titles[index]),
      actions: [
        IconButton(
          tooltip: 'Se déconnecter',
          onPressed: widget.onLogout,
          icon: const Icon(Icons.logout),
        ),
      ],
    ),
    body: IndexedStack(index: index, children: pages),
    bottomNavigationBar: NavigationBar(
      selectedIndex: index,
      onDestinationSelected: (value) => setState(() => index = value),
      destinations: const [
        NavigationDestination(icon: Icon(Icons.badge_outlined), label: 'CV'),
        NavigationDestination(
          icon: Icon(Icons.people_outline),
          label: 'Famille',
        ),
        NavigationDestination(
          icon: Icon(Icons.alternate_email),
          label: 'Contact',
        ),
      ],
    ),
  );
}

class CvPage extends StatelessWidget {
  const CvPage({super.key});

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      Card(
        color: blue,
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 46,
                backgroundImage: AssetImage('assets/images/profile.jpeg'),
              ),
              const SizedBox(height: 16),
              const FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  'BISAGA KAVUNA STEVE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Étudiant en Informatique Appliquée à la Gestion des Entreprises (LIAGE) à l’ISIG Goma.',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Text(
                'Curieux et motivé, je m’intéresse à la création d’applications utiles et aux nouvelles technologies.',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      _section('Formation', Icons.school_outlined, [
        const ListTile(
          title: Text('Formation en informatique'),
          subtitle: Text('Diplome dEtat en Commercial de Gestion en 2024'),
        ),
      ]),
      _section('Expériences et projets', Icons.work_outline, [
        const ListTile(
          title: Text('Application CV Flutter'),
          subtitle: Text('Projet personnel • Développement mobile'),
        ),
        const ListTile(
          title: Text('Projets de formation'),
          subtitle: Text('Programmation et travail en équipe'),
        ),
      ]),
      _section('Compétences', Icons.auto_awesome_outlined, [
        _tags(['Flutter', 'Dart', 'Git', 'Travail en équipe']),
      ]),
      _section('Langues', Icons.translate, [
        _tags(['Français', 'Anglais']),
      ]),
      _section('Centres d’intérêt', Icons.favorite_border, [
        _tags(['Technologie', 'Création numérique', 'Apprentissage']),
      ]),
    ],
  );
}

class FamilyPage extends StatelessWidget {
  const FamilyPage({super.key});
  static const members = [
    ('Parent', 'Papa BISAGA KAVUNA STEVE', Icons.person),
    ('Parent', 'Maman BISAGA Alice Uriel', Icons.person),
    ('Membre 3', 'Frère BISAGA Jean', Icons.face),
    ('Membre 4', 'Sœur BISAGA Ursule', Icons.face),
  ];

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      Text(
        'Les personnes qui comptent',
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      const SizedBox(height: 8),
      const Text('Quelques mots sur ma famille.'),
      const SizedBox(height: 16),
      ...members.map(
        (m) => Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color(0xFFEAF0FF),
              child: Icon(m.$3, color: blue),
            ),
            title: Text(m.$1),
            subtitle: Text(m.$2),
            trailing: const Icon(Icons.favorite, color: Colors.pinkAccent),
          ),
        ),
      ),
      const SizedBox(height: 8),
      const Text(
        'Remplacez les exemples par les noms et photos de votre famille.',
        style: TextStyle(color: muted, fontSize: 13),
      ),
    ],
  );
}

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  Future<void> open(BuildContext context, Uri uri) async {
    if (!await launchUrl(uri) && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Impossible d’ouvrir ce lien.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      Card(
        color: const Color(0xFFEAF0FF),
        child: ListTile(
          leading: const Icon(Icons.chat_bubble_outline, color: blue),
          title: const Text('Restons en contact'),
          subtitle: const Text('Une question ou une opportunité ?'),
        ),
      ),
      _contact(
        Icons.email_outlined,
        'E-mail',
        'stevelouis234567@gmail.com',
        () => open(context, Uri(scheme: 'mailto', path: 'stevelouis234567@gmail.com')),
      ),
      _contact(
        Icons.phone_outlined,
        'Téléphone',
        '+243 975 095 999',
        () => open(context, Uri(scheme: 'tel', path: '+243975095999')),
      ),
      _contact(
        Icons.location_on_outlined,
        'Adresse',
        'Ville de Goma,RDC Congo',
      ),
      _contact(
        Icons.link,
        'GitHub',
        'steve_bisaga123',
        () => open(context, Uri.https('steve_bisaga123')),
      ),
      _contact(
        Icons.work_outline,
        'LinkedIn',
        'linkedin.com',
        () => open(context, Uri.https('www.linkedin.com')),
      ),
      const SizedBox(height: 8),
      const Text(
        'Remplacez les coordonnées de démonstration par les vôtres.',
        style: TextStyle(color: muted, fontSize: 13),
      ),
    ],
  );
}

Widget _section(String title, IconData icon, List<Widget> children) => Padding(
  padding: const EdgeInsets.only(top: 18),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Icon(icon, color: blue),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      Card(
        child: Column(mainAxisSize: MainAxisSize.min, children: children),
      ),
    ],
  ),
);

Widget _tags(List<String> labels) => Padding(
  padding: const EdgeInsets.all(12),
  child: Wrap(
    spacing: 8,
    children: labels.map((label) => Chip(label: Text(label))).toList(),
  ),
);

Widget _contact(
  IconData icon,
  String label,
  String value, [
  VoidCallback? onTap,
]) => Card(
  child: ListTile(
    leading: Icon(icon, color: blue),
    title: Text(label),
    subtitle: Text(value),
    trailing: onTap == null ? null : const Icon(Icons.open_in_new),
    onTap: onTap,
  ),
);
