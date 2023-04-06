-- Vehicle Management System DDL commands

CREATE SCHEMA `vehicle` ;

--
-- Table structure for table `branch`
--

DROP TABLE IF EXISTS `branch`;
CREATE TABLE `branch` (
  `branch_id` int NOT NULL AUTO_INCREMENT,
  `branch_name` varchar(45) NOT NULL,
  `no_of_employees` int DEFAULT NULL,
  PRIMARY KEY (`branch_id`),
  UNIQUE KEY `branch_name_UNIQUE` (`branch_name`)
);

--
-- Table structure for table `vehicle`
--

DROP TABLE IF EXISTS `vehicle`;
CREATE TABLE `vehicle` (
  `vehicle_id` int NOT NULL AUTO_INCREMENT,
  `vehicle_name` varchar(45) DEFAULT NULL,
  `vehicle_model` varchar(45) DEFAULT NULL,
  `engine_type` varchar(45) DEFAULT NULL,
  `vehicle_type` varchar(45) DEFAULT NULL,
  `rating` decimal(2,0) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`vehicle_id`)
);


--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
CREATE TABLE `customers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) DEFAULT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `gender` varchar(45) DEFAULT NULL,
  `mobile_number` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee` (
  `emp_id` int NOT NULL AUTO_INCREMENT,
  `emp_name` varchar(45) DEFAULT NULL,
  `emp_designation` varchar(45) DEFAULT NULL,
  `emp_salary` decimal(10,2) DEFAULT NULL,
  `emp_branch` int DEFAULT NULL,
  `emp_add` varchar(45) DEFAULT NULL,
  `emp_number` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`emp_id`),
  KEY `branch_id_idx` (`emp_branch`),
  CONSTRAINT `emp_branch` FOREIGN KEY (`emp_branch`) REFERENCES `branch` (`branch_id`)
);

--
-- Table structure for table `manufacture`
--

DROP TABLE IF EXISTS `manufacture`;
CREATE TABLE `manufacture` (
  `man_id` int NOT NULL AUTO_INCREMENT,
  `man_company` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`man_id`)
);

--
-- Table structure for table `parts`
--

DROP TABLE IF EXISTS `parts`;
CREATE TABLE `parts` (
  `parts_id` int NOT NULL AUTO_INCREMENT,
  `Part_name` varchar(45) DEFAULT NULL,
  `Quantity` int DEFAULT NULL,
  `Per_unit_cost` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`parts_id`)
);


--
-- Table structure for table `parts_requested`
--

DROP TABLE IF EXISTS `parts_requested`;
CREATE TABLE `parts_requested` (
  `id` int NOT NULL AUTO_INCREMENT,
  `part_id` int NOT NULL,
  `cust_id` int NOT NULL,
  `branch_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `parts_id_idx` (`part_id`),
  KEY `cust_part_idx` (`cust_id`),
  KEY `branch_part_idx` (`branch_id`),
  CONSTRAINT `branch_part` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_id`),
  CONSTRAINT `cust_part` FOREIGN KEY (`cust_id`) REFERENCES `customers` (`id`),
  CONSTRAINT `parts_id` FOREIGN KEY (`part_id`) REFERENCES `parts` (`parts_id`)
);


--
-- Table structure for table `reservations`
--

