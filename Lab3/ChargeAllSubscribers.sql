--------------------------------------------------------
--  File created - пʼятниця-березня-27-2026   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure CHARGEALLSUBSCRIBERS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE NONEDITIONABLE PROCEDURE "SYSTEM"."CHARGEALLSUBSCRIBERS" (
    p_month IN DATE
) AS
BEGIN
    FOR rec IN (SELECT SubscriberID FROM Subscribers) LOOP
        ChargeSubscriber(rec.SubscriberID, p_month);
    END LOOP;
END;

/
