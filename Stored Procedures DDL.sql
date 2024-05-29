DELIMITER //
CREATE PROCEDURE AddBooking(booking_id INT, customer_id INT, booking_date DATE, tblno INT)
BEGIN
INSERT INTO bookings(BookingID, CustomerID, BookingDate, TableNumber) VALUES(booking_id, customer_id, booking_date, tblno);
END //

DELIMITER ;

DROP PROCEDURE AddBooking;

CALL AddBooking(5,4,"2024-05-29",7);

SELECT * FROM bookings;

DELIMITER //
CREATE PROCEDURE UpdateBooking(booking_id INT, booking_date DATE)
BEGIN
DECLARE booking_exists BOOLEAN DEFAULT FALSE;
DECLARE status VARCHAR(100);
SELECT EXISTS(SELECT 1 FROM bookings WHERE BookingID = booking_id)
INTO booking_exists;
IF booking_exists THEN
UPDATE Bookings SET BookingDate = booking_date WHERE BookingID = booking_id;
SET status = CONCAT('Booking ',booking_id,' updated to ',booking_date);
ELSE
SET status = CONCAT('Booking ',booking_id,' does not exists.');
END IF;
COMMIT;
SELECT status AS ConfirmationStatus;

END //

DELIMITER ;

SELECT * FROM bookings;

DROP PROCEDURE UpdateBooking;

CALL UpdateBooking(5,'2024-05-30');


DELIMITER //
CREATE PROCEDURE CancelBooking(booking_id INT)
BEGIN
DECLARE booking_exists BOOLEAN DEFAULT FALSE;
DECLARE status VARCHAR(100);
SELECT EXISTS(SELECT 1 FROM bookings WHERE BookingID = booking_id)
INTO booking_exists;
IF booking_exists THEN
DELETE FROM Bookings WHERE BookingID = booking_id;
SET status = CONCAT('Booking ',booking_id,' cancelled.');
ELSE
SET status = CONCAT('Booking ',booking_id,' does not exists.');
END IF;
COMMIT;
SELECT status as ConfirmationStatus;
END //
DELIMITER ;

CALL CancelBooking(5);
