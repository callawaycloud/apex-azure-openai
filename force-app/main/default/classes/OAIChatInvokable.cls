/**
 * OAIChatInvokable
 * Source from https://github.com/callawaycloud/apex-azure-openai
 */
public class OAIChatInvokable {
  @InvocableMethod(
    label='OpenAI Chat'
    description='Sends an OpenAI Chat Request'
  )
  public static List<Result> processMessages(List<Params> request) {
    // Return list containing only our resulting message
    List<Result> results = new List<Result>{};
    for (Params r : request) {
      OAIChatClient.ChatResponse response = OAIChatClient.sendRequest(
        r.toRequest()
      );
      results.add(new Result(response));
    }

    return results;
  }

  public class Params {
    @InvocableVariable(
      label='System Message'
      description='System Role Message (shortcut)'
    )
    public String system_message;

    @InvocableVariable(
      label='Messages'
      description='Message Array'
      required=true
    )
    public List<OAIMessage> messages;

    @InvocableVariable(
      label='Temperature'
      description='Temperature for the model. Defaults to 0.7.'
    )
    public Decimal temperature = 0.7;

    @InvocableVariable(
      label='Max Tokens'
      description='Max number of tokens to generate. Defaults to 300.'
    )
    public Integer max_tokens = 300;

    public OAIChatClient.ChatRequest toRequest() {
      OAIChatClient.ChatRequest chatRequest = new OAIChatClient.ChatRequest();
      if (String.isNotBlank(this.system_message)) {
        OAIMessage systemMessage = new OAIMessage(
          'system',
          this.system_message
        );
        chatRequest.messages.add(systemMessage);
      }
      chatRequest.messages.addAll(this.messages);
      chatRequest.temperature = this.temperature;
      chatRequest.max_tokens = this.max_tokens;
      return chatRequest;
    }
  }

  public class Result {
    @InvocableVariable(
      label='Stop Reason'
      description='choices[0].message.content'
      required=true
    )
    public string FinishReason;

    @InvocableVariable(
      label='Completion Content'
      description='choices[0].message.content'
      required=true
    )
    public String CompletionContent;

    // TODO: Add Function Call support
    // @InvocableVariable(label='FunctionName' description='choices[0].message.content' required=false)
    // public Object FunctionName;

    // @InvocableVariable(label='FunctionName' description='choices[0].message.content' required=false)
    // public Map<String,String> FunctionArgs;

    public Result(OAIChatClient.ChatResponse response) {
      this.FinishReason = response.choices[0].finish_reason;
      this.CompletionContent = response.choices[0].message.content;
    }
  }
}
