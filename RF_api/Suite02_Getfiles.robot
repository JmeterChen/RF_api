*** Settings ***
Library            RequestsLibrary
Library            Collections
Resource           Wood_Resource.robot
Suite Setup        login_success    ${username}    ${password}    ${PID}
Library           function.py


*** Test Cases ***

Get_files_list_py
    # [Tags]    get
    # ${num}    Create num
    # ${num}    Evaluate    int(${num})
    # @{num_list}    Create List    12
    # &{params}    Create Dictionary    language_type=1    page=1    limit=${num}
    # ${res}    Get Request    wood    /tiger/wood/user/works    params=${params}
    # ${jsondata}=  To Json  ${res.content}
    # Should Be Equal As Strings    ${res.status_code}    200
    # Should Not Be Empty    ${jsondata[0]}
    # ${files_list_len}    Get Length    ${jsondata}
    # # Log    ${files_list_len}
    # Should Be Equal    ${files_list_len}    ${num}
    # :FOR    ${i}    IN RANGE    ${num}
    # \    ${file_language_type}    Evaluate    str(${jsondata[${i}]["language_type"]})
    # \    List Should Contain Value    ${num_list}     ${file_language_type}
    ${num}    Create num
    Log    ${num}
    ${num}    Evaluate    int(${num})
    Log    ${num}
    Set Suite Variable    ${num}
    get_files    1   ${EMPTY}    ${1}    ${1}    ${num}


Get_files_list_hex
    [Tags]    get
    ${num}    Create num
    ${num}    Evaluate    int(${num})
    @{num_list}    Create List    2
    &{params}    Create Dictionary    language_type=2    page=1    limit=${num}
    ${res}    Get Request    wood    /tiger/wood/user/works    params=${params}
    ${jsondata}=  To Json  ${res.content}
    Should Be Equal As Strings    ${res.status_code}    200
    Should Not Be Empty    ${jsondata[0]}
    ${files_list_len}    Get Length    ${jsondata}
    # Log    ${files_list_len}
    Should Be Equal    ${files_list_len}    ${num}
    :FOR    ${i}    IN RANGE    ${num}
    \    ${file_language_type}    Evaluate    str(${jsondata[${i}]["language_type"]})
    \    List Should Contain Value    ${num_list}     ${file_language_type}


Get_files_list_all
    [Tags]    get
    ${num}    Create num
    ${num}    Evaluate    int(${num})
    @{num_list}    Create List    1    2
    # Log     ${num_list}
    &{params}    Create Dictionary    language_type=0    page=1    limit=${num}
    ${res}    Get Request    wood    /tiger/wood/user/works    params=${params}
    ${jsondata}=  To Json  ${res.content}
    Should Be Equal As Strings    ${res.status_code}    200
    Should Not Be Empty    ${jsondata[0]}
    ${files_list_len}    Get Length    ${jsondata}
    # Log    ${files_list_len}
    Should Be Equal    ${files_list_len}    ${num}
    :FOR    ${i}    IN RANGE    ${num}
    \    ${file_language_type}    Evaluate    str(${jsondata[${i}]["language_type"]})
    \    List Should Contain Value    ${num_list}     ${file_language_type}



*** keywords ***
get_files
    [Arguments]    ${num1}=${None}    ${num2}=${None}    ${language_type}=${None}    ${page}=${None}    ${limit}=${None}
    @{num_list}    Create List    ${num1}    ${num2}
    # Log     ${num_list}
    &{params}    Create Dictionary    language_type=${language_type}    page=${page}    limit=${limit}
    ${res}    Get Request    wood    /tiger/wood/user/works    params=${params}
    ${jsondata}=  To Json  ${res.content}
    Should Be Equal As Strings    ${res.status_code}    200
    Should Not Be Empty    ${jsondata[0]}
    ${files_list_len}    Get Length    ${jsondata}
    # Log    ${files_list_len}
    Should Be Equal    ${files_list_len}    ${num}
    :FOR    ${i}    IN RANGE    ${num}
    \    ${file_language_type}    Evaluate    str(${jsondata[${i}]["language_type"]})
    \    List Should Contain Value    ${num_list}     ${file_language_type}


