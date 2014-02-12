# SockjsEcho

A port of the [SockJS Echo example](https://github.com/sockjs/sockjs-erlang/blob/master/examples/cowboy_echo.erl) to [Elixir](http://elixir-lang.org/).  With the extra logging I added you can see that each connection has it's own process. 

To fetch the needed dependencies and run the server

    mix deps.get
    mix run --no-halt

Then open a web browser (all the way back to IE6!) to http://localhost:8080/
