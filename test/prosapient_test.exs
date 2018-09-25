defmodule ProsapientTest do
  use ExUnit.Case, async: true
  doctest Prosapient

  alias Prosapient.{
    Repo,
    Post,
    User
  }

  setup_all do
    {:ok, pid} = Prosapient.start(nil, nil)
    {:ok, [pid: pid]}
  end

  setup do
    on_exit(fn ->
      Repo.delete_all(Post)
      Repo.delete_all(User)
    end)
  end

  test "naive_aggregate_posts" do
    {:ok, alex} = Repo.insert(%User{name: "Alex"})
    {:ok, bob} = Repo.insert(%User{name: "Bob"})
    {:ok, tom} = Repo.insert(%User{name: "Tom"})

    Repo.insert(%Post{kind: "article", text: "Dolorem deleniti sequi ea.", user: alex})
    Repo.insert(%Post{kind: "image", text: "Dolorem deleniti sequi ea.", user: alex})
    Repo.insert(%Post{kind: "link", text: "Dolorem deleniti sequi ea.", user: alex})
    Repo.insert(%Post{kind: "link", text: "Dolorem deleniti sequi ea.", user: alex})

    Repo.insert(%Post{kind: "article", text: "Dolorem deleniti sequi ea.", user: bob})
    Repo.insert(%Post{kind: "image", text: "Dolorem deleniti sequi ea.", user: bob})
    Repo.insert(%Post{kind: "image", text: "Dolorem deleniti sequi ea.", user: bob})

    Repo.insert(%Post{kind: "article", text: "Dolorem deleniti sequi ea.", user: tom})
    Repo.insert(%Post{kind: "image", text: "Dolorem deleniti sequi ea.", user: tom})
    Repo.insert(%Post{kind: "link", text: "Dolorem deleniti sequi ea.", user: tom})
    Repo.insert(%Post{kind: "link", text: "Dolorem deleniti sequi ea.", user: tom})
    Repo.insert(%Post{kind: "promotion", text: "Dolorem deleniti sequi ea.", user: tom})
    Repo.insert(%Post{kind: "promotion", text: "Dolorem deleniti sequi ea.", user: tom})

    assert User.naive_aggregate_posts() == [
             %{articles_count: 1, images_count: 1, links_count: 2, user_id: 1},
             %{articles_count: 1, images_count: 2, user_id: 2},
             %{
               articles_count: 1,
               images_count: 1,
               links_count: 2,
               promotions_count: 2,
               user_id: 3
             }
           ]
  end
end
