-module (translation).

%% API exports
-export ([get_translation/1]).

%%====================================================================
%% API functions
%%====================================================================
get_translation(Word) ->
    io:format("~p ~n", [Word]),
    inets:start(),
    {ok, RequestId} = httpc:request(get, {"http://fanyi.dict.cn/search.php?q=" ++ Word, []}, [], [{sync, false}]),
    receive 
        {http, {RequestId, Result}} -> 
            {{"HTTP/1.1",200,"OK"},_Headers, Body} = Result,
            io:format("body: ~p ~n", [Body]),
            Content = binary:part(Body, {1, byte_size(Body) - 2}),
            Decoded = jsx:decode(Content),
            io:format("~p ~n", [Decoded]),
            file:write_file(Word ++ "-translation.txt", Content)
    after 1000 -> timeout 
    end.

%%====================================================================
%% Internal functions
%%====================================================================





