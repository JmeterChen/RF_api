*** Settings ***
Library           RequestsLibrary
Library           Collections
Library           OperatingSystem

*** Variables ***


*** Test Cases ***
# List_demo1
#     @{a}    Create List    1    2
#     @{b}    Create List    3    4
#     @{c}    Create List    ${a}     ${b}
#     @{d}    Create List    5    6
#     @{e}    Create List    ${c}    ${d}
#     log    ${c[1][1]}
#     log    ${c[1]}
#     log    @{c[1]}[1]
#     log    ${e}
#     log    ${e[0][1][1]}


List_demo2
    @{a}    Create List    1    2
    @{b}    Create List    3    4
    @{c}    Create List    ${a}    ${b}
    @{d}    Create List    @{a}    @{b}
    Log     ${c}