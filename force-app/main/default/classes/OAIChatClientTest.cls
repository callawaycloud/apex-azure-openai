@isTest
public class OAIChatClientTest {
  @isTest
  static void testSendRequest() {
    // Create a mock HTTP response
    HttpResponse mockResponse = new HttpResponse();
    mockResponse.setStatusCode(200);
    mockResponse.setBody(
      '{"id":"123","created":1631234567,"model":"gpt-3.5-turbo","prompt_filter_results":[],"choices":[{"finish_reason":"stop","index":0,"message":{"role":"system","content":"Hello, how can I assist you today?"},"content_filter_results":null}],"usage":{"prompt_tokens":10,"completion_tokens":20,"total_tokens":30}}'
    );

    // Set up the mock HTTP callout
    Test.setMock(
      HttpCalloutMock.class,
      new MockHttpResponseGenerator(mockResponse)
    );

    // Create a ChatRequest object
    OAIChatClient.ChatRequest request = new OAIChatClient.ChatRequest();
    OAIMessage message = new OAIMessage();
    message.role = 'system';
    message.content = 'Hello, how can I assist you today?';
    request.messages.add(message);

    // Call the sendRequest method
    OAIChatClient.ChatResponse response = OAIChatClient.sendRequest(request);

    // Verify the response
    System.assertEquals('123', response.id);
    System.assertEquals(1631234567, response.created);
    System.assertEquals('gpt-3.5-turbo', response.model);
    System.assertEquals(0, response.prompt_filter_results.size());
    System.assertEquals(1, response.choices.size());
    System.assertEquals('stop', response.choices[0].finish_reason);
    System.assertEquals(0, response.choices[0].index);
    System.assertEquals('system', response.choices[0].message.role);
    System.assertEquals(
      'Hello, how can I assist you today?',
      response.choices[0].message.content
    );
    System.assertEquals(null, response.choices[0].content_filter_results);
    System.assertEquals(10, response.usage.prompt_tokens);
    System.assertEquals(20, response.usage.completion_tokens);
    System.assertEquals(30, response.usage.total_tokens);
  }

  public class MockHttpResponseGenerator implements HttpCalloutMock {
    HttpResponse res;

    public MockHttpResponseGenerator(HttpResponse r) {
      res = r;
    }

    public HTTPResponse respond(HTTPRequest req) {
      return res;
    }
  }
}
