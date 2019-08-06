*** Settings ***
Library           RequestsLibrary
Library           Collections
Resource          Wood_Resource.robot


*** Test Cases ***
Login_Noraml
    [Tags]
    Create Session    wood    ${test-host}    verify=true
    ${headers}    Create Dictionary    Content-Type=application/json
    ${login_data}    Create Dictionary    identity=${username}    password=${password}    pid=${PID}
    ${res}    Post Request    wood    /tiger/accounts/login    headers=${headers}    json=${login_data}
    Should Be Equal As Strings    ${res.status_code}    200
    ${datajson}    To Json    ${res.content}
    Log    ${datajson}
    Dictionary Should Contain Key    ${datajson}    user_info
    Dictionary Should Contain Key    ${datajson}    token
    # Dictionary Should Contain Key    ${datajson['user_info']['nickname']}    胆小的皮皮蟹60


Login_Faild
    [template]    login_template
    [Documentation]    验证对登录接口传入不同参数针对响应做出断言结果
    ...                Data-driven testing
    # 登录用户        密码        Pid         响应状态码     错误编码
    ${EMPTY}        123456     n6kwoCSe      400           A_5
    18682236985     ${EMPTY}   n6kwoCSe      400           A_5
    18682236985     654321     n6kwoCSe      403           AC_1
    11111111111     123456     n6kwoCSe      403           AC_1
    18682236985     123456     dfgfghhfgd    403           AC_12
    13217176556     123456     n6kwoCSe      403           AC_0
    132tetgfh435    123456     n6kwoCSe      403           AC_0
    18682236985     123456     ${EMPTY}      400           A_5








