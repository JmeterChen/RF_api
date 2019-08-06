*** Variable ***
${pro-host}                 https://api.codemao.cn
${sta-host}                 https://backend-test.codemao.cn
${test-host}                https://test-api.codemao.cn

# test_data
${username}                 18682236985
${password}                 123456
${PID}                      n6kwoCSe


*** keywords ***

login_template
    [Arguments]    ${username}=None    ${password}=None    ${pid}=None    ${status_code}=200    ${error_code}=None
    Create Session    wood    ${test-host}    verify=true
    ${headers}    Create Dictionary    Content-Type=application/json
    ${login_data}    Create Dictionary    identity=${username}    password=${password}    pid=${pid}
    ${res}    Post Request    wood    /tiger/accounts/login    headers=${headers}    json=${login_data}
    # Log    ${res.status_code}
    Should Be Equal As Strings    ${res.status_code}    ${status_code}
    ${datajson}    To Json    ${res.content}
    # Log    ${datajson}
    Should Be Equal    ${datajson['error_code']}    ${error_code}


login_success
    [Arguments]    ${username}    ${password}    ${pid}
    Create Session    wood    ${test-host}    verify=True
    ${login_data}    Create Dictionary    identity=${username}    password=${password}    pid=${pid}
    ${res}    Post Request    wood    /tiger/accounts/login    json=${login_data}
    Should Be Equal As Strings    ${res.status_code}    200
    Dictionary Should Contain Key    ${res.json()}    user_info