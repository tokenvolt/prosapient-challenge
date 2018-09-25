# Prosapient Challenge

## System dependencies

  * [asdf version manager](https://github.com/asdf-vm/asdf)
  * [SQLite3](https://www.sqlite.org/download.html)

## Installation

  * Run `asdf install` to install erlang and elixir
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * `mix test` to run tests

## Test assignments

1. `lib/prosapient.ex:31`
2. `lib/prosapient/user.ex:27` and `lib/prosapient/user.ex:66`
3. `lib/github/github.ex:8`
4. Elixir/Phoenix issues.

Ever since the day I discovered Elixir, I've been thoroughly looking for any serious drawbacks and I must say, that I have yet to see them. Sure, there are some objective issues in Elixir, as well as Erlang. For instance, it's not suited for heavy CPU calculations which is totally understandable, because it wasn't designed for that in the first place. You don't blame an elephant for not being able to jump, do you?

Nevertheless, there are tons of small issues. Let's look at them in more detail.

**Small community.** Comparing to JavaScript or any other scripting language Ruby, Python, etc. Elixir has still to grow and acquire adoption.

**Steep learning curve.** Which is actually much less steeper than in Erlang. It's really hard to start with Elixir if you don't have any or have a very small software developer experience. I've been working with a lot of smart junior developers, who tried Elixir in their spare time and I could clearly see that it was a real challenge for them.

**Lack of support for different 3rd party services.** Again this is not an issue for the majority of other languages, but it is usually a case for Elixir. Want to find a good and maintainable package for some service you need to use? You are not going to find it probably. Luckily, as I mentioned above, it is a small issue, because you can easily write it yourself.

Having those issues in mind and considering how young Elixir is (only 6 years), in my opinion, all of this is just a matter of time and maturity.
