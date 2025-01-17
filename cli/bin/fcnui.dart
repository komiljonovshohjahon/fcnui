import 'package:fcnui/src/src.dart';

Future<void> main(List<String> arguments) async {
  await myMain(arguments);
}

Future<void> myMain(List<String> arguments) async {
  final args = arguments.map((e) => e.toLowerCase()).toList();
  if (args.isEmpty || args[0].isEmpty) {
    logger('Invalid command. Use: fcnui <command>');
    close();
  }

  final firstArg = arguments[0];

  ///These commands must come before all other commands, and must call close() at the end
  switch (firstArg) {
    case "help":
      helpCommand();
      close();
    case "version":
      versionCommand();
      close();
  }

  final isFlutter = isFlutterProject(kPubspecYaml);
  if (isFlutter == null) {
    close();
  }

  //Initialize dependencies
  final ApiClient apiClient = ApiClient();

  final initJson = InitJson(path: kFlutterCnUiJson);
  initJson.initJsonFile();

  if (firstArg == "init") {
    final initialization = Initialization(initJson: initJson);
    initialization.init(kDefaultComponentsFolder);
    close();
  }

  if (!initJson.isInitialized) {
    logger('Please run "fcnui init" first');
    close();
  }

  final componentMethods =
      ComponentMethods(initJson: initJson, apiClient: apiClient);

  switch (firstArg) {
    case "add":
      final components = arguments.sublist(1);
      if (components.isEmpty) {
        logger('Invalid command. Use: fcnui add <componentName>');
        close();
      }
      await componentMethods.add(components);
      close();
    case "remove":
      final components = arguments.sublist(1);
      if (components.isEmpty) {
        logger('Invalid command. Use: fcnui remove <componentName>');
        close();
      }
      componentMethods.remove(components);
      close();
    default:
      logger("Invalid command. Use: 'fcnui help' for more information.");
      close();
  }
}
