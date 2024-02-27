public class OAIMessage {
  @AuraEnabled
  @InvocableVariable(label='Role' description='User or System' required=true)
  public String role;
  @AuraEnabled
  @InvocableVariable(
    label='Content'
    description='Conent of the message'
    required=true
  )
  public String content;

  public OAIMessage() {
    this.role = 'user';
  }

  public OAIMessage(String role, String content) {
    this.role = role;
    this.content = content;
  }
}
