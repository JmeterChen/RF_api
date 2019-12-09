*** Settings ***
Library           RequestsLibrary
Library           Collections
Resource          Wood_Resource.robot


*** Test Cases ***

Login_Noraml
    [Tags]   121121
    Create Session    wood    https://api.maocode.cn    verify=true
    &{headers}    Create Dictionary    Content-Type=application/json
    &{data}    Create Dictionary    identity=18682236985    password=123456    pid=n6kwoCSe
    ${res}    post request    wood    /tiger/accounts/login    headers=${headers}    json=${data}
    Log    ${res}
    Log    ${res.content}

    # Dictionary Should Contain Key    ${datajson['user_info']['nickname']}    胆小的皮皮蟹60

