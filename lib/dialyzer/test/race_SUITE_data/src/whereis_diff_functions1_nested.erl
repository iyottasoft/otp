%% This tests that the race condition detection between whereis/register
%% is robust w.r.t. having the calls in separate functions.

-module(whereis_diff_functions1_nested).
-export([test/2]).

test(AnAtom, Fun) ->
  start(AnAtom, Fun).

start(AnAtom, Fun) ->
  case whereis(AnAtom) of
    undefined ->
      Pid = spawn(Fun),
      race1(AnAtom, Pid);
    P when is_pid(P) ->
      true
  end.

race1(Atom, Pid) ->
  race2(Atom, Pid).

race2(Atom, Pid) ->
  register(Atom, Pid).
