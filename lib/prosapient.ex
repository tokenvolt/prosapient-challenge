defmodule Prosapient do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      Prosapient.Repo
    ]

    opts = [strategy: :one_for_one, name: Prosapient.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @doc ~S"""
  A product of 2 lists.

  ## Examples

    iex> Prosapient.wrap_lists([1, 2], ["a", "b", "c"])
    [
      [a: 1, b: "a"],
      [a: 1, b: "b"],
      [a: 1, b: "c"],
      [a: 2, b: "a"],
      [a: 2, b: "b"],
      [a: 2, b: "c"]
    ]

  """
  def wrap_lists(first_list, second_list) do
    for suit <- first_list,
        rank <- second_list,
        do: [a: suit, b: rank]
  end
end
