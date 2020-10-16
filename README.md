# Quaerit
Search Google ||(&amp;&amp;) Bing: Get results in json format

### 📍 Description
Quaerit (*He|She|It searches*) is a Ruby on Rails API application designed to search through Google and Bing (currently<sup>1</sup>) and retrieve the results in JSON.

#### How-To

- Quaerit search endpoint is `/search`
- Quaerit communication is done through `GET` requests
- Params:
  - `query`: search term to be looked up
  - `engines`(optional): comma separeted search engines to use (1=google, 2=bing) | default = 1
  - `offset`(optional): search results offset (pagination) | default = 0

- **examples**
  - [?query=shoegazed&offset=10&engines=1](https://quaerit.herokuapp.com/search?query=shoegazed&offset=10&engines=1)
  - [?query=giant squid&offset=10&engines=1](https://quaerit.herokuapp.com/search?query=giant+squid&offset=10&engines=2)
  - [?query=kabuto pokemon&offset=10&engines=1,2](https://quaerit.herokuapp.com/search?query=kabuto+pokemon&offset=10&engines=1,2)

<sup>1</sup>: Search *engines* can be easily added to support more services.

### 🌱 Live Test

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Quaerit @ Heroku](https://quaerit.herokuapp.com/)

### 💾 Run Local

    git clone git@github.com:Mini0n/quaerit.git
    cd quaerit
    bundle install
    rails s

### 🐞 Run Tests
    rspec

### ⚗️ Dependencies

- Ruby  2.6.5
- Rails 6.0.3
- multi_mxl
  #### Ubuntu/Debian

- `apt-get install build-essential patch ruby-dev zlib1g-dev liblzma-dev`

### 🧮 Design
- TODO
