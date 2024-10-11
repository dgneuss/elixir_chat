defmodule ElixirChat.OpenaiChat do
  alias OpenaiEx
  alias OpenaiEx.Chat
  alias OpenaiEx.ChatMessage

  def send_message_to_openai(message) do
    IO.inspect("response from open")
    openai = System.fetch_env!("OPENAI_API_KEY") |> OpenaiEx.new()
    IO.inspect("user message:")
    IO.inspect(message)

    # Ensure messages is an array of objects with role and content
    messages = [%{role: "user", content: message}]

    chat_req = Chat.Completions.new(%{model: "gpt-4o", temperature: 0, messages: messages})

    response = Chat.Completions.create!(openai, chat_req)
    IO.inspect("response:")
    IO.inspect(response)
     
    assistant_message = List.first(response["choices"])["message"]["content"]
    IO.inspect("assistant:")
    IO.inspect(assistant_message)
    {:ok, assistant_message}
  end

  def get_completion(openai = %OpenaiEx{}, cc_req = %{}) do
    openai
    |> Chat.Completions.create!(cc_req)
    # for debugging
    #    |> IO.inspect()
    |> Map.get("choices")
    |> List.first()
    |> Map.get("message")
    |> Map.get("content")
  end
end