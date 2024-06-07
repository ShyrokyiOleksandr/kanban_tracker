import 'dart:io';

/// Reads the content of a JSON file located at the specified [filePath].
///
/// This function reads the content of a JSON file located at the specified path
/// and returns it as a string. It is typically used in tests for reading JSON
/// files containing sample data or expected responses.
///
/// Parameters:
/// - [filePath]: The path to the JSON file relative to the project root.
///
/// Returns:
/// - A string containing the content of the JSON file.
String readJsonFile(String filePath) {
  // Get the current working directory path.
  String currentPath = Directory.current.path;

  // Adjust the path if the code is running from the test directory.
  if (currentPath.endsWith('/test')) {
    currentPath = currentPath.replaceAll('/test', '');
  }

  // Read the content of the JSON file and return it.
  return File('$currentPath/test/$filePath').readAsStringSync();
}
