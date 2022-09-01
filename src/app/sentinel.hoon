  ::  sentinel.hoon
::::  Grants perms to %sentinel process for authentication.
::
::    Maintains list of authenticated websites.
::
::    Scry endpoints:
::
::    y  /                (map url fate)
::
::    x  /undecided       (set url)
::    x  /approved        (set url)
::    x  /rejected        (set url)
::    x  /url/[url]       (unit fate)
::
/-  sentinel, beacon, hark=hark-store
/+  default-agent, dbug, verb, rudder
/~  pages  (page:rudder urls:sentinel action:sentinel)  /app/sentinel
|%
+$  versioned-state
  $%  state-zero
  ==
+$  state-zero  $:
      %zero
      requests=(map url:sentinel fate:sentinel)
    ==
+$  card  card:agent:gall
--
%-  agent:dbug
=|  state-zero
=*  state  -
^-  agent:gall
|_  =bowl:gall
+*  this     .
    default  ~(. (default-agent this %.n) bowl)
::
++  on-init
  ^-  (quip card _this)
  ~&  >  "%sentinel initialized successfully."
  :_  this
  :~  [%pass /eyre %arvo %e %connect [~ /'sentinel'] %sentinel]
  ==
::
++  on-save
  ^-  vase
  !>(state)
::
++  on-load
  |=  old-state=vase
  ^-  (quip card _this)
  =/  old  !<(versioned-state old-state)
  ?-  -.old
    %zero  `this(state old)
  ==
::
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  ?+    mark  (on-poke:default mark vase)
    ::
      %sentinel-action
    =/  action  !<(?([%what url:sentinel] [%okay url:sentinel] [%yeet url:sentinel]) vase)
    ~&  >>  "%sentinel-poke:  {<action>}"
    ~&  >>  "%sentinel-poke:  {<(scot %ud (jam +.action))>}"
    ?-    -.action
      ::
      ::  An incoming authentication request has been registered.
        %what
      ?:  (~(has by requests) +.action)
        `this
      `this(requests (~(put by requests) +.action %clotho))
      ::
      ::  A URL has been approved.  (local only)
        %okay
      ?>  =(our.bowl src.bowl)
      :_  this(requests (~(put by requests) +.action %lachesis))
          [%give %fact ~[/status/(scot %ud (jam +.action))] %beacon-appeal !>(`appeal:beacon`[%auth our.bowl])]~
      ::
      ::  A URL has been disapproved.  (local only)
        %yeet
      ?>  =(our.bowl src.bowl)
      :_  this(requests (~(put by requests) +.action %atropos))
          [%give %fact ~[/status/(scot %ud (jam +.action))] %beacon-appeal !>(`appeal:beacon`[%burn our.bowl])]~
    ==
  ::
    ::  %handle-http-request:  incoming from eyre
    ::
      %handle-http-request
    =;  out=(quip card _+.state)
      [-.out this(+.state +.out)]
    %.  [bowl !<(order:rudder vase) +.state]
    %-  (steer:rudder _+.state action:sentinel)
    :^    pages
        (point:rudder /[dap.bowl] & ~(key by pages))
      (fours:rudder +.state)
    |=  =action:sentinel
    ^-  $@  brief:rudder
        [brief:rudder (list card) _+.state]
    =^  caz  this
      (on-poke %sentinel-action !>(action))
    ['Processed succesfully.' caz +.state]
  ==
::
++  on-watch
  |=  =path
  ^-  (quip card _this)
  ~&  >  "%sentinel:  subscription from {<src.bowl>}."
  ~&  >>  path
  ?+  path  (on-watch:default path)
      [%http-response *]
    `this
    ::
      [%status =owl:sentinel *]
    =/  url  (@t (cue (need (slaw %ud i.t.path))))
    :_  this(requests (~(put by requests) url %clotho))
    =/  result  (~(gut by requests) url '')
    ~&  >  [%give %fact ~[~[~.status i.t.path]] %beacon-appeal !>(`appeal:beacon`[%burn our.bowl])]~
    ?:  ?=(%lachesis result)
      [%give %fact ~[~[~.status i.t.path]] %beacon-appeal !>(`appeal:beacon`[%auth our.bowl])]~
    [%give %fact ~[~[~.status i.t.path]] %beacon-appeal !>(`appeal:beacon`[%burn our.bowl])]~
  ==
++  on-leave  on-leave:default
++  on-peek
  |=  =path
  ^-  (unit (unit cage))
  ?>  =(our src):bowl
  |^  ?+  path  [~ ~]
        [%y ~]            (arc ~[%clotho %lachesis %atropos])
        [%x %undecided ~]
          %-  alp
          %-  ~(rep by requests)
          |=  [p=[a=url:sentinel b=fate:sentinel] q=(set url:sentinel)]
          ?:  ?=(%clotho b.p)  (~(put in q) a.p)  q
        [%x %approved ~]
          %-  alp
          %-  ~(rep by requests)
          |=  [p=[a=url:sentinel b=fate:sentinel] q=(set url:sentinel)]
          ?:  ?=(%lachesis b.p)  (~(put in q) a.p)  q
        [%x %rejected ~]
          %-  alp
          %-  ~(rep by requests)
          |=  [p=[a=url:sentinel b=fate:sentinel] q=(set url:sentinel)]
          ?:  ?=(%atropos b.p)  (~(put in q) a.p)  q
        [%x %url url:sentinel ~]
          ``noun+!>((~(get by requests) +>-.path))
      ==
  ::  scry results
  ++  arc  |=  l=(list url:sentinel)  ``noun+!>(`arch`~^(malt (turn l (late ~))))
  ++  alp  |=  s=(set url:sentinel)    ``noun+!>(s)
  ++  alf  |=  f=?           ``noun+!>(f)
  ++  ask  |=  u=(unit ?)  ?^(u (alf u.u) [~ ~])
  ::  data wrestling
  ++  nab  ~(got by requests)
  ::  set shorthands
  ++  sin  |*(s=(set) ~(has in s))
  ++  sit  |*(s=(set) ~(tap in s))
  ++  ski  |*([s=(set) f=$-(* ?)] (sy (skim (sit s) f)))
  --
::
++  on-agent
  |=  [=wire =sign:agent:gall]
  ^-  (quip card _this)
  ?+    wire  (on-agent:default wire sign)
      [%sentinel ~]
    ?+    -.sign  (on-agent:default wire sign)
        %watch-ack
      ?~  p.sign
        ((slog '%sentinel: Subscribe succeeded!' ~) `this)
      ((slog '%sentinel: Subscribe failed!' ~) `this)
    ==
  ==
::
++  on-arvo
|=  [=wire =sign-arvo]
  ^-  (quip card _this)
  ?.  ?=([%eyre %bound *] sign-arvo)
    (on-arvo:default [wire sign-arvo])
  ?:  accepted.sign-arvo
    %-  (slog leaf+"/sentinel bound successfully!" ~)
    `this
  %-  (slog leaf+"Binding /sentinel failed!" ~)
  `this
++  on-fail   on-fail:default
--
