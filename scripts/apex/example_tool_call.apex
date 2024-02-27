/** Example Function/Toool Call */
OAIChatClient.ChatRequest chatRequest = new OAIChatClient.ChatRequest();

chatRequest.messages = new OAIMessage[]{
    new OAIMessage('user', 'What is the weather like tomorrow in San Fran?')
};

OAIChatClient.Function getWeatherFn = new OAIChatClient.Function('get_weather');
getWeatherFn.description = 'Get the weather for a location';
getWeatherFn.parameters = new OAIChatClient.Parameters(
    new Map<String, Object>{
        'location' => OAIJsonSchema.str('The location to get the weather for'),
        'days' => OAIJsonSchema.num('The number of days to get the weather for')
    }
);

chatRequest.tools = new OAIChatClient.Tool[]{
    new OAIChatClient.Tool(
        getWeatherFn
    )
};

chatRequest.tool_choice = new OAIChatClient.ToolChoice(
   getWeatherFn
);

OAIChatClient.ChatResponse chatResponse = OAIChatClient.sendRequest(chatRequest);
Map<String, Object> fnArgs = (Map<String, Object>) chatResponse.choices[0].message.tool_calls[0].function.parseArgumentsUntyped();
System.debug(fnArgs.get('location'));



