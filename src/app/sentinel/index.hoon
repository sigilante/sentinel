::  Sentinel index
::
/-  *sentinel
/+  rudder
::
^-  (page:rudder urls action)
|_  [=bowl:gall * requests=urls]
++  argue
  |=  [headers=header-list:http body=(unit octs)]
  ^-  $@(brief:rudder action)
  =/  args=(map @t @t)
    ?~(body ~ (frisk:rudder q.u.body))
  ::  get action (%okay or %yeet)
  ?~  what=(~(get by args) 'what')
    ~
  ::  get URL
  ?~  who=(~(get by args) 'who')
    ~
  ?+  u.what  ~
      ?(%okay %yeet)
    ?:  ?=(%yeet u.what)
      [%yeet `url`u.who]
    [%okay `url`u.who]
  ==
::
++  final  (alert:rudder (cat 3 '/' dap.bowl) build)
::
++  build
  |=  $:  arg=(list [k=@t v=@t])
          msg=(unit [o=? =@t])
      ==
  ^-  reply:rudder
  |^  [%page page]
  ::
  ++  icon-color  "blue"
  ::
  ++  style
    '''
    body { 
      display: flex; 
      width: 100%; 
      height: 100%; 
      justify-content: center; 
      align-items: center; 
      font-family: "Inter", sans-serif;
      margin: 0;
      -webkit-font-smoothing: antialiased;
    }
    main {
      width: 100%;
      max-width: 500px;
    }
    button {
      -webkit-appearance: none;
      border: none;
      outline: none;
      border-radius: 100px; 
      font-weight: 500;
      font-size: 1rem;
      padding: 12px 24px;
      cursor: pointer;
    }
    button:hover {
      opacity: 0.8;
    }
    button.inactive {
      background-color: #F4F3F1;
      color: #626160;
    }
    button.active {
      background-color: #000000;
      color: white;
    }
    a {
      text-decoration: none;
      font-weight: 600;
      color: rgb(0,177,113);
    }
    a:hover {
      opacity: 0.8;
    }
    .none {
      display: none;
    }
    .block {
      display: block;
    }
    code, .code {
      font-family: "Source Code Pro", monospace;
    }
    .bg-green {
      background-color: #12AE22;
    }
    .bg-white {
      background-color: #fff;
    }
    .text-white {
      color: #fff;
    }
    h3 {
      font-weight: 600;
      font-size: 1rem;
      color: #626160;
    }
    form {
      display: flex;
      justify-content: space-between;
      margin-block-end: 0;
    }
    form button, button[type="submit"] {
      border-radius: 10px;
    }
    input {
      font-family: "Source Code Pro", monospace;
      border: 1px solid #ccc;
      border-radius: 6px;
      padding: 12px;
      font-size: 12px;
      font-weight: 600;
    }
    .flex {
      display: flex;
    }
    .col {
      flex-direction: column;
    }
    .align-center {
      align-items: center;
    }
    .justify-between {
      justify-content: space-between;
    }
    .grow {
      flex-grow: 1;
    }
    p {
      margin-block-start: 0;
      margin-block-end: 0;
    }
    #instructions p {
      margin: 1rem 0;
    }
    @media screen and (max-width: 480px) {
      main {
        padding: 1rem;
      }
    }
    @media screen and (min-width: 480px) {
      .md:block {
        display: block;
      }
    }
    '''
  ::
  ++  authorize-button
    '''
     document.getElementById('instructions').classList = 'none'; 
     document.getElementById('authorize').classList = 'block';
     document.getElementById('auth-button').classList = 'active';
     document.getElementById('instructions-button').classList = 'inactive';
    '''
  ::
  ++  instructions-button
    '''
     document.getElementById('authorize').classList = 'none'; 
     document.getElementById('instructions').classList = 'block';
     document.getElementById('auth-button').classList = 'inactive';
     document.getElementById('instructions-button').classList = 'active';
    '''
  ::
  ++  page
    ^-  manx
    ;html
      ;head
        ;title:"%sentinel"
        ;meta(charset "utf-8");
        ;meta(name "viewport", content "width=device-width, initial-scale=1");
        ;link(href "https://fonts.googleapis.com/css2?family=Inter:wght@400;600&family=Source+Code+Pro:wght@400;600&display=swap", rel "stylesheet");
        ;style:"{(trip style)}"
      ==
      ;body
        ;main
          ;h2:"Sentinel"
          ;button(id "auth-button", class "active", onclick "{(trip authorize-button)}"): Authorize
          ;button(id "instructions-button", class "inactive", onclick "{(trip instructions-button)}"): Instructions
          ;div(id "instructions", class "none")
            Grant permissions to URLs using the Beacon agent for website
            authentication.  The website will initiate an authorization or you can
            pre-approve (but the URL is not checked).

            If you expect to see a website listed below that does not show up, you
            should re-initiate the login or authentication attempt at the website.

            Some websites that use Beacon and Sentinel:

            ;a/"https://vienna.earth"
              ; Vienna HyperText smart canvas
            ==
            ;br;

            This app was built using ~palfun-foslup’s Rudder library.
          ==
          ;div(id "authorize")
            ;+  ?~  msg  ;p:""
                ?:  o.u.msg  ::TODO  lightly refactor
                  ;p.green:"{(trip t.u.msg)}"
                ;p.red:"{(trip t.u.msg)}"
            ;div
              ;form(method "post", class "col")
                ;div(style "font-weight: bold")
                  ;h3:"URL"
                ==
                ;div(class "flex grow")
                  ;div(class "flex grow")
                    ;input(type "text", name "who", placeholder "https://urbit.org", class "flex grow");
                  ==
                  ;div
                    ;button(type "submit", name "what", value "okay", class "bg-green text-white"): Authorize
                  ==
                ==
              ==
              ;h3:"Authorized URLs"
              ::  Clotho spins the thread of life; here she tallies requests.
              ;*  clotho
              ::  Lachesis measures the span of life; here she tracks approvals.
              ;*  lachesis
              ::  Atropos cuts the thread of life; here she reaps rejections.
              ;*  atropos
            ==
          ==
        ==
      ==
    ==
  ::
  ++  spin-the-thread
    |=  =url
    ^-  manx
    ;form(method "post")
      ;button(type "submit", name "what", value "okay"):"✓"
      ;input(type "hidden", name "who", value (trip url));
    ==
  ::  Reject the request.
  ++  cut-with-shears
    |=  =url
    ^-  manx
    ;form(method "post")
      ;button(type "submit", name "what", value "yeet", class "bg-white"):"Revoke"
      ;input(type "hidden", name "who", value (trip url));
    ==
  ::
  ++  peers
    |=  [fate=?(%clotho %lachesis %atropos) mer=(list url)]
    ^-  (list manx)
    %+  turn  mer
    |=  =url
    ^-  manx
    =/  ack=(unit ^fate)  (~(get by requests) url)
    ;div(class "flex align-center justify-between")
      ::  Site
      ;div(class "code", style "border: 1px solid #ccc; padding: 12px; border-radius: 6px;font-size: 12px;font-weight: 600;"):"{(trip `@t`url)}"
      ::  Symbol
      ;div(class "flex justify-between align-center")
        ;div(class "none md:block")
          ;+  (relation fate ack)
        ==
        ::  Button
        ;+  ?:  ?=(%lachesis fate)
              ;div
                ;+  (cut-with-shears url)
              ==
            ;div
              ;+  (spin-the-thread url)
            ==
          ==
    ==
  ::
  ::  Lachesis measures the span of life; here she tracks approved URLs.
  ++  lachesis
    ^-  (list manx)
    %+  peers  %lachesis
    %+  skim  ~(tap in ~(key by requests))
    |=  =url
    ?=(%lachesis (need (~(get by requests) url)))
  ::
  ::  Clotho spins the thread of life; here she tracks requesting URLs.
  ++  clotho
    ^-  (list manx)
    %+  peers  %clotho
    %+  skim  ~(tap in ~(key by requests))
    |=  =url
    ?=(%clotho (need (~(get by requests) url)))
  ::
  ::  Atropos cuts the thread of life; here she tracks rejected URLs.
  ++  atropos
    ^-  (list manx)
    %+  peers  %atropos
    %+  skim  ~(tap in ~(key by requests))
    |=  =url
    ?=(%atropos (need (~(get by requests) url)))
  ::
  ++  relation
    |=  [fate=?(%clotho %lachesis %atropos) ack=(unit fate)]
    =.  ack
      ?.  ?=(%lachesis fate)  ~
      `(fall ack %clotho)
    ^-  manx  ~+
    ?-  fate
        %atropos
        ;p: Rejected
    ::
        %lachesis
      ;p: Approved
    ::
        %clotho
      ;p: Requested
    ==
  --
--