DROP TABLE IF EXISTS `reservations`;
CREATE TABLE `reservations` (
  `reservation_id` int NOT NULL AUTO_INCREMENT,
  `reservation_time` datetime DEFAULT NULL,
  `customer_id` int DEFAULT NULL,
  `branch_id` int DEFAULT NULL,
  `reservation_status` varchar(45) DEFAULT 'Pending',
  PRIMARY KEY (`reservation_id`),
  KEY `branch_id_reserv_idx` (`branch_id`),
  KEY `cust_id_reserv_idx` (`customer_id`),
  CONSTRAINT `branch_id_reserv` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_id`),
  CONSTRAINT `cust_id_reserv` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`)
);

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
CREATE TABLE `reviews` (
  `vehicle_id` int DEFAULT NULL,
  `review` text,
  `customer_id` int DEFAULT NULL,
  `rating` decimal(2,1) DEFAULT NULL,
  `review_id` int NOT NULL AUTO_INCREMENT,
  `review_sentiment` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`review_id`),
  KEY `customer_id_review_idx` (`customer_id`),
  KEY `vehicle_id_review_idx` (`vehicle_id`),
  CONSTRAINT `customer_id_review` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  CONSTRAINT `vehicle_id_review` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle` (`vehicle_id`)
);


--
-- Table structure for table `sales`
--

DROP TABLE IF EXISTS `sales`;
CREATE TABLE `sales` (
  `sale_id` int NOT NULL AUTO_INCREMENT,
  `vehicle_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `employee_id` int NOT NULL,
  `selling_price` decimal(10,2) NOT NULL,
  `date_sold` datetime DEFAULT CURRENT_TIMESTAMP,
  `branch_id` int NOT NULL,
  PRIMARY KEY (`sale_id`),
  KEY `vehicle_id_sale_idx` (`vehicle_id`),
  KEY `cust_id_sale_idx` (`customer_id`),
  KEY `emp_id_sale_idx` (`employee_id`),
  KEY `branch_id_sale_idx` (`branch_id`),
  CONSTRAINT `branch_id_sale` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_id`),
  CONSTRAINT `cust_id_sale` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  CONSTRAINT `emp_id_sale` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`emp_id`),
  CONSTRAINT `vehicle_id_sale` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle` (`vehicle_id`)
);

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
CREATE TABLE `services` (
  `service_id` int NOT NULL AUTO_INCREMENT,
  `service_name` varchar(45) DEFAULT NULL,
  `Per_unit_cost` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`service_id`)
);


--
-- Table structure for table `service_requested`
--

DROP TABLE IF EXISTS `service_requested`;
CREATE TABLE `service_requested` (
  `id` int NOT NULL AUTO_INCREMENT,
  `branch_id` int DEFAULT NULL,
  `service_id` int DEFAULT NULL,
  `worker_assigned` int DEFAULT NULL,
  `date_assigned` datetime DEFAULT CURRENT_TIMESTAMP,
  `completed` int DEFAULT '0',
  `date_completed` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `service_branch_idx` (`branch_id`),
  KEY `service_id_idx` (`service_id`),
  KEY `service_emp_idx` (`worker_assigned`),
  CONSTRAINT `service_branch` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_id`),
  CONSTRAINT `service_emp` FOREIGN KEY (`worker_assigned`) REFERENCES `employee` (`emp_id`),
  CONSTRAINT `service_id` FOREIGN KEY (`service_id`) REFERENCES `services` (`service_id`)
);

--
-- Table structure for table `vehicle_branch`
--

DROP TABLE IF EXISTS `vehicle_branch`;
CREATE TABLE `vehicle_branch` (
  `branch_id` int NOT NULL,
  `vehicle_id` int NOT NULL,
  `vehicle_count` int NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `branch_id_idx` (`branch_id`),
  KEY `vehicle_id_idx` (`vehicle_id`),
  CONSTRAINT `branch_id` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_id`),
  CONSTRAINT `vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle` (`vehicle_id`)
);






-- Trigger to decrease the count of part from the inventory when a cust. purchases a particular part.

DELIMITER ;;
CREATE TRIGGER `parts_requested_BEFORE_INSERT` BEFORE INSERT ON `parts_requested` FOR EACH ROW BEGIN
  update parts
  set quantity = quantity-1
    where parts_id = new.part_id;
END ;;
DELIMITER ;


-- Trigger to decrease the count of vehicle from the branch when a cust. purchases.

DELIMITER ;;
CREATE TRIGGER `sales_trigger` BEFORE INSERT ON `sales` FOR EACH ROW BEGIN
    update vehicle_branch
    set vehicle_count = vehicle_count-1
        where branch_id = new.branch_id
        and vehicle_id = new.vehicle_id;
  END;;
