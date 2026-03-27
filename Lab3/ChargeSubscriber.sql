--------------------------------------------------------
--  File created - пʼятниця-березня-27-2026   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure CHARGESUBSCRIBER
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE "SYSTEM"."CHARGESUBSCRIBER" (
    p_subscriber_id IN NUMBER,
    p_month         IN DATE
) AS
    v_fee NUMBER;
BEGIN
BEGIN
    SELECT t.MonthlyFee
    INTO v_fee
    FROM Orders o
    JOIN Tariffs t ON o.ServiceID = t.ServiceID
    WHERE o.SubscriberID = p_subscriber_id
      AND ROWNUM = 1;
    INSERT INTO Payments (PaymentID, SubscriberID, Amount, PaymentDate)
    VALUES (Payments_seq.NEXTVAL, p_subscriber_id, v_fee, p_month);
END;
EXCEPTION
        WHEN NO_DATA_FOUND THEN
        NULL;
    COMMIT;
END;

/
