
; *.clj extension used merely for the syntax highlighting of this notes files

=== Objective:

Rails:

- Build Rails application which provides /search endpoint

- This endpoint takes first query parameter engine and value can be google or bing or both

- This endpoint takes second query parameter text which can any string passed by user

- Based on engine parameters, it should google search or bing search and returns data

- if query parameter is both then it should aggregate result from both search engine and return data


=== Google

- Search path: "https://www.google.com/search?"
- Params:
  -> "q="       : search term, URI encoded [URI.encode('pokemon kabuto') => "pokemon%20kabuto"]
  -> "start="   : results offset (page) [10, 20, ...] | optional

{ Examples }
- https://www.google.com/search?q=pokemon%20kabuto
- https://www.google.com/search?q=pokemon+kabuto&start=10
- https://www.google.com/search?q=pokemon+kabuto&start=20


=== Bing

- Search path: "https://www.bing.com/search?"
- Params:
  -> "q="       : search term, URI encoded [URI.encode('pokemon kabuto') => "pokemon%20kabuto"]
  -> "first="   : results offset (page) [0, 10, 20...] | required


https://www.bing.com/search?q=kabuto+pokemon


{ Examples }
- https://www.bing.com/search?q=pokemon%20kabuto&first=0
- https://www.bing.com/search?q=pokemon%20kabuto&first=10
- https://www.bing.com/search?q=pokemon%20kabuto&first=20


=== Rails config

rails new quaerit
--api
--skip-action-mailer
--skip-action-mailbox
--skip-active-record
--skip-active-storage
--skip-action-cable
--skip-action-text
--skip-sprockets
--skip-test

-> RUN
rails new . --api --skip-action-mailer --skip-action-mailbox --skip-active-record --skip-active-storage --skip-action-cable --skip-action-text --skip-sprockets --skip-test

-> Models & Controllers

- engine: engine=1, engine=2, engine=1,2 | 1=google, 2=bing

rails g scaffold Search engine:string query:string offset:integer --skip-template-engine

-> URL request sample

- http://127.0.0.1:3000/search?query=kabuto&offset=10&engines=1,2
