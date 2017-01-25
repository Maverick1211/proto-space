## Usersテーブル
|column      |  type|option               |
|:-----------|-----------|-----------:|
|id               |*integer*|null false   |
|username         | *string*|null false  ※add_index |
|email |*string*|null false               |
|password| *string*|null false            |
|confirm password |*string*|null false    |
|avatar |*string*|           |
|profile|*text*|   |
|position|*string*|    |
|occupation|*string*|      |

#### association
    has_many :protos
    has_many :likes



## Protosテーブル
|column      |  type|option|
|:-----------|-----------|-----------:|
|id |*integer*|null false|
|title| *string*|null false ※add_index|
|catchcopy| *string*|null false|
|concept| *text*|null false|
|user_id |*integer*|null false|

#### association
    has_many :likes
    has_many :images
    belongs_to :user



## Likesテーブル
|column      |  type|option           |
|:-----------|-----------|-----------:|
|id |*integer*|null false             |
|user_id |*integer*|null false  ※add_index |
|proto_id |*integer*|null false  ※add_index |

#### association
    belongs_to :user
    belongs_to :proto



## imagesテーブル
|column      |  type|option|
|:-----------|-----------|-----------:|
|id |*integer*|null false|
|image |*string*|null false|
|proto_id |*integer*|null false|
|role | *integer*|null false, default: 0 ※add_index|

#### association
    belongs_to :proto

#### enum
    enum role: { sub: 0, main: 1 }


## commentsテーブル
|column      |  type|option|
|:-----------|-----------|-----------:|
|id |*integer*|null false|
|text|*text*|null false|
|user_id |*integer*|null false|
|proto_id | *integer*|null false|

#### association
    belongs_to :user
    belongs_to :proto
