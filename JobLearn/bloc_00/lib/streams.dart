Stream<String> get _messagesGen async* {
  yield "First";
  await Future.delayed(Duration(seconds: 1));
  yield "Second";
  await Future.delayed(Duration(seconds: 1));
  yield "Third";
}
