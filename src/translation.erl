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
            io:format("~p ~n", [Result]) 
    after 1000 -> timeout 
    end.

%%====================================================================
%% Internal functions
%%====================================================================





