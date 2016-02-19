/*
-- Query: SELECT * FROM mediolio.subcategory
LIMIT 0, 1000

-- Date: 2016-02-19 12:40
*/
INSERT INTO `subcategory` (`sc_id`,`sc_name`,`sc_parent`) VALUES (1,'기획',1);
INSERT INTO `subcategory` (`sc_id`,`sc_name`,`sc_parent`) VALUES (2,'개발',1);
INSERT INTO `subcategory` (`sc_id`,`sc_name`,`sc_parent`) VALUES (3,'시나리오',2);
INSERT INTO `subcategory` (`sc_id`,`sc_name`,`sc_parent`) VALUES (4,'연출',2);
INSERT INTO `subcategory` (`sc_id`,`sc_name`,`sc_parent`) VALUES (5,'촬영',2);
INSERT INTO `subcategory` (`sc_id`,`sc_name`,`sc_parent`) VALUES (6,'OAP',2);
INSERT INTO `subcategory` (`sc_id`,`sc_name`,`sc_parent`) VALUES (7,'모델링',3);
INSERT INTO `subcategory` (`sc_id`,`sc_name`,`sc_parent`) VALUES (8,'애니메이션',3);
INSERT INTO `subcategory` (`sc_id`,`sc_name`,`sc_parent`) VALUES (9,'기획',5);
INSERT INTO `subcategory` (`sc_id`,`sc_name`,`sc_parent`) VALUES (10,'개발',5);
INSERT INTO `subcategory` (`sc_id`,`sc_name`,`sc_parent`) VALUES (11,'디자인',4);
INSERT INTO `subcategory` (`sc_id`,`sc_name`,`sc_parent`) VALUES (12,'컴퓨터 그래픽스',6);
INSERT INTO `subcategory` (`sc_id`,`sc_name`,`sc_parent`) VALUES (13,'사운드',7);
