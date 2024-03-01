public class OAIJsonSchema {
  public static Map<String, Object> str(String description) {
    return createBaseSchema('string', description);
  }

  public static Map<String, Object> bool(String description) {
    return createBaseSchema('boolean', description);
  }

  public static Map<String, Object> num(String description) {
    return createBaseSchema('number', description);
  }

  public static Map<String, Object> obj(
    String description,
    Map<String, Object> properties
  ) {
    Map<String, Object> schema = createBaseSchema('object', description);
    if (properties != null) {
      schema.put('properties', properties);
    }
    return schema;
  }

  public static Map<String, Object> arr(
    String description,
    Map<String, Object> items
  ) {
    Map<String, Object> schema = createBaseSchema('array', description);
    if (items != null) {
      schema.put('items', items);
    }
    return schema;
  }

  public static Map<String, Object> literal(
    String description,
    List<String> values
  ) {
    Map<String, Object> schema = createBaseSchema('string', description);
    schema.put('enum', values);
    return schema;
  }

  private static Map<String, Object> createBaseSchema(
    String type,
    String description
  ) {
    Map<String, Object> schema = new Map<String, Object>{ 'type' => type };
    if (description != null) {
      schema.put('description', description);
    }
    return schema;
  }
}
