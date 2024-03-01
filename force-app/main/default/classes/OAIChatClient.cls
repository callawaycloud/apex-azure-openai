/**
 * OAIChatClient
 * Source from https://github.com/callawaycloud/apex-azure-openai
 */
public class OAIChatClient {
  public static ChatResponse sendRequest(ChatRequest request) {
    HttpRequest req = new HttpRequest();
    req.setEndpoint('callout:AzureOAIChat');
    req.setMethod('POST');
    req.setHeader('Content-Type', 'application/json');
    req.setTimeout(120000);

    req.setBody(JSON.serialize(request, true));
    Http http = new Http();
    HttpResponse res = http.send(req);

    if (res.getStatusCode() >= 400) {
      throw new CalloutException(
        'OpenAI API returned status code ' +
          res.getStatusCode() +
          ' with message: ' +
          res.getBody()
      );
    }
    ChatResponse response = (ChatResponse) JSON.deserialize(
      res.getBody(),
      ChatResponse.class
    );

    System.debug(res.getBody());

    return response;
  }

  public class ChatRequest {
    public List<OAIMessage> messages;
    /** Generation controls */
    public Decimal temperature;
    public Integer max_tokens;
    public String[] stop;
    public Integer seed;
    public Decimal frequency_penalty;
    public Decimal top_p;

    /* Function Calls */
    public Tool[] tools;
    public Object tool_choice;

    /* Depreciated */
    public Function[] functions;
    /* FunctionChoice | 'auto' | 'none' */
    public Object function_call;

    public ChatRequest() {
      this.messages = new List<OAIMessage>();
    }
  }

  public class Tool {
    public String type;
    public Function function;

    public Tool(Function function) {
      this.type = 'function';
      this.function = function;
    }
  }

  public class ToolChoice {
    public string type;
    public Object function;

    public ToolChoice(Boolean auto) {
      this.type = 'function';
      this.function = auto ? 'auto' : 'none';
    }

    public ToolChoice(Function fn) {
      this.type = 'function';
      this.function = new FunctionChoice(fn.name);
    }
  }

  public class FunctionChoice {
    public String name;
    public FunctionChoice(String name) {
      this.name = name;
    }
  }

  public class Function {
    public String name;
    public String description;
    public Parameters parameters;
    public Function(String name) {
      this.name = name;
    }
  }

  public class Parameters {
    public String type;
    /* JSON Schema */
    public Map<String, Object> properties;

    public Parameters(Map<String, Object> properties) {
      this.type = 'object';
      this.properties = properties;
    }
  }

  public class ChatResponse {
    public String id;
    public Integer created;
    public String model;
    public List<PromptFilterResults> prompt_filter_results;
    public List<Choices> choices;
    public Usage usage;
  }

  public class PromptFilterResults {
    public Integer prompt_index;
    public ContentFilterResults content_filter_results;
  }

  public class ContentFilterResults {
    public FilteredSeverity hate;
    public FilteredSeverity self_harm;
    public FilteredSeverity sexual;
    public FilteredSeverity violence;
  }

  public class FilteredSeverity {
    public Boolean filtered;
    public String severity;
  }

  public class Choices {
    public String finish_reason;
    public Integer index;
    public ResponseMessage message;
    public ContentFilterResults content_filter_results;
  }

  public class ResponseMessage {
    public String role;
    public String content;
    public ToolCall[] tool_calls;
  }

  public class ToolCall {
    public String id;
    public String type;
    public Function_Call function;
  }

  public class Function_Call {
    public String name;
    public String arguments;

    public Object parseArguments(Type classType) {
      return JSON.deserialize(arguments, classType);
    }

    public Object parseArgumentsUntyped() {
      return JSON.deserializeUntyped(arguments);
    }
  }

  public class Usage {
    public Integer prompt_tokens;
    public Integer completion_tokens;
    public Integer total_tokens;
  }
}
