- write unit tests
- %beacon doesn't update screen on update (prob. impossible w/ Sail+Rudder)
√ set up %eyre endpoints:  /beacon, /sentinel, /beacon-send
- add hark-store notifications?
√ provide %docs documentation
- provide %l10n localization
√ improve visual styling
- merge into one repo, two desks
- API key for website+URL, but for now assuming local to server
- track multiple URLs, clear old requests if changes

---


I think changing your self-url is not handled correctly
if you submit with new url the requests stack up on the other end and toggling any one of the urls toggles the singular representation back on your end
there are also security issues with the fact anyone can subscribe to /status/whatever
it ought to track the ship a url relates to rather than just a url so it can know whether someone is allowed
and changing your url in beacon should result in all sentinels removing that url I think


[%give %kick paths ~]
the last field is a (unit ship) and if it's null it kicks everyone


      ::
      ::  Set the agent's authentication URL.
        %auto
      ?>  =(our.bowl src.bowl)
      ?:  =(auto url.appeal)
        `this
      =/  ship-list=(list ship)  ~(tap in ~(key by bids))
      =/  cards=(list card)
        %+  turn  ship-list
        |=  =ship
        ^-  card
        [%pass /beacon/(scot %t auto) %agent [ship %sentinel] %leave ~]
      =.  cards
        %+  weld  cards
        %+  turn  ship-list
        |=  =ship
        ^-  card
        =/  =wire  /beacon/(scot %t url.appeal)
        =/  =path  /status/(scot %t url.appeal)
        [%pass wire %agent [ship %sentinel] %watch path]
      [cards this(auto url.appeal, bids (~(run by bids) |=(* %clotho)))]
      ::
      ::  Authentication for our URL has been requested.  (local only)
        %send
      ?>  =(our.bowl src.bowl)
      ?:  (~(has by bids) ship.appeal)
        `this
      :_  this(bids (~(put by bids) ship.appeal %clotho))
      ~&  >>>  :*  %pass
              /beacon/(scot %t auto)
              %agent  [ship.appeal %sentinel]  %watch
              /status/(scot %t auto)
      ==
      :~  :*  %pass
              /beacon/(scot %t auto)
              %agent  [ship.appeal %sentinel]  %watch
              /status/(scot %t auto)
      ==  ==
