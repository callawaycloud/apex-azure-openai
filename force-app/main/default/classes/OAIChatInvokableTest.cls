@isTest
public class OAIChatInvokableTest {
  @isTest
  static void testProcessMessages_ValidData_SuccessfulExecution() {
    // Given

    HttpResponse mockResponse = new HttpResponse();
    mockResponse.setStatusCode(200);
    mockResponse.setBody(
      '{"id":"123","created":1631234567,"model":"gpt-3.5-turbo","prompt_filter_results":[],"choices":[{"finish_reason":"stop","index":0,"message":{"role":"system","content":"Hello, how can I assist you today?"},"content_filter_results":null}],"usage":{"prompt_tokens":10,"completion_tokens":20,"total_tokens":30}}'
    );

    // Set up the mock HTTP callout
    Test.setMock(
      HttpCalloutMock.class,
      new OAIChatClientTest.MockHttpResponseGenerator(mockResponse)
    );

    OAIChatInvokable.Params param = new OAIChatInvokable.Params();
    param.system_message = 'Test System Message';
    OAIMessage message = new OAIMessage('user', 'Hello');
    param.messages = new List<OAIMessage>{ message };
    param.temperature = 0.7;
    param.max_tokens = 300;

    List<OAIChatInvokable.Params> request = new List<OAIChatInvokable.Params>{
      param
    };

    Test.startTest();

    // When
    List<OAIChatInvokable.Result> results = OAIChatInvokable.processMessages(
      request
    );

    Test.stopTest();

    // Then
    System.assert(!results.isEmpty(), 'Results should not be empty');
    System.assertEquals(
      'stop',
      results[0].FinishReason,
      'Finish reason does not match expected'
    );
    System.assertEquals(
      'Hello, how can I assist you today?',
      results[0].CompletionContent,
      'Completion content does not match expected'
    );
  }
}
