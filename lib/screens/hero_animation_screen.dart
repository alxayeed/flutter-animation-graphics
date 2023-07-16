import 'package:flutter/material.dart';

class HeroAnimationScreen extends StatefulWidget {
  const HeroAnimationScreen({Key? key}) : super(key: key);

  @override
  State<HeroAnimationScreen> createState() => _HeroAnimationScreenState();
}

class _HeroAnimationScreenState extends State<HeroAnimationScreen> {
  final List<Person> persons = [
    Person(name: "Jack", age: 20, icon: "🐱"),
    Person(name: "Jones", age: 22, icon: "😾"),
    Person(name: "Captain Cook", age: 45, icon: "🙀"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animations"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          iconSize: 30.0,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        const SizedBox(height: 20.0),
        const Center(
          child: Text(
            'Hero Animations',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20.0),
        Expanded(
          child: SizedBox(
            child: ListView.builder(
                itemCount: persons.length,
                itemBuilder: (context, index) {
                  Person person = persons[index];
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PersonDetails(person: person),
                        ),
                      );
                    },
                    leading: Hero(
                      tag: person.name,
                      child: Text(
                        person.icon,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                        ),
                      ),
                    ),
                    title: Text(person.name),
                    subtitle: Text("${person.age} years old"),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  );
                }),
          ),
        ),
      ]),
    );
  }
}

class Person {
  final String name;
  final int age;
  final String icon;

  Person({
    required this.name,
    required this.age,
    required this.icon,
  });
}

class PersonDetails extends StatelessWidget {
  final Person person;
  const PersonDetails({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          flightShuttleBuilder: (flightContext, animation, flightDirection,
              fromHeroContext, toHeroContext) {
            switch (flightDirection) {
              case HeroFlightDirection.push:
                return ScaleTransition(
                  scale:
                      animation.drive(Tween<double>(begin: 0.0, end: 1.0).chain(
                    CurveTween(
                      curve: Curves.bounceInOut,
                    ),
                  )),
                  child: Material(
                    color: Colors.transparent,
                    child: toHeroContext.widget,
                  ),
                );
              case HeroFlightDirection.pop:
                return Material(
                  color: Colors.transparent,
                  child: fromHeroContext.widget,
                );
            }
          },
          tag: person.name,
          child: Text(
            person.icon,
            style: const TextStyle(fontSize: 50),
          ),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            Text(person.name,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 10.0),
            Text(
              "${person.age} years old",
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