DELIMITER ;

-- Assign work to an employee by the branch manager
DELIMITER ;;
CREATE PROCEDURE `assign_service`(
  eid int, 
    sid int, 
    out msg varchar(45))
BEGIN

  declare sbid int;
    declare ebid int;
    
    select branch_id into sbid from service_requested where id = sid;
    select getBranchId(eid) into ebid;
    
    set msg = "Something went wrong";
    if sbid = ebid
    then update service_requested sr set sr.worker_assigned = eid where sr.id = sid;
        set msg = "Assigned Employee";
  else
    set msg = "Employee not in this branch";
  end if;
END;;
DELIMITER ;

-- Create a reservation for customers
DELIMITER ;;
CREATE PROCEDURE `create_reservation`(
    in reservation_time datetime,
    in customer_id int,
    in branch_id int
)
begin
    INSERT INTO reservations(customer_id, branch_id, reservation_time) VALUES (customer_id, branch_id, reservation_time);
end;;
DELIMITER ;

-- Get complete details of an employee
DELIMITER ;;
CREATE PROCEDURE `employee_details`(
    in eid int,
    out no_vehicles_sold int,
    out revenue_generated decimal(10, 2),
    out no_services_completed int,
    out no_ongoing_services int
)
BEGIN
    declare sp decimal(10, 2);
    declare cnt int;

    declare services_completed int;
    declare services_ongoing int;

    SELECT sum(s.selling_price) into sp
    FROM employee e, sales s, vehicle v
    where e.emp_id = s.employee_id and s.vehicle_id = v.vehicle_id
    and e.emp_id = eid
    group by eid;   

    SELECT 
            count(*) into cnt
    FROM employee e, sales s, vehicle v
    where e.emp_id = s.employee_id and s.vehicle_id = v.vehicle_id
    and e.emp_id = eid
    group by eid;   


    select count(*) into services_ongoing from
    employee e, service_requested sr
    where sr.worker_assigned = e.emp_id and sr.completed = 0 and e.emp_id = eid; 

    select count(*) into services_completed from
    employee e, service_requested sr
    where sr.worker_assigned = e.emp_id and sr.completed = 1 and e.emp_id = eid;


    set no_vehicles_sold = cnt;
    set revenue_generated = sp;
    set no_ongoing_services = services_ongoing;
    set no_services_completed = services_completed;

END;;
DELIMITER ;

-- Employee salary Update
DELIMITER ;;
CREATE PROCEDURE `employee_salary_update`(
    in mid int,
    in eid int,
    in inc int,
    out msg varchar(45)
)
BEGIN
    
    declare salary decimal(10, 2);
    declare countV int;
    set @m = is_manager(mid);
    
    set @b1 = getBranchId(eid);
    set @b2 = getBranchID(mid);
    
    if @m = 1 then
        if @b1 = @b2 then
            select emp_salary into salary from employee where emp_id = eid;
            update employee set emp_salary = salary+inc where emp_id = eid;
            set msg = "Updated Salary";
        else
            set msg = "Not in the same branch";
        end if;
    else
        set msg = "You are not the manager";
    end if;
END;;
DELIMITER ;

-- Update a vehicle count
DELIMITER ;;
CREATE PROCEDURE `update_vehicle_count`(
    in vid int,
    in bid int,
    in update_count int
)
begin
    
    declare getidx int;
    select id into getidx from vehicle_branch where vehicle_id = vid and branch_id = bid;
    if update_count > 0 then 
        update vehicle_branch set vehicle_count = update_count where id = getidx;
    end if;
end;;
DELIMITER ;




-- Get the vehicle count on that particular branch
DELIMITER ;;
CREATE FUNCTION `countVehicles`(vid int, bid int) RETURNS int
    DETERMINISTIC
    begin 
      declare veh_qty int;
        select vehicle_count into veh_qty
        from vehicle_branch
        where vehicle_id = vid and branch_id = bid;
        return veh_qty;
