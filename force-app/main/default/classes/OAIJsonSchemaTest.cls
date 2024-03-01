@isTest
public class OAIJsonSchemaTest {
  @isTest
  static void testJsonSchema() {
    Map<String, Object> obj = OAIJsonSchema.obj(
      'an object',
      new Map<String, Object>{
        'name' => OAIJsonSchema.str('users name'),
        'age' => OAIJsonSchema.num('users age'),
        'user_type' => OAIJsonSchema.literal(
          'user type',
          new List<String>{ 'admin', 'user' }
        ),
        'is_active' => OAIJsonSchema.bool('is active'),
        'post_ids' => OAIJsonSchema.arr('post ids', OAIJsonSchema.str(null))
      }
    );
    string result = '{"properties":{"post_ids":{"items":{"type":"string"},"description":"post ids","type":"array"},"is_active":{"description":"is active","type":"boolean"},"user_type":{"enum":["admin","user"],"description":"user type","type":"string"},"age":{"description":"users age","type":"number"},"name":{"description":"users name","type":"string"}},"description":"an object","type":"object"}';
    System.assertEquals(result, JSON.serialize(obj));
  }
}
