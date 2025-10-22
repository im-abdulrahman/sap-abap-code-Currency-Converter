*&---------------------------------------------------------------------*
*& Report Z_REHAN14
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_REHAN14.

SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME TITLE TITLE1.
  PARAMETERS: P_AMOUNT TYPE I,
              P_FROM   TYPE CHAR03 AS LISTBOX VISIBLE LENGTH 10,
              P_TO     TYPE CHAR03 AS LISTBOX VISIBLE LENGTH 10.
SELECTION-SCREEN END OF BLOCK B1.

INITIALIZATION.
TITLE1 = 'Exchange Rate Tool'.

" ------------------------- lIST OF CURRENCY ------------------------------------

INITIALIZATION.
CALL FUNCTION 'VRM_SET_VALUES'
EXPORTING
  id = 'P_FROM'
  values = VALUE vrm_values(
           ( key = '1' text = 'INR' )
           ).

INITIALIZATION.
CALL FUNCTION 'VRM_SET_VALUES'
EXPORTING
  id = 'P_TO'
  values = VALUE vrm_values(
           ( key = '1' text = 'MYR' )
           ( key = '2' text = 'USD' )
           ( key = '3' text = 'EUR' )
           ( key = '4' text = 'GBP' )
           ( key = '5' text = 'AUD' )
           ( key = '6' text = 'CAD' )
           ( key = '7' text = 'JPY' )
           ( key = '8' text = 'CHF' )
           ( key = '9' text = 'CNY' )
           ).

" ----------------------- Output Calculation -----------------------------------------


START-OF-SELECTION.
DATA : RESULT TYPE P DECIMALS 3,
       C_FROM TYPE CHAR20,
      " CUNTRY TYPE DATA
       C_MYR TYPE P DECIMALS 2,
       C_USD TYPE P DECIMALS 3,
       C_EUR TYPE P DECIMALS 3,
       C_GBP TYPE P DECIMALS 3,
       C_AUD TYPE P DECIMALS 3,
       C_CAD TYPE P DECIMALS 3,
       C_JPY TYPE P DECIMALS 3,
       C_CHF TYPE P DECIMALS 3,
       C_CNY TYPE P DECIMALS 3.
       " EXCHANGE VALUE
       C_MYR = conv F('0.052').
       C_USD = conv F('0.011').
       C_EUR = conv F('0.009').
       C_GBP = conv F('0.008').
       C_AUD = conv F('0.017').
       C_CAD = conv F('0.016').
       C_JPY = conv F('0.581').
       C_CHF = conv F('0.009').
       C_CNY = conv F('0.081').

" CASE TO CALCULATE EXCHANGE RATE
CASE P_TO.
  WHEN '1'.
    RESULT = C_MYR * P_AMOUNT.
    C_FROM = 'MYR'.
  WHEN '2'.
    RESULT = C_USD * P_AMOUNT.
    C_FROM = 'USD'.
  WHEN '3'.
    RESULT = C_EUR * P_AMOUNT.
    C_FROM = 'EUR'.
  WHEN '4'.
    RESULT = C_GBP * P_AMOUNT.
    C_FROM = 'GBP'.
  WHEN '5'.
    RESULT = C_AUD * P_AMOUNT.
    C_FROM = 'AUD'.
  WHEN '6'.
    RESULT = C_CAD * P_AMOUNT.
    C_FROM = 'CAD'.
  WHEN '7'.
    RESULT = C_JPY * P_AMOUNT.
    C_FROM = 'JPY'.
  WHEN '8'.
    RESULT = C_CHF * P_AMOUNT.
    C_FROM = 'CHF'.
  WHEN '9'.
    RESULT = C_CNY * P_AMOUNT.
    C_FROM = 'CNY'.
ENDCASE.

" DISPLAY FINAL RESULT.
write : / 'User enters an amount =' , P_AMOUNT , ' INR' ,
        / 'Exchnage with =' , C_FROM,
        / '------------------------------------',
        / 'You will get total amount =' , RESULT , C_FROM.