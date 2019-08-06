*** Settings ***
Library           RequestsLibrary
Library           Collections
Library           OperatingSystem


*** Variable ***


*** Test Cases ***
Get_Requests_baidu
    Create Session    baidu    https://www.baidu.com
    ${res}    Get Request    baidu    /
    Should Be Equal As Strings    ${res.status_code}    200


Get_Requests_with_Param
    Create Session    httpbin    http://httpbin.org
    &{params}    Create Dictionary    key=value    key2=value2
    ${res}    Get Request  httpbin    /get    params=${params}
    Should Be Equal As Strings    ${res.status_code}    200
    ${jsondata}    To Json    ${res.content}
    Should Be Equal    ${jsondata['args']}    ${params}


Get_Requests_with_Json_Data
    # 实际情况很少
    Create Session  httpbin     http://httpbin.org
    &{data}    Create Dictionary    latitude=30.496346    longitude=-87.640356
    ${res}     Get Request  httpbin    /get    json=${data}
    Should Be Equal As Strings    ${res.status_code}    200
    Log    ${res.json()}
    # 这面这两行代码与上面一行效果等价
    ${jsondata}    To Json    ${res.content}
    Log    ${jsondata}

Get_TTPS_&_erify_Cert
    # 待学习
    [Tags]  get     get-cert
    Create Session    httpbin    https://httpbin.org    verify=True
    ${res}    Get Request    httpbin    /get
    Should Be Equal As Strings    ${res.status_code}    200


Post_Request_With_No_Data
    [Tags]  post
    Create Session    httpbin    http://httpbin.org
    ${res}=  Post Request    httpbin    /post
    Should Be Equal As Strings    ${res.status_code}    200


Put_Request_With_No_Data
    [Tags]  put
    Create Session  httpbin  http://httpbin.org
    ${res}=  Put Request  httpbin  /put
    Should Be Equal As Strings  ${res.status_code}  200


Post_Request_With_URL_Params
    [Tags]  post
    Create Session    httpbin    http://httpbin.org
    &{params}    Create Dictionary    key=value    key2=value2
    ${res}    Post Request    httpbin    /post    params=${params}
    Should Be Equal As Strings    ${res.status_code}    200
    ${jsondata}    To Json    ${res.content}
    Log    ${jsondata}
    Log     ${jsondata['args']}
    Should Be Equal    ${jsondata['args']}     ${params}

Put_Request_With_URL_Params
    [Tags]  put
    Create Session    httpbin    http://httpbin.org
    &{params}    Create Dictionary    key=value    key2=value2
    ${res}    Put Request    httpbin    /put    params=${params}
    Should Be Equal As Strings    ${res.status_code}    200

Post_With_Files
    [Tags]  post
    Create Session    httpbin    http://httpbin.org
    ${file_data}    Get File    ${CURDIR}${/}data.json
    ${file_data2}    Get File    ${CURDIR}${/}data2.json
    Log    ${file_data}
    &{files}    Create Dictionary    file=${file_data}    file2=${file_data2}
    ${res}    Post Request  httpbin    /post  files=${files}
    ${file}    To Json    ${res.json()['files']['file']}
    ${file2}    To Json    ${res.json()['files']['file2']}
    Dictionary Should Contain Key    ${file}    one
    Dictionary Should Contain Key    ${file}    two
    Dictionary Should Contain Key    ${file2}    name
    Dictionary Should Contain Key    ${file2}    num

Put_With_Files
    [Tags]  post
    Create Session    httpbin    http://httpbin.org
    ${file_data}    Get File    ${CURDIR}${/}data.json
    ${file_data2}    Get File    ${CURDIR}${/}data2.json
    Log    ${file_data}
    &{files}    Create Dictionary    file=${file_data}    file2=${file_data2}
    ${res}    Put Request  httpbin    /put  files=${files}
    ${file}    To Json    ${res.json()['files']['file']}
    ${file2}    To Json    ${res.json()['files']['file2']}
    Dictionary Should Contain Key    ${file}    one
    Dictionary Should Contain Key    ${file}    two
    Dictionary Should Contain Value    ${file2}    kobe bryant
    Dictionary Should Contain Value    ${file2}    lakers

Post_Requests_urlencode
    [Tags]  post
    Create Session  httpbin  http://httpbin.org
    &{data}     Create Dictionary    name=ChenBolin    age=24
    # &{headers}    Create Dictionary    Content-Type=application/x-www-form-urlencoded
    # ${res}    Post Request    httpbin    /post    data=${data}    headers=${headers}
    ${res}    Post Request    httpbin    /post    params=${data}
    Should Be Equal As Strings    ${res.status_code}    200
    Log    ${res.content}
    # Dictionary Should Contain Value    ${res.json()['form']}    ChenBolin
    # Dictionary Should Contain Value    ${res.json()['form']}    24

