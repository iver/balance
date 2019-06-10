# Balance
[![Build Status](https://travis-ci.org/iver/balance.svg?branch=master)](https://travis-ci.org/iver/balance)

![Balance Logo](assets/balance.png)

* [Installation](#installation)
  - [Checking the installed version of Elixir](#elixir)
  - [Technical Documentation](#doc)
* [Clone project](#clone)
* [Howto execute](#exec) 
* [Howto run test](#test)
* [The executable](#binary)

<a name="installation"></a>

## Installation

First you need to install [Elixir](https://elixir-lang.org/install.html).

Second is highly recommended to add Elixir’s bin path to your PATH environment variable to ease development.

On Windows, there are [instructions for different versions](http://www.computerhope.com/issues/ch000549.htm) explaining the process.

On Unix systems, you need to [find your shell profile file](https://unix.stackexchange.com/a/117470/101951), and then add to the end of this file the following line reflecting the path to your Elixir installation:

```
export PATH="$PATH:/path/to/elixir/bin"
```

<a name="elixir"></a>

### Checking the installed version of Elixir

Once you have Elixir installed, you can check its version by running `elixir --version.`

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `balance` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:balance, "~> 0.0.1"}
  ]
end
```

In this case, with private repository. The better way is adding `balance` as a github library as follow:

```elixir
def deps do
  [
	 {:balance, git: "git@github.com:iver/balance.git", tag: "v0.0.1", app: false}
  ]
end
```

If the repository is private though, you may need to specify the private URL `git@github.com:YOUR_ACCOUNT/kv.git`. In any case, Mix will be able to fetch it for you as long as you have the proper credentials.

Using Git repositories for internal dependencies is somewhat discouraged in Elixir. Remember that the runtime and the Elixir ecosystem already provide the concept of applications. As such, we expect you to frequently break your code into applications that can be organized logically, even within a single project.


<a name="doc"></a>

### Documentation

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc) and published on [HexDocs](https://hexdocs.pm).The docs can be found at [https://iver.mx/doc/](https://iver.mx/doc/).

### Database Settings

Because one issue is can configure your own team with different goal settings and bonus. The program

<a name="clone"></a>

## Clone project

If you wish to develop, test or run the project it is necessary to clone the project:

```
# From gitlab  
$ git clone git@gitlab.com:iver14/balance.git ~/Workspace/balance

# From github
$ git clone git@github.com:iver/balance.git ~/Workspace/balance
```

<a name="exec"></a>

## Howto execute

Go to project path:

```
$ cd ~/Workspace/balance

$ iex -S mix
Erlang/OTP 21 [erts-10.2.3] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [hipe] [dtrace]

Interactive Elixir (1.8.1) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> 
:ok
iex(2)> 

```

<a name="test"></a>
## Howto run test

```
$ cd ~/Workspace/balance

$ mix test --trace


```

<a name="binary"></a>

## The executable

After the build was done you can use the binary:

```
$ ./balance -h

NAME
	 Balance -- Resuelve balance command line interface

SYNOPSIS
	 balance [--file(default)] <file to parse>

AUTHOR
	 Iván Jaimes
	 ivan@iver.mx

DESCRIPTION
	 Calculate Resuelve FC players' salary.

    
OPTIONS
	 -f | --file <file_json> 		Parse json file named <file_json>.
	 -t | --text <text_json> 		Parse json text.
	 -h | --help 		Shows the help.
	 -v | --version 	Shows the gcli version.
```



