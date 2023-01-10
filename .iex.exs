# Will be using `ANSI`
Application.put_env(:elixir, :ansi_enabled, true)

# Letting people know what iex.exs they are using
IO.puts(
  # <> IO.ANSI.blink_slow()
  IO.ANSI.magenta_background() <>
    IO.ANSI.bright() <>
    IO.ANSI.underline() <>
    "Using global .iex.exs (located in ~/.iex.exs)" <> IO.ANSI.reset()
)

# Get queue length for the IEx process
# This is fun to see while playing with nodes
queue_length = fn ->
  self()
  |> Process.info()
  |> Keyword.get(:message_queue_len)
end

prefix =
  IO.ANSI.light_black_background() <>
    IO.ANSI.green() <>
    "%prefix" <>
    IO.ANSI.reset()

counter =
  IO.ANSI.light_black_background() <>
    IO.ANSI.green() <>
    "-%node-(%counter)" <>
    IO.ANSI.reset()

info = IO.ANSI.light_blue() <> "✉ #{queue_length.()}" <> IO.ANSI.reset()
last = IO.ANSI.yellow() <> "➤➤➤" <> IO.ANSI.reset()

alive =
  IO.ANSI.bright() <>
    IO.ANSI.yellow() <>
    IO.ANSI.blink_rapid() <>
    "⚡" <>
    IO.ANSI.reset()

default_prompt = prefix <> counter <> " | " <> info <> " | " <> last
alive_prompt = prefix <> counter <> " | " <> info <> " | " <> alive <> last

inspect_limit = 5_000
history_size = 100

eval_result = [:green, :bright]
eval_error = [:red, :bright]
eval_info = [:blue, :bright]

# Configuring IEx
IEx.configure(
  inspect: [limit: inspect_limit],
  width: 100,
  history_size: history_size,
  colors: [
    syntax_colors: [
      number: :light_yellow,
      atom: :light_cyan,
      string: :green,
      boolean: [:light_blue],
      nil: [:magenta, :bright]
    ],
    ls_directory: :cyan,
    ls_device: :yellow,
    doc_code: :green,
    doc_inline_code: :magenta,
    doc_headings: [:cyan, :underline],
    doc_title: [:cyan, :bright, :underline],
    eval_result: eval_result,
    eval_error: eval_error,
    eval_info: eval_info
  ],
  alive_prompt: alive_prompt,
  default_prompt:
    [
      # ANSI CHA, move cursor to column 1
      "\e[G",
      :light_magenta,
      # plain string
      "🧪 iex",
      ">",
      :white,
      :reset
    ]
    |> IO.ANSI.format()
    |> IO.chardata_to_string()
)

# Phoenix Support
import_if_available(Plug.Conn)
import_if_available(Phoenix.HTML)

phoenix_app =
  :application.info()
  |> Keyword.get(:running)
  |> Enum.reject(fn {_x, y} ->
    y == :undefined
  end)
  |> Enum.find(fn {x, _y} ->
    x |> Atom.to_string() |> String.match?(~r{_web})
  end)

# Check if phoenix app is found
case phoenix_app do
  nil ->
    IO.puts("No Phoenix App found")

  {app, _pid} ->
    IO.puts("Phoenix app found: #{app}")

    ecto_app =
      app
      |> Atom.to_string()
      |> (&Regex.split(~r{_web}, &1)).()
      |> Enum.at(0)
      |> String.to_atom()

    exists =
      :application.info()
      |> Keyword.get(:running)
      |> Enum.reject(fn {_x, y} ->
        y == :undefined
      end)
      |> Enum.map(fn {x, _y} -> x end)
      |> Enum.member?(ecto_app)

    # Check if Ecto app exists or running
    case exists do
      false ->
        IO.puts("Ecto app #{ecto_app} doesn't exist or isn't running")

      true ->
        IO.puts("Ecto app found: #{ecto_app}")

        # Ecto Support
        import_if_available(Ecto.Query)
        import_if_available(Ecto.Changeset)

        # Alias Repo
        repo = ecto_app |> Application.get_env(:ecto_repos) |> Enum.at(0)

        quote do
          alias unquote(repo), as: Repo
        end
    end
end
