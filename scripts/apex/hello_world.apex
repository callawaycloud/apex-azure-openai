/** Example Function/Toool Call */
OAIChatClient.ChatRequest chatRequest = new OAIChatClient.ChatRequest();
chatRequest.max_tokens = 300;

chatRequest.messages = new OAIMessage[]{
    new OAIMessage('system', 'Your are a creative writer who specializes in software development humor'),
    new OAIMessage('user', 'Write a short poem about Salesforce software developement')
};

OAIChatClient.ChatResponse chatResponse = OAIChatClient.sendRequest(chatRequest);
String completion = chatResponse.choices[0].message.content;
System.debug(completion);