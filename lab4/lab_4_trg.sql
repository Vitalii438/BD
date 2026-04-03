--------------------------------------------------------
--  File created - пʼятниця-квітня-03-2026   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Trigger TRG_CHANNELS_AUDIT
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "SYSTEM"."TRG_CHANNELS_AUDIT" 
BEFORE INSERT OR UPDATE ON Channels
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.UCR := USER;
        :NEW.DCR := SYSDATE;
    END IF;

    IF UPDATING THEN
        :NEW.ULC := USER;
        :NEW.DLC := SYSDATE;
    END IF;
END;
/
ALTER TRIGGER "SYSTEM"."TRG_CHANNELS_AUDIT" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TRG_ORDERS_AUDIT
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "SYSTEM"."TRG_ORDERS_AUDIT" 
BEFORE INSERT OR UPDATE ON Orders
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.UCR := USER;
        :NEW.DCR := SYSDATE;
    END IF;

    IF UPDATING THEN
        :NEW.ULC := USER;
        :NEW.DLC := SYSDATE;
    END IF;
END;
/
ALTER TRIGGER "SYSTEM"."TRG_ORDERS_AUDIT" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TRG_ORDERS_BLOCK_AGE
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "SYSTEM"."TRG_ORDERS_BLOCK_AGE" 
BEFORE INSERT ON Orders
FOR EACH ROW
DECLARE
    v_age NUMBER;
    v_limit NUMBER;
BEGIN
    SELECT FLOOR(MONTHS_BETWEEN(SYSDATE, BirthDate)/12)
    INTO v_age
    FROM Subscribers
    WHERE SubscriberID = :NEW.SubscriberID;

    SELECT AgeLimit
    INTO v_limit
    FROM Movies
    WHERE ServiceID = :NEW.ServiceID;

    IF v_age < v_limit THEN
        --RAISE_APPLICATION_ERROR(-20002, 'Абонент занадто молодий для цього фільму. Замовлення заборонено.');
        DBMS_OUTPUT.PUT_LINE( 'Абонент занадто молодий для цього фільму. Замовлення заборонено.');
    END IF;
END;
/
ALTER TRIGGER "SYSTEM"."TRG_ORDERS_BLOCK_AGE" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TRG_ORDERS_BLOCK_UNPAID
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "SYSTEM"."TRG_ORDERS_BLOCK_UNPAID" 
AFTER INSERT OR UPDATE ON Orders
DECLARE
    v_count NUMBER;
BEGIN
    FOR rec IN (SELECT DISTINCT SubscriberID FROM Orders) LOOP
        SELECT COUNT(*)
        INTO v_count
        FROM Payments
        WHERE SubscriberID = rec.SubscriberID
          AND PaymentDate >= ADD_MONTHS(SYSDATE, -3);

        IF v_count = 0 THEN
            UPDATE Subscribers
            SET Status = 'BLOCKED'
            WHERE SubscriberID = rec.SubscriberID;
            
            --RAISE_APPLICATION_ERROR(-20001, 'Абонент має борг більше 3 місяців. Нові замовлення заборонені.');
            --RAISE_APPLICATION_WARNING(-20001, 'Абонент має борг більше 3 місяців. Нові замовлення заборонені.');
            --SET SERVEROUTPUT ON;
            DBMS_OUTPUT.PUT_LINE( 'Абонент має борг більше 3 місяців. Нові замовлення заборонені.');
        END IF;
    END LOOP;
END;
/
ALTER TRIGGER "SYSTEM"."TRG_ORDERS_BLOCK_UNPAID" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TRG_PAYMENTS_AUDIT
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "SYSTEM"."TRG_PAYMENTS_AUDIT" 
BEFORE INSERT OR UPDATE ON Payments
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.UCR := USER;
        :NEW.DCR := SYSDATE;
    END IF;

    IF UPDATING THEN
        :NEW.ULC := USER;
        :NEW.DLC := SYSDATE;
    END IF;
END;
/
ALTER TRIGGER "SYSTEM"."TRG_PAYMENTS_AUDIT" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TRG_PAYMENTS_PK
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "SYSTEM"."TRG_PAYMENTS_PK" 
BEFORE INSERT ON Payments
FOR EACH ROW
BEGIN
    IF :NEW.PaymentID IS NULL THEN
        :NEW.PaymentID := Payments_seq.NEXTVAL;
    END IF;
END;
/
ALTER TRIGGER "SYSTEM"."TRG_PAYMENTS_PK" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TRG_SUBSCRIBERS_AUDIT
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "SYSTEM"."TRG_SUBSCRIBERS_AUDIT" 
BEFORE INSERT OR UPDATE ON Subscribers
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.UCR := USER;
        :NEW.DCR := SYSDATE;
        :NEW.Status := 'ACTIVE';
    END IF;

    IF UPDATING THEN
        :NEW.ULC := USER;
        :NEW.DLC := SYSDATE;
    END IF;
END;

/
ALTER TRIGGER "SYSTEM"."TRG_SUBSCRIBERS_AUDIT" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TRG_TARIFFS_AUDIT
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "SYSTEM"."TRG_TARIFFS_AUDIT" 
BEFORE INSERT OR UPDATE ON Tariffs
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.UCR := USER;
        :NEW.DCR := SYSDATE;
    END IF;

    IF UPDATING THEN
        :NEW.ULC := USER;
        :NEW.DLC := SYSDATE;
    END IF;
END;
/
ALTER TRIGGER "SYSTEM"."TRG_TARIFFS_AUDIT" ENABLE;