end;;
DELIMITER ;

-- Get the branch ID, based on the employee ID
DELIMITER ;;
CREATE FUNCTION `getBranchId`(eip int) RETURNS int
    DETERMINISTIC
    begin
        declare somevar int;
    select emp_branch into somevar
    from employee 
    where emp_id = eip;

    return somevar;
end;;
DELIMITER ;

-- Check whether if the employee is manager or not
DELIMITER ;;
CREATE FUNCTION `is_manager`(eid int) RETURNS int
    DETERMINISTIC
BEGIN

    declare res int;
        select case 
                when emp_designation = 'manager' then 1
                else 0 end into res
                from employee
                where emp_id = eid;
    RETURN res;

    RETURN 1;
END;;
DELIMITER ;


-- Update Reservation details
DELIMITER ;;
CREATE FUNCTION `update_appointment_cust`(aid int, res_time datetime, branch_id int) RETURNS int
    DETERMINISTIC
    begin
        declare checkApp int;
        set checkApp = find_appointment(aid);
        if checkApp != -1 then
            update reservations SET reservation_time = res_time, branch_id = branch_id WHERE reservation_id = aid;
        end if;
        return checkApp;
    end;;
DELIMITER ;

-- Update Reservation status
DELIMITER ;;
CREATE FUNCTION `update_status_appointment`(aid int, inp int) RETURNS int
    DETERMINISTIC
    begin
        declare time_reserved datetime;
        declare checkApp int;
        
        set checkApp = find_appointment(aid);
        if checkApp != -1 then
            if inp = 1 then
                update reservations SET reservation_status = 'Approved' WHERE (reservation_id = aid); 
            elseif inp = 0 then 
                update reservations SET reservation_status = 'Rejected' WHERE (reservation_id = aid); 
            end if;
        end if;
        return checkApp;
    end;;
DELIMITER ;

CREATE 
VIEW `sales_transcripts` AS
    SELECT 
        `s`.`sale_id` AS `saleID`,
        `c`.`id` AS `customer_id`,
        CONCAT(`c`.`first_name`, ' ', `c`.`last_name`) AS `Customer_name`,
        `e`.`emp_name` AS `emp_name`,
        `v`.`vehicle_name` AS `vehicle_name`,
        `v`.`vehicle_model` AS `vehicle_model`,
        `v`.`engine_type` AS `engine_type`,
        `v`.`price` AS `cost_price`,
        `s`.`selling_price` AS `selling_price`,
        (`s`.`selling_price` - `v`.`price`) AS `profit_made`
    FROM
        (((`sales` `s`
        JOIN `employee` `e`)
        JOIN `vehicle` `v`)
        JOIN `customers` `c`)
    WHERE
        ((`s`.`vehicle_id` = `v`.`vehicle_id`)
            AND (`s`.`employee_id` = `e`.`emp_id`)
            AND (`s`.`customer_id` = `c`.`id`));


CREATE 
VIEW `service_branch` AS
    SELECT 
        `b`.`branch_name` AS `branch_name`,
        SUM(`s`.`Per_unit_cost`) AS `sum(s.Per_unit_cost)`,
        COUNT(`s`.`Per_unit_cost`) AS `count(s.Per_unit_cost)`
    FROM
        ((`service_requested` `sr`
        JOIN `services` `s`)
        JOIN `branch` `b`)
    WHERE
        ((`sr`.`service_id` = `s`.`service_id`)
            AND (`sr`.`branch_id` = `b`.`branch_id`))
    GROUP BY `b`.`branch_name`;

CREATE 
VIEW `service_name_transcripts` AS
    SELECT 
        `s`.`service_name` AS `service_name`,
        SUM(`s`.`Per_unit_cost`) AS `revenue`,
        COUNT(`s`.`Per_unit_cost`) AS `counter`
    FROM
        (`service_requested` `sr`
        JOIN `services` `s`)
    WHERE
        (`sr`.`service_id` = `s`.`service_id`)
    GROUP BY `s`.`service_name`;
