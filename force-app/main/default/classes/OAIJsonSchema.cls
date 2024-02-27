public with sharing class OAIJsonSchema {
  public static Map<String, Object> str(String description) {
    return new Map<String, Object>{
      'type' => 'string',
      'description' => description
    };
  }

  public static Map<String, Object> bool(String description) {
    return new Map<String, Object>{
      'type' => 'boolean',
      'description' => description
    };
  }

  public static Map<String, Object> num(String description) {
    return new Map<String, Object>{
      'type' => 'number',
      'description' => description
    };
  }

  public static Map<String, Object> obj(
    String description,
    Map<String, Object> properties
  ) {
    return new Map<String, Object>{
      'type' => 'object',
      'description' => description,
      'properties' => properties
    };
  }

  public static Map<String, Object> arr(
    String description,
    Map<String, Object> items
  ) {
    return new Map<String, Object>{
      'type' => 'array',
      'description' => description,
      'items' => items
    };
  }

  public static Map<String, Object> literal(
    String description,
    List<String> values
  ) {
    return new Map<String, Object>{
      'type' => 'string',
      'description' => description,
      'enum' => values
    };
  }
}
