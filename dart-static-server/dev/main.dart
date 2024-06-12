import 'dart:io';

/// Starts a static file HTTP server on the specified [port].
///
/// Binds to IPv4 loopback address for local development.
/// Returns a [Future] that completes with the running [HttpServer].
Future<HttpServer> startServer(int port) async {
  return HttpServer.bind(InternetAddress.loopbackIPv4, port); 
}

/// Handles an incoming [HttpRequest] by serving a static file.
///
/// If the requested file exists in [webRoot], it's served with the appropriate content type.
/// Otherwise, sends a "Not Found" (404) or "Internal Server Error" (500) response.
Future<void> handleRequest(HttpRequest request, String webRoot) async {
  final path = request.uri.path == '/' ? '/index.html' : request.uri.path; // Default to index.html
  final filePath = '$webRoot$path';                                       // Construct full file path

  try {
    final file = File(filePath);
    if (await file.exists()) {
      await serveFile(request, file);
    } else {
      sendNotFound(request);
    }
  } on FileSystemException { // Catch specific file system errors
    sendNotFound(request);   // Treat missing files as 404
  } catch (e) {              // Catch all other errors
    sendInternalError(request);
  }
}

/// Serves a static file from the [file] to the [request].
///
/// Sets the appropriate content type header based on the file extension.
Future<void> serveFile(HttpRequest request, File file) async {
  final bytes = await file.readAsBytes();
  request.response
    ..headers.contentType = getContentType(file.path)
    ..add(bytes)
    ..close();  // Efficiently closes without waiting for client acknowledgement
}

/// Sends a "Not Found" (404) HTTP response to the [request].
void sendNotFound(HttpRequest request) {
  request.response
    ..statusCode = HttpStatus.notFound
    ..write('Not found')
    ..close();
}

/// Sends an "Internal Server Error" (500) HTTP response to the [request].
void sendInternalError(HttpRequest request) {
  request.response
    ..statusCode = HttpStatus.internalServerError
    ..write('Internal server error')
    ..close();
}

/// Determines the appropriate `ContentType` for a file based on its [path].
///
/// Includes a comprehensive map of common file extensions and their MIME types.
/// Defaults to `text/plain` for unknown extensions.
ContentType getContentType(String path) {
  final extension = path.split('.').last;
  final contentTypes = {
    'html': ContentType.html,
    'css': ContentType('text', 'css'),
    'js': ContentType('text', 'javascript'),
    'jpg': ContentType('image', 'jpeg'),
    'jpeg': ContentType('image', 'jpeg'),
    'png': ContentType('image', 'png'),
    'gif': ContentType('image', 'gif'),
    'svg': ContentType('image', 'svg+xml'),
    'ico': ContentType('image', 'x-icon'),
    'pdf': ContentType('application', 'pdf'),
    'txt': ContentType('text', 'plain'),
    'xml': ContentType('text', 'xml'),
    'csv': ContentType('text', 'csv'),
    'json': ContentType('application', 'json'),
    'yaml': ContentType('text', 'yaml'),
    'md': ContentType('text', 'markdown'),
    'webp': ContentType('image', 'webp'),
  };
  return contentTypes[extension] ?? ContentType('text', 'plain');
}

/// Main entry point of the static file server.
///
/// Configures the server to listen on port 9002 and serve files from the "public" directory.
void main() async {
  const int port = 9002;
  const String webRoot = 'public';

  final server = await startServer(port);
  print('Server listening on http://localhost:$port');

  await for (final request in server) {
    await handleRequest(request, webRoot);
  }
}

