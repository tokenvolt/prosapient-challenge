defmodule Prosapient.User do
  use Ecto.Schema
  import Ecto.Query
  alias Prosapient.Post
  alias Prosapient.Repo

  schema "users" do
    field(:name, :string)
    timestamps()
  end

  def kind_mapper("article", quantity), do: %{articles_count: quantity}
  def kind_mapper("link", quantity), do: %{links_count: quantity}
  def kind_mapper("image", quantity), do: %{images_count: quantity}
  def kind_mapper("promotion", quantity), do: %{promotions_count: quantity}
  def kind_mapper(_, _), do: %{}

  @doc """
    Raw SQL query (this will work for MySQL, PostgreSQL and even for SQLite)

    SELECT users.id, posts.kind, count(*)
    FROM users
    INNER JOIN posts
    ON posts.user_id = users.id
    GROUP BY posts.kind, posts.user_id;
  """
  def naive_aggregate_posts do
    query =
      from(user in __MODULE__,
        join: post in Post,
        where: post.user_id == user.id,
        order_by: user.id,
        group_by: [post.kind, post.user_id],
        select: {user.id, post.kind, count(post.id)}
      )

    reducer = fn aggregation, acc -> Map.merge(acc, aggregation) end

    Repo.all(query)
    |> Enum.group_by(
      fn {user_id, _kind, _posts_count} -> user_id end,
      fn {user_id, kind, posts_count} ->
        %{user_id: user_id}
        |> Map.merge(kind_mapper(kind, posts_count))
      end
    )
    |> Map.values()
    |> Enum.map(fn user_aggregation ->
      user_aggregation |> Enum.reduce(%{}, reducer)
    end)
  end

  @doc """
    Raw SQL query (this a more sane way, works for MySQL and PostgreSQL, but not for SQLite)

    SELECT users.id,
      COUNT (*) FILTER (WHERE kind = 'article') AS articles_count,
      COUNT (*) FILTER (WHERE kind = 'promotion') AS promotions_count,
      COUNT (*) FILTER (WHERE kind = 'link') AS links_count,
      COUNT (*) FILTER (WHERE kind = 'image') AS images_count
    FROM users
    INNER JOIN posts
    ON posts.user_id = users.id
    GROUP BY users.id;
  """
  def aggregate_posts do
    query =
      from(user in __MODULE__,
        join: post in Post,
        where: post.user_id == user.id,
        group_by: user.id,
        select: {
          %{
            user_id: user.id,
            articles_count: fragment("COUNT (*) FILTER (WHERE kind = 'article')"),
            promotions_count: fragment("COUNT (*) FILTER (WHERE kind = 'promotion')"),
            links_count: fragment("COUNT (*) FILTER (WHERE kind = 'link')"),
            images_count: fragment("COUNT (*) FILTER (WHERE kind = 'image')")
          }
        }
      )

    Repo.all(query)
  end
end
