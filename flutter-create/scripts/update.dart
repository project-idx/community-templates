import 'dart:convert';
import 'dart:io';

void main(List<String> args) async {
  final samples = File('./scripts/assets/samples.json');

  if (!samples.existsSync()) exit(1);

  final str = await samples.readAsString();
  final items = (jsonDecode(str) as List).cast<Map<String, dynamic>>();

  final template = File('./idx-template.json');
  const encoder = JsonEncoder.withIndent(' ');
  final json = encoder.convert(createTemplate(items));
  await template.writeAsString(json);
}

Map<String, Object?> createTemplate(List<Map<String, dynamic>> samples) {
  return {
    "name": "Flutter",
    "description": "Flutter create template",
    "categories": ["Mobile"],
    "icon":
        "https://storage.googleapis.com/cms-storage-bucket/4fd5520fe28ebf839174.svg",
    "publisher": "Rody Davis",
    "host": {"virtualization": true},
    "params": [
      {
        "id": "template",
        "name": "Template",
        "type": "enum",
        "default": "app",
        "options": {
          "app": "App",
          "module": "Module",
          "package": "Package",
          "plugin": "Plugin",
          "plugin_ffi": "Plugin (FFI)",
          "skeleton": "Skeleton",
        },
      },
      {
        "id": "sample",
        "name": "Sample",
        "type": "enum",
        "default": "none",
        "options": {
          "none": "None",
          for (final item in samples) ...{
            if (item
                case {
                  "id": String id,
                  "element": String name,
                }) ...{
              id: name,
            },
          },
        },
      },
      {
        "id": "blank",
        "name": "Empty",
        "type": "boolean",
        "default": "false",
      },
      {
        "id": "platforms",
        "name": "Platforms",
        "type": "text",
        "default": "web,android",
      },
      // {
      //   "id": "org",
      //   "name": "Organization",
      //   "type": "text",
      // },
      // {
      //   "id": "project-name",
      //   "name": "Project Name",
      //   "type": "text",
      // },
      // {
      //   "id": "project-description",
      //   "name": "Project Description",
      //   "type": "text",
      // },
    ],
  };
}
