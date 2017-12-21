## GET /users
Index.

### Example

#### Request
```
GET /users HTTP/1.1
Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5
Content-Length: 0
Host: www.example.com
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 225
Content-Type: application/json; charset=utf-8
ETag: W/"82550939ba471bc66447c19caa2eb22a"
X-Request-Id: 308a815c-46c9-49ad-a64b-5eb59443af6e
X-Runtime: 0.096537

[
  {
    "id": 1,
    "created_at": "2017-12-21T15:08:33.928Z",
    "updated_at": "2017-12-21T15:08:33.928Z",
    "name": "ユーザー1"
  },
  {
    "id": 2,
    "created_at": "2017-12-21T15:08:33.933Z",
    "updated_at": "2017-12-21T15:08:33.933Z",
    "name": "ユーザー2"
  }
]
```

## GET /users/:id
Show.

### Example

#### Request
```
GET /users/2 HTTP/1.1
Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5
Content-Length: 0
Host: www.example.com
```

#### Response
```
HTTP/1.1 200
Cache-Control: max-age=0, private, must-revalidate
Content-Length: 111
Content-Type: application/json; charset=utf-8
ETag: W/"2c3a4c4e3f061c7f04859cfdc02250ec"
X-Request-Id: ca1c9657-d218-48d5-9fe5-61143e5c8998
X-Runtime: 0.024198

{
  "id": 2,
  "created_at": "2017-12-21T15:08:34.083Z",
  "updated_at": "2017-12-21T15:08:34.083Z",
  "name": "ユーザー4"
}
```