Put_Requests_urlencode
    [Tags]  put
    Create Session  httpbin  http://httpbin.org
    &{data}     Create Dictionary    name=ChenBolin    age=24
    &{headers}    Create Dictionary    Content-Type=application/x-www-form-urlencoded
    ${res}    Put Request    httpbin    /put    data=${data}    headers=${headers}
    Dictionary Should Contain Value    ${res.json()['form']}    ChenBolin
    Dictionary Should Contain Value    ${res.json()['form']}    24


Post_Requests_with_Json_Data
    [Tags]  post
    Create Session  httpbin     http://httpbin.org
    &{data}    Create Dictionary   latitude=30.496346  longitude=-87.640356
    ${res}     Post Request    httpbin    /post    json=${data}
    Should Be Equal As Strings    ${res.status_code}    200
    ${jsondata}    To Json    ${res.content}
    Log    ${jsondata}
    Log    ${jsondata['json']}
    Should Be Equal    ${jsondata['json']}     ${data}


Put_Requests_with_Json_Data
    [Tags]  put
    Create Session  httpbin    http://httpbin.org
    &{data}    Create Dictionary    latitude=30.496346    longitude=-87.640356
    ${res}     Put Request  httpbin  /put    json=${data}
    Should Be Equal As Strings    ${res.status_code}    200
    ${jsondata}    To Json    ${res.content}
    Should Be Equal    ${jsondata['json']}    ${data}


Head_Request
    [Tags]  head
    Create Session  httpbin  http://httpbin.org
    ${res}=  Head Request  httpbin  /headers
    Log    ${res.headers}
    Should Be Equal As Strings  ${res.status_code}  200


Options_Request
    [Tags]  options
    Create Session  httpbin  http://httpbin.org
    ${res}=  Options Request  httpbin  /headers
    Should Be Equal As Strings  ${res.status_code}  200
    Log    ${res.headers}
    Dictionary Should Contain Key  ${res.headers}  allow


Delete_Request_With_URL_Params
    [Tags]  delete
    Create Session  httpbin  http://httpbin.org
    &{params}=   Create Dictionary   key=value     key2=value2
    ${res}=  Delete Request  httpbin  /delete      ${params}
    Log    ${res.content}
    Should Be Equal As Strings  ${res.status_code}  200


Delete_Request_With_No_Data
    [Tags]  delete
    Create Session  httpbin  http://httpbin.org
    ${res}=  Delete Request  httpbin  /delete
    Log    ${res.content}
    Should Be Equal As Strings  ${res.status_code}  200


Delete_Request_With_Data
    [Tags]  delete
    Create Session  httpbin  http://httpbin.org
    &{data}=  Create Dictionary  name=ChenBolin  age=24
    ${res}=  Delete Request  httpbin  /delete  data=${data}
    Should Be Equal As Strings  ${res.status_code}  200
    Log  ${res.content}
    Comment  Dictionary Should Contain Value  ${res.json()['data']}  ChenBolin
    Comment  Dictionary Should Contain Value  ${res.json()['data']}  24
    Comment  Dictionary Should Contain Key  ${res.json()['data']}  name


Delete_Requests_with_Json_Data
    [Tags]  delete
    Create Session  httpbin     http://httpbin.org
    &{data}=    Create Dictionary   latitude=30.496346  longitude=-87.640356
    ${res}=     Delete Request  httpbin  /delete    json=${data}
    Should Be Equal As Strings  ${res.status_code}  200
    ${jsondata}=  To Json  ${res.content}
    Should Be Equal     ${jsondata['json']}     ${data}


Patch_Requests_urlencode
    [Tags]    patch
    Create Session    httpbin    http://httpbin.org
    &{data}=    Create Dictionary    name=ChenBolin    age=24
    &{headers}=    Create Dictionary    Content-Type=application/x-www-form-urlencoded
    ${res}=    Patch Request    httpbin    /patch    data=${data}    headers=${headers}
    Dictionary Should Contain Value    ${res.json()['form']}    ChenBolin
    Dictionary Should Contain Value    ${res.json()['form']}    24


Patch_Requests_with_Json_Data
    [Tags]  patch
    Create Session  httpbin     http://httpbin.org
    &{data}=    Create Dictionary   latitude=30.496346  longitude=-87.640356
    ${res}=     Patch Request  httpbin  /patch    json=${data}
    Should Be Equal As Strings  ${res.status_code}  200
    ${jsondata}=  To Json  ${res.content}
    Should Be Equal     ${jsondata['json']}     ${data}


Get_Request_With_Redirection
    [Tags]  get
    Create Session    httpbin    http://httpbin.org    debug=3
    ${res}    Get Request    httpbin    /redirect/1
    Log    ${res.content}
    Should Be Equal As Strings    ${res.status_code}    200
    ${res}=  Get Request    httpbin    /redirect/1    allow_redirects=${true}
    Log    ${res.content}
    Should Be Equal As Strings    ${res.status_code}    200


*** keywords ***






