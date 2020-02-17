class Person {
  String name;
  int age;

  Person(this.name, this.age);
  @override String toString() => '${name} of age ${age}';
}


class NamedArgumentClass {
  String id;
  NamedArgumentClass({ this.id });
  greet() => print('yo my id is $id');
}

int add(int a, int b) => a + b;

void main() {
  print('Yes ${add(1, 2)}');

  const a = 4;
  const b = 5;
  print(a + b*3);

  var p1 = Person("Seb", 18);
  print(p1);

  var ns = NamedArgumentClass(id: "YEET");
  ns.greet();
}