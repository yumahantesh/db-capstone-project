INSERT INTO bookings
VALUES(4,'2022-10-13',2,1),
(2,'2022-11-12',3,3),
(3,'2022-10-11',2,2);

SELECT * FROM bookings;

DROP PROCEDURE CheckBooking;

DELIMITER //
CREATE PROCEDURE CheckBooking(IN booking_date DATE, IN tblno INT)
BEGIN
DECLARE tblstatus VARCHAR(100);
DECLARE status_found BOOLEAN DEFAULT FALSE;
SELECT EXISTS(SELECT 1 FROM bookings WHERE TableNumber = tblno AND BookingDate = booking_date)
INTO status_found;
IF status_found THEN
	SET tblstatus = CONCAT('Table ',tblno,' is already booked.');
ELSE
	SET tblstatus = CONCAT('Table ',tblno,' is available for booking.');
END IF;
SELECT tblstatus AS TableStatus;
END //

DELIMITER ;

CALL CheckBooking("2022-11-12",3);

# Store Procedure with transaction

DELIMITER //
CREATE PROCEDURE AddValidBooking(IN booking_date DATE, IN tblno INT)
BEGIN
DECLARE table_already_booked BOOLEAN DEFAULT FALSE;
DECLARE booking_status VARCHAR(100);
START TRANSACTION;
SELECT EXISTS(SELECT 1 FROM bookings
WHERE BookingDate = booking_date AND TableNumber = tblno) INTO table_already_booked;
IF table_already_booked THEN
ROLLBACK;
SET booking_status = CONCAT('Table ',tblno,' is already booked - Booking Cancelled.');
ELSE
INSERT INTO bookings(BookingDate, TableNumber)
VALUES(booking_date,tblno);
COMMIT;
SET booking_status = CONCAT('Table ',tblno,' booking added successfully.');
END IF;
SELECT booking_status AS Status;
END //

DELIMITER ;

CALL AddValidBooking("2022-11-12",3);
