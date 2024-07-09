/*
 Navicat Premium Data Transfer

 Source Server         : 本地
 Source Server Type    : MySQL
 Source Server Version : 80028
 Source Host           : localhost:3306
 Source Schema         : exam

 Target Server Type    : MySQL
 Target Server Version : 80028
 File Encoding         : 65001

 Date: 09/07/2024 23:14:49
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for approval
-- ----------------------------
DROP TABLE IF EXISTS `approval`;
CREATE TABLE `approval`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `student_id` int(0) NOT NULL COMMENT '申请人id',
  `teacher_id` int(0) NOT NULL COMMENT '教师id',
  `classes_id` int(0) NOT NULL COMMENT '班级id',
  `apply_date` datetime(0) NULL DEFAULT NULL COMMENT '申请时间',
  `status` int(0) NOT NULL DEFAULT 0 COMMENT '状态0：审批中，1：同意，2：拒绝',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of approval
-- ----------------------------

-- ----------------------------
-- Table structure for classes
-- ----------------------------
DROP TABLE IF EXISTS `classes`;
CREATE TABLE `classes`  (
  `classes_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '班级id',
  `classes_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '班级名称',
  `update_date` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `create_date` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `introduction` varchar(600) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '班级简介',
  `people_num` int(0) NULL DEFAULT NULL COMMENT '班级人数',
  `creator_id` int(0) NOT NULL COMMENT '创建者id',
  PRIMARY KEY (`classes_id`) USING BTREE,
  INDEX `FK`(`creator_id`) USING BTREE,
  CONSTRAINT `FK` FOREIGN KEY (`creator_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 37 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of classes
-- ----------------------------
INSERT INTO `classes` VALUES (29, '人工智能与机器学习班', '2024-02-10 14:21:52', '2024-02-10 14:21:52', '人工智能与机器学习001班', 3, 1);
INSERT INTO `classes` VALUES (30, '人工智能与机器学习班', '2024-02-11 14:11:00', '2024-02-11 14:11:00', '人工智能与机器学习002班', 2, 1);
INSERT INTO `classes` VALUES (32, '基础编程与算法班', '2024-03-29 16:47:59', '2024-03-29 16:47:59', '基础编程与算法001班', 0, 1);
INSERT INTO `classes` VALUES (33, '基础编程与算法班', '2024-03-29 17:26:32', '2024-03-29 17:26:32', '基础编程与算法002班', 1, 1);
INSERT INTO `classes` VALUES (34, '基础编程与算法班', '2024-04-20 14:35:07', '2024-04-20 14:35:07', '基础编程与算法003班', 2, 24);
INSERT INTO `classes` VALUES (35, '基础编程与算法班', '2024-04-20 14:51:49', '2024-04-20 14:51:49', '基础编程与算法004班', 0, 24);
INSERT INTO `classes` VALUES (36, '计科001班', '2024-04-28 15:27:58', '2024-04-28 15:27:58', '计算机信息技术学院计科001班', 1, 1);

-- ----------------------------
-- Table structure for classes_subject
-- ----------------------------
DROP TABLE IF EXISTS `classes_subject`;
CREATE TABLE `classes_subject`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `subject_id` int(0) NOT NULL COMMENT '科目id',
  `classes_id` int(0) NOT NULL COMMENT '班级id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of classes_subject
-- ----------------------------
INSERT INTO `classes_subject` VALUES (6, 7, 29);
INSERT INTO `classes_subject` VALUES (8, 8, 29);
INSERT INTO `classes_subject` VALUES (13, 3, 29);
INSERT INTO `classes_subject` VALUES (14, 4, 29);
INSERT INTO `classes_subject` VALUES (15, 6, 29);
INSERT INTO `classes_subject` VALUES (18, 9, 29);
INSERT INTO `classes_subject` VALUES (19, 5, 29);
INSERT INTO `classes_subject` VALUES (20, 9, 33);
INSERT INTO `classes_subject` VALUES (21, 2, 33);
INSERT INTO `classes_subject` VALUES (22, 12, 33);
INSERT INTO `classes_subject` VALUES (23, 12, 34);
INSERT INTO `classes_subject` VALUES (24, 1, 37);
INSERT INTO `classes_subject` VALUES (25, 1, 34);

-- ----------------------------
-- Table structure for exam
-- ----------------------------
DROP TABLE IF EXISTS `exam`;
CREATE TABLE `exam`  (
  `exam_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '试卷id',
  `exam_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '试卷名称',
  `creator_id` int(0) UNSIGNED NOT NULL COMMENT '创建者id',
  `time` int(0) UNSIGNED NULL DEFAULT NULL COMMENT '答题时间(分钟)',
  `create_date` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_date` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `subject_id` int(0) UNSIGNED NULL DEFAULT NULL COMMENT '科目类型id',
  `topic_num` int(0) UNSIGNED NULL DEFAULT 0 COMMENT '题目数量',
  `total_score` float UNSIGNED NULL DEFAULT 0 COMMENT '总分',
  `pass_mark` float UNSIGNED NULL DEFAULT 0 COMMENT '及格分数',
  `permit_copy` int(0) UNSIGNED NULL DEFAULT 1 COMMENT '是否允许复制  0:不允许  1:允许(默认)',
  `switch_page` int(0) NULL DEFAULT -1 COMMENT '允许页面切换次数  -1: 允许多次切换  5: 默认',
  `disrupt_order` int(0) UNSIGNED NULL DEFAULT 0 COMMENT '是否打乱题目顺序 0:不打乱(默认) 1:打乱顺序',
  `repeat_test` int(0) UNSIGNED NULL DEFAULT 1 COMMENT '允许考生考试次数 默认1',
  `auto_mack` int(0) UNSIGNED NULL DEFAULT 1 COMMENT '是否自动评分 0:否   1:是(默认)',
  PRIMARY KEY (`exam_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 46 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of exam
-- ----------------------------
INSERT INTO `exam` VALUES (30, '请输入试卷名称', 1, 60, '2024-02-11 08:12:25', '2024-02-11 14:15:32', 4, 5, 50, 0, 0, -1, 0, 1, 1);
INSERT INTO `exam` VALUES (31, '请输入试卷名称', 1, 60, '2024-02-11 08:14:33', '2024-02-11 14:13:15', 6, 3, 30, 0, 0, -1, 0, 1, 1);
INSERT INTO `exam` VALUES (32, '测试自动评分', 1, 60, '2024-02-11 14:00:28', '2024-03-30 10:52:31', 9, 4, 30, 0, 0, -1, 1, 1, 1);
INSERT INTO `exam` VALUES (34, 'MySQL考试', 1, 60, '2024-04-01 09:49:46', '2024-04-17 15:24:17', 10, 6, 100, 60, 0, -1, 1, 1, 1);
INSERT INTO `exam` VALUES (35, '数据结构考试', 1, 60, '2024-04-17 15:14:48', '2024-04-17 17:32:48', 4, 9, 90, 0, 0, -1, 0, 1, 1);
INSERT INTO `exam` VALUES (37, 'JSP考试', 1, 2, '2024-04-17 15:15:15', '2024-04-17 15:49:28', 9, 7, 100, 60, 0, -1, 1, 1, 1);
INSERT INTO `exam` VALUES (38, '数据结构第一次考试', 1, 60, '2024-04-18 15:17:35', '2024-04-18 21:37:38', 4, 10, 110, 50, 0, -1, 0, 1, 1);
INSERT INTO `exam` VALUES (41, '大数据分析第一次考试', 24, 60, '2024-04-20 21:27:00', '2024-04-20 21:53:00', 12, 8, 100, 60, 0, -1, 1, 1, 1);
INSERT INTO `exam` VALUES (42, '数据结构第二次考试', 1, 60, '2024-04-28 17:06:42', '2024-05-06 16:33:16', 12, 9, 100, 60, 0, -1, 0, 1, 1);
INSERT INTO `exam` VALUES (45, '大数据分析第二次考试', 24, 60, '2024-05-11 11:12:34', '2024-05-11 11:14:36', 12, 9, 100, 60, 0, -1, 1, 1, 1);

-- ----------------------------
-- Table structure for exam_classes
-- ----------------------------
DROP TABLE IF EXISTS `exam_classes`;
CREATE TABLE `exam_classes`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `exam_id` int(0) NOT NULL COMMENT '考试id',
  `classes_id` int(0) NOT NULL COMMENT '班级id',
  `release_time` datetime(0) NOT NULL COMMENT '发布时间',
  `start_date` datetime(0) NOT NULL COMMENT '开始时间',
  `deadline` datetime(0) NOT NULL COMMENT '结束时间',
  `publish_answer` int(10) UNSIGNED ZEROFILL NULL DEFAULT 0000000000 COMMENT '是否公布答案   0:不公布   1:公布答案',
  `publish_score` int(10) UNSIGNED ZEROFILL NULL DEFAULT 0000000000 COMMENT '是否公布分数   0:不公布   1:公布',
  `status` int(0) NULL DEFAULT 0 COMMENT '状态 0:待批改 1:批改完成',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of exam_classes
-- ----------------------------
INSERT INTO `exam_classes` VALUES (32, 31, 29, '2024-02-11 14:13:28', '2024-02-10 00:00:00', '2024-03-19 00:00:00', 0000000001, 0000000001, 0);
INSERT INTO `exam_classes` VALUES (33, 30, 29, '2024-02-11 14:15:44', '2024-02-10 00:00:00', '2024-03-19 00:00:00', 0000000001, 0000000001, 0);
INSERT INTO `exam_classes` VALUES (34, 32, 33, '2024-03-31 20:43:45', '2024-03-31 12:00:00', '2024-04-02 16:00:00', 0000000001, 0000000001, 0);
INSERT INTO `exam_classes` VALUES (35, 35, 33, '2024-04-17 17:33:27', '2024-04-17 20:30:00', '2024-04-17 20:40:00', 0000000001, 0000000001, 0);
INSERT INTO `exam_classes` VALUES (36, 35, 29, '2024-04-17 18:15:37', '2024-04-17 17:42:00', '2024-04-17 20:59:00', 0000000001, 0000000001, 0);
INSERT INTO `exam_classes` VALUES (37, 38, 32, '2024-04-19 17:12:56', '2024-04-19 17:16:00', '2024-04-19 20:00:00', 0000000001, 0000000001, 0);
INSERT INTO `exam_classes` VALUES (38, 38, 30, '2024-04-19 17:12:56', '2024-04-19 17:16:00', '2024-04-19 20:00:00', 0000000001, 0000000001, 0);
INSERT INTO `exam_classes` VALUES (39, 35, 30, '2024-04-20 09:35:00', '2024-04-20 09:38:00', '2024-04-21 09:00:00', 0000000001, 0000000001, 0);
INSERT INTO `exam_classes` VALUES (40, 41, 34, '2024-04-20 21:58:23', '2024-04-20 22:00:00', '2024-04-20 23:00:00', 0000000000, 0000000000, 0);

-- ----------------------------
-- Table structure for exam_topic
-- ----------------------------
DROP TABLE IF EXISTS `exam_topic`;
CREATE TABLE `exam_topic`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `exam_id` int(0) NOT NULL COMMENT '考试id',
  `topic_id` int(0) NOT NULL COMMENT '题目id',
  `topic_type` int(0) NOT NULL COMMENT '题目类型  0:单选题 1:多选题 2:判断题 3:填空题 4:简答题',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 338 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of exam_topic
-- ----------------------------
INSERT INTO `exam_topic` VALUES (97, 30, 97, 0);
INSERT INTO `exam_topic` VALUES (98, 31, 98, 0);
INSERT INTO `exam_topic` VALUES (99, 31, 99, 1);
INSERT INTO `exam_topic` VALUES (100, 31, 100, 2);
INSERT INTO `exam_topic` VALUES (101, 32, 101, 0);
INSERT INTO `exam_topic` VALUES (102, 32, 102, 2);
INSERT INTO `exam_topic` VALUES (103, 32, 103, 3);
INSERT INTO `exam_topic` VALUES (106, 30, 106, 1);
INSERT INTO `exam_topic` VALUES (107, 30, 107, 2);
INSERT INTO `exam_topic` VALUES (108, 30, 108, 3);
INSERT INTO `exam_topic` VALUES (109, 30, 109, 4);
INSERT INTO `exam_topic` VALUES (112, 32, 112, 0);
INSERT INTO `exam_topic` VALUES (113, 34, 113, 0);
INSERT INTO `exam_topic` VALUES (125, 34, 125, 0);
INSERT INTO `exam_topic` VALUES (126, 34, 126, 0);
INSERT INTO `exam_topic` VALUES (127, 34, 127, 0);
INSERT INTO `exam_topic` VALUES (148, 34, 148, 0);
INSERT INTO `exam_topic` VALUES (149, 34, 149, 4);
INSERT INTO `exam_topic` VALUES (156, 37, 156, 0);
INSERT INTO `exam_topic` VALUES (157, 37, 157, 2);
INSERT INTO `exam_topic` VALUES (158, 37, 158, 2);
INSERT INTO `exam_topic` VALUES (159, 37, 159, 3);
INSERT INTO `exam_topic` VALUES (160, 37, 160, 3);
INSERT INTO `exam_topic` VALUES (161, 37, 161, 4);
INSERT INTO `exam_topic` VALUES (162, 37, 162, 4);
INSERT INTO `exam_topic` VALUES (189, 35, 189, 0);
INSERT INTO `exam_topic` VALUES (190, 35, 190, 0);
INSERT INTO `exam_topic` VALUES (191, 35, 191, 1);
INSERT INTO `exam_topic` VALUES (192, 35, 192, 1);
INSERT INTO `exam_topic` VALUES (193, 35, 193, 2);
INSERT INTO `exam_topic` VALUES (194, 35, 194, 3);
INSERT INTO `exam_topic` VALUES (195, 35, 195, 3);
INSERT INTO `exam_topic` VALUES (196, 35, 196, 3);
INSERT INTO `exam_topic` VALUES (197, 35, 197, 4);
INSERT INTO `exam_topic` VALUES (235, 38, 235, 0);
INSERT INTO `exam_topic` VALUES (236, 38, 236, 0);
INSERT INTO `exam_topic` VALUES (237, 38, 237, 0);
INSERT INTO `exam_topic` VALUES (238, 38, 238, 1);
INSERT INTO `exam_topic` VALUES (239, 38, 239, 1);
INSERT INTO `exam_topic` VALUES (240, 38, 240, 2);
INSERT INTO `exam_topic` VALUES (241, 38, 241, 3);
INSERT INTO `exam_topic` VALUES (242, 38, 242, 3);
INSERT INTO `exam_topic` VALUES (243, 38, 243, 3);
INSERT INTO `exam_topic` VALUES (244, 38, 244, 4);
INSERT INTO `exam_topic` VALUES (268, 41, 268, 0);
INSERT INTO `exam_topic` VALUES (269, 41, 269, 0);
INSERT INTO `exam_topic` VALUES (270, 41, 270, 1);
INSERT INTO `exam_topic` VALUES (271, 41, 271, 1);
INSERT INTO `exam_topic` VALUES (272, 41, 272, 2);
INSERT INTO `exam_topic` VALUES (273, 41, 273, 3);
INSERT INTO `exam_topic` VALUES (274, 41, 274, 4);
INSERT INTO `exam_topic` VALUES (275, 41, 275, 4);
INSERT INTO `exam_topic` VALUES (294, 42, 294, 0);
INSERT INTO `exam_topic` VALUES (295, 42, 295, 0);
INSERT INTO `exam_topic` VALUES (296, 42, 296, 0);
INSERT INTO `exam_topic` VALUES (297, 42, 297, 0);
INSERT INTO `exam_topic` VALUES (298, 42, 298, 0);
INSERT INTO `exam_topic` VALUES (299, 42, 299, 0);
INSERT INTO `exam_topic` VALUES (300, 42, 300, 0);
INSERT INTO `exam_topic` VALUES (301, 42, 301, 0);
INSERT INTO `exam_topic` VALUES (302, 42, 302, 4);
INSERT INTO `exam_topic` VALUES (303, 43, 303, 0);
INSERT INTO `exam_topic` VALUES (304, 43, 304, 0);
INSERT INTO `exam_topic` VALUES (305, 43, 305, 0);
INSERT INTO `exam_topic` VALUES (306, 43, 306, 0);
INSERT INTO `exam_topic` VALUES (307, 43, 307, 0);
INSERT INTO `exam_topic` VALUES (308, 43, 308, 1);
INSERT INTO `exam_topic` VALUES (309, 43, 309, 2);
INSERT INTO `exam_topic` VALUES (310, 43, 310, 2);
INSERT INTO `exam_topic` VALUES (311, 43, 311, 3);
INSERT INTO `exam_topic` VALUES (312, 43, 312, 4);
INSERT INTO `exam_topic` VALUES (313, 44, 313, 0);
INSERT INTO `exam_topic` VALUES (314, 44, 314, 0);
INSERT INTO `exam_topic` VALUES (315, 44, 315, 0);
INSERT INTO `exam_topic` VALUES (316, 44, 316, 0);
INSERT INTO `exam_topic` VALUES (317, 44, 317, 3);
INSERT INTO `exam_topic` VALUES (318, 44, 318, 3);
INSERT INTO `exam_topic` VALUES (319, 44, 319, 4);
INSERT INTO `exam_topic` VALUES (320, 44, 320, 4);
INSERT INTO `exam_topic` VALUES (329, 45, 329, 0);
INSERT INTO `exam_topic` VALUES (330, 45, 330, 0);
INSERT INTO `exam_topic` VALUES (331, 45, 331, 0);
INSERT INTO `exam_topic` VALUES (332, 45, 332, 1);
INSERT INTO `exam_topic` VALUES (333, 45, 333, 1);
INSERT INTO `exam_topic` VALUES (334, 45, 334, 2);
INSERT INTO `exam_topic` VALUES (335, 45, 335, 3);
INSERT INTO `exam_topic` VALUES (336, 45, 336, 4);
INSERT INTO `exam_topic` VALUES (337, 45, 337, 4);

-- ----------------------------
-- Table structure for subject
-- ----------------------------
DROP TABLE IF EXISTS `subject`;
CREATE TABLE `subject`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '科目名称',
  `create_id` int(0) NULL DEFAULT NULL COMMENT '创建者id',
  `create_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建者名称',
  `create_date` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_date` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of subject
-- ----------------------------
INSERT INTO `subject` VALUES (1, '计算机网络', NULL, NULL, NULL, NULL);
INSERT INTO `subject` VALUES (2, '计算机组成原理', NULL, NULL, NULL, NULL);
INSERT INTO `subject` VALUES (3, '汇编语言', NULL, NULL, NULL, NULL);
INSERT INTO `subject` VALUES (4, '数据结构', NULL, NULL, NULL, NULL);
INSERT INTO `subject` VALUES (5, 'VUE', NULL, NULL, NULL, NULL);
INSERT INTO `subject` VALUES (6, 'HarmonyOS', NULL, NULL, NULL, NULL);
INSERT INTO `subject` VALUES (7, 'JAVA', NULL, NULL, NULL, NULL);
INSERT INTO `subject` VALUES (8, '数据库', NULL, NULL, NULL, NULL);
INSERT INTO `subject` VALUES (9, 'JSP', NULL, NULL, NULL, NULL);
INSERT INTO `subject` VALUES (10, 'MySQL', NULL, NULL, NULL, NULL);
INSERT INTO `subject` VALUES (11, '操作系统', NULL, NULL, NULL, NULL);
INSERT INTO `subject` VALUES (12, '大数据分析', NULL, NULL, NULL, NULL);
INSERT INTO `subject` VALUES (13, 'Python程序设计', NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for topic
-- ----------------------------
DROP TABLE IF EXISTS `topic`;
CREATE TABLE `topic`  (
  `topic_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '题目id',
  `creator_id` int(0) NOT NULL COMMENT '创建者id',
  `question` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '题目',
  `choice` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '选项',
  `photo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片',
  `topic_type` int(0) NOT NULL COMMENT '题目类型  0:单选题 1:多选题 2:判断题 3:填空题 4:简答题',
  `correct_answer` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '正确答案',
  `score` float NULL DEFAULT 0 COMMENT '分数',
  `difficulty` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '中等' COMMENT '难度  简单,中等(默认),困难',
  `analysis` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '答案分析',
  `required` int(0) NULL DEFAULT 0 COMMENT '非必填:0   必填:1',
  `create_date` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_date` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `subject_id` int(0) NULL DEFAULT NULL COMMENT '科目id',
  PRIMARY KEY (`topic_id`) USING BTREE,
  INDEX `suoyin2`(`creator_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 338 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of topic
-- ----------------------------
INSERT INTO `topic` VALUES (97, 1, '请输入题目标题', '选项1\n选项2\n选项3\n选项4', NULL, 0, '选项3', 10, '中等', '请输入答案分析', 1, '2024-02-11 08:12:25', '2024-02-11 08:12:25', NULL);
INSERT INTO `topic` VALUES (98, 1, '请输入题目标题', '选项1\n选项2\n选项3\n选项4', NULL, 0, '选项1', 10, '中等', '请输入答案分析', 1, '2024-02-11 08:14:33', '2024-02-11 08:14:33', NULL);
INSERT INTO `topic` VALUES (99, 1, '请输入题目标题', '选项1\n选项2\n选项3\n选项4', NULL, 1, '\n选项1\n选项2', 10, '中等', '请输入答案分析', 1, '2024-02-11 08:14:33', '2024-02-11 08:14:33', NULL);
INSERT INTO `topic` VALUES (100, 1, '请输入题目标题', '选项1\n选项2\n选项3\n选项4', NULL, 2, 'true', 10, '中等', '请输入答案分析', 1, '2024-02-11 08:14:34', '2024-02-11 08:14:34', NULL);
INSERT INTO `topic` VALUES (101, 1, '请输入题目标题', '选项1\n选项2\n选项3\n选项4', NULL, 0, '选项1', 10, '中等', '请输入答案分析', 1, '2024-02-11 14:00:28', '2024-02-11 14:00:28', NULL);
INSERT INTO `topic` VALUES (102, 1, '请输入题目标题', '选项1\n选项2\n选项3\n选项4', NULL, 2, 'true', 10, '中等', '请输入答案分析', 1, '2024-02-11 14:00:28', '2024-02-11 14:00:28', NULL);
INSERT INTO `topic` VALUES (103, 1, '请输入题目标题_________', '选项1\n选项2\n选项3\n选项4', NULL, 3, '123\n123\n123', 10, '中等', '请输入答案分析', 1, '2024-02-11 14:00:28', '2024-02-11 14:00:28', NULL);
INSERT INTO `topic` VALUES (106, 1, '请输入题目标题', '选项1\n选项2\n选项3\n选项4', NULL, 1, '选项1\n选项2', 10, '中等', '请输入答案分析', 1, '2024-02-11 14:15:32', '2024-02-11 14:15:32', NULL);
INSERT INTO `topic` VALUES (107, 1, '请输入题目标题', '选项1\n选项2\n选项3\n选项4', NULL, 2, 'false', 10, '中等', '请输入答案分析', 1, '2024-02-11 14:15:32', '2024-02-11 14:15:32', NULL);
INSERT INTO `topic` VALUES (108, 1, '请输入题目标题______', '选项1\n选项2\n选项3\n选项4', NULL, 3, '123\n321', 10, '中等', '请输入答案分析', 1, '2024-02-11 14:15:32', '2024-02-11 14:15:32', NULL);
INSERT INTO `topic` VALUES (109, 1, '请输入题目标题', '选项1\n选项2\n选项3\n选项4', NULL, 4, '3\n33\n123', 10, '中等', '请输入答案分析', 1, '2024-02-11 14:15:32', '2024-02-11 14:15:32', NULL);
INSERT INTO `topic` VALUES (110, 1, '1+1 = ?', '2\n3\n1\n4', NULL, 0, '选项3', 0, '简单', '1+1=2', 1, '2024-03-30 10:51:21', '2024-03-30 10:51:21', NULL);
INSERT INTO `topic` VALUES (111, 1, '1+1 = ?', '2\n3\n1\n4', NULL, 0, '选项3', 0, '简单', '1+1=2', 1, '2024-03-30 10:51:27', '2024-03-30 10:51:27', NULL);
INSERT INTO `topic` VALUES (112, 1, '1+1 = ?', '2\n3\n1\n4', NULL, 0, '选项3', 0, '简单', '1+1=2', 1, '2024-03-30 10:51:48', '2024-03-30 10:51:48', NULL);
INSERT INTO `topic` VALUES (113, 1, 'SQL语言具有数据操作功能，SQL语言的一次查询的结果是一个______', '数据项\n记录\n元组\n表', NULL, 0, '表', 10, '简单', '', 1, '2024-04-01 09:49:46', '2024-04-01 09:49:46', NULL);
INSERT INTO `topic` VALUES (120, 1, '某软件公司正在升级一套水务管理系统。该系统用于县市级供排水企业、供水厂、排水厂中水务数据的管理工作。系统经重新整合后，开发人员决定不再使用一张备份数据表waterinfo001表，需永久删除。选出符合要求的语句。', 'DELETE TABLE waterinfo001\nDELETE FROM TABLE waterinfo001\nDROP TABLE waterinfo001\nDROP FROM TABLE waterinfo001', NULL, 0, 'DROP TABLE waterinfo001', 15, '简单', '题目的要求是删除整张waterinfo001表，需要永久删除。故需要用到drop(没有drop from这种用法)\n1. drop是完全删除表，包括表结构\n2. delete是删除表数据，保留表的结构，而且可以加where,只删除一行或者多行', 1, '2024-04-17 14:57:43', '2024-04-17 14:57:43', NULL);
INSERT INTO `topic` VALUES (121, 1, '某学院包含多个专业如计算机科学、信息管理、软件工程、网络工程。每个专业每年都招收一个班级的学生。在招生过程中就已明确规定，一个学生只能就读于该学院的一个班级，但是一个班级可以招收不超过60个学生。那么，班级和学生之间是________的关系。', '一对多\n一对一\n多对多\n多对一', NULL, 0, '一对多', 15, '简单', '一个班级能对应多个学生，一个学生只能对应一个班级。所以班级和学生是一对多的关系', 1, '2024-04-17 14:57:43', '2024-04-17 14:57:43', NULL);
INSERT INTO `topic` VALUES (122, 1, 'Mysql中表student_table(id,name,birth,sex)，插入如下记录：\n(\'1004\' , \'张三\' , \'2000-08-06\' , \'男\');\n(\'1005\' , NULL , \'2001-12-01\' , \'女\');\n(\'1006\' , \'张三\' , \'2000-08-06\' , \'女\');\n(\'1007\' , ‘王五’ , \'2001-12-01\' , \'男\');\n(\'1008\' , \'李四\' , NULL, \'女\');\n(\'1009\' , \'李四\' , NULL, \'男\');\n(\'1010\' , \'李四\' , \'2001-12-01\', \'女\');\n执行\nselect t1.*,t2.*\nfrom (\nselect * from student_table where sex = \'男\' ) t1 \nleft  join \n(select * from student_table where sex = \'女\')t2 \non t1.birth = t2.birth and t1.name = t2.name ; \n的结果行数是（）？', '4\n2\n3\n1', NULL, 0, '2', 20, '中等', 'left join 查询的结果以左坐标的数据为主，对于右表中不存在的数据进行null进行填充', 1, '2024-04-17 14:57:43', '2024-04-17 14:57:43', NULL);
INSERT INTO `topic` VALUES (123, 1, 'SQL中，下面对于数据定义语言DDL描述正确的是', 'DDL关心的是数据库中的数据\n联盟链\n控制对数据库的访问\n定义数据库的结构', NULL, 0, '定义数据库的结构', 20, '中等', '（1）数据定义（SQL DDL）用于定义SQL模式、基本表、视图和索引的创建和撤消操作。\n（2）数据操纵（SQL DML）数据操纵分成数据查询和数据更新两类。数据更新又分成插入、删除、和修改三种操作。\n（3）数据控制（DCL）包括对基本表和视图的授权，完整性规则的描述，事务控制等内容。\n（4）嵌入式SQL的使用规定（TCL）涉及到SQL语句嵌入在宿主语言程序中使用的规则。', 1, '2024-04-17 14:57:43', '2024-04-17 14:57:43', NULL);
INSERT INTO `topic` VALUES (124, 1, '数据库事务的特性', '选项1\n选项2\n选项3\n选项4', NULL, 4, '原子性\n一致性\n隔离性\n持久性', 20, '中等', '原子性：即不可分割性，事务要么全部被执行，要么就全部不被执行。\n一致性或可串性。事务的执行使得数据库从一种正确状态转换成另一种正确状态\n隔离性。在事务正确提交之前，不允许把该事务对数据的任何改变提供给任何其他事务，\n持久性。事务正确提交后，其结果将永久保存在数据库中，即使在事务提交后有了其他故障，事务的处理结果也会得到保存。', 1, '2024-04-17 14:57:43', '2024-04-17 14:57:43', NULL);
INSERT INTO `topic` VALUES (125, 1, '某软件公司正在升级一套水务管理系统。该系统用于县市级供排水企业、供水厂、排水厂中水务数据的管理工作。系统经重新整合后，开发人员决定不再使用一张备份数据表waterinfo001表，需永久删除。选出符合要求的语句。', 'DELETE TABLE waterinfo001\nDELETE FROM TABLE waterinfo001\nDROP TABLE waterinfo001\nDROP FROM TABLE waterinfo001', NULL, 0, 'DROP TABLE waterinfo001', 15, '简单', '题目的要求是删除整张waterinfo001表，需要永久删除。故需要用到drop(没有drop from这种用法)\n1. drop是完全删除表，包括表结构\n2. delete是删除表数据，保留表的结构，而且可以加where,只删除一行或者多行', 1, '2024-04-17 14:58:07', '2024-04-17 14:58:07', NULL);
INSERT INTO `topic` VALUES (126, 1, '某学院包含多个专业如计算机科学、信息管理、软件工程、网络工程。每个专业每年都招收一个班级的学生。在招生过程中就已明确规定，一个学生只能就读于该学院的一个班级，但是一个班级可以招收不超过60个学生。那么，班级和学生之间是________的关系。', '一对多\n一对一\n多对多\n多对一', NULL, 0, '一对多', 15, '简单', '一个班级能对应多个学生，一个学生只能对应一个班级。所以班级和学生是一对多的关系', 1, '2024-04-17 14:58:07', '2024-04-17 14:58:07', NULL);
INSERT INTO `topic` VALUES (127, 1, 'Mysql中表student_table(id,name,birth,sex)，插入如下记录：\n(\'1004\' , \'张三\' , \'2000-08-06\' , \'男\');\n(\'1005\' , NULL , \'2001-12-01\' , \'女\');\n(\'1006\' , \'张三\' , \'2000-08-06\' , \'女\');\n(\'1007\' , ‘王五’ , \'2001-12-01\' , \'男\');\n(\'1008\' , \'李四\' , NULL, \'女\');\n(\'1009\' , \'李四\' , NULL, \'男\');\n(\'1010\' , \'李四\' , \'2001-12-01\', \'女\');\n执行\nselect t1.*,t2.*\nfrom (\nselect * from student_table where sex = \'男\' ) t1 \nleft  join \n(select * from student_table where sex = \'女\')t2 \non t1.birth = t2.birth and t1.name = t2.name ; \n的结果行数是（）？', '4\n2\n3\n1', NULL, 0, '3', 20, '中等', 'left join 查询的结果以左坐标的数据为主，对于右表中不存在的数据进行null进行填充', 1, '2024-04-17 14:58:07', '2024-04-17 14:58:07', NULL);
INSERT INTO `topic` VALUES (128, 1, 'SQL中，下面对于数据定义语言DDL描述正确的是', 'DDL关心的是数据库中的数据\n联盟链\n控制对数据库的访问\n定义数据库的结构', NULL, 0, '定义数据库的结构', 20, '中等', '（1）数据定义（SQL DDL）用于定义SQL模式、基本表、视图和索引的创建和撤消操作。\n（2）数据操纵（SQL DML）数据操纵分成数据查询和数据更新两类。数据更新又分成插入、删除、和修改三种操作。\n（3）数据控制（DCL）包括对基本表和视图的授权，完整性规则的描述，事务控制等内容。\n（4）嵌入式SQL的使用规定（TCL）涉及到SQL语句嵌入在宿主语言程序中使用的规则。', 1, '2024-04-17 14:58:07', '2024-04-17 14:58:07', NULL);
INSERT INTO `topic` VALUES (129, 1, '数据库事务的特性', '选项1\n选项2\n选项3\n选项4', NULL, 4, '原子性\n一致性\n隔离性\n持久性', 20, '中等', '原子性：即不可分割性，事务要么全部被执行，要么就全部不被执行。\n一致性或可串性。事务的执行使得数据库从一种正确状态转换成另一种正确状态\n隔离性。在事务正确提交之前，不允许把该事务对数据的任何改变提供给任何其他事务，\n持久性。事务正确提交后，其结果将永久保存在数据库中，即使在事务提交后有了其他故障，事务的处理结果也会得到保存。', 1, '2024-04-17 14:58:07', '2024-04-17 14:58:07', NULL);
INSERT INTO `topic` VALUES (130, 1, '111', '选项1\n选项2\n选项3\n选项4', NULL, 0, '选项3', 10, '中等', '请输入答案分析', 1, '2024-04-17 15:14:48', '2024-04-17 15:14:48', NULL);
INSERT INTO `topic` VALUES (131, 1, '请输入题目标题', '选项1\n选项2\n选项3\n选项4', NULL, 1, '选项1\n选项2', 10, '中等', '请输入答案分析', 1, '2024-04-17 15:14:48', '2024-04-17 15:14:48', NULL);
INSERT INTO `topic` VALUES (132, 1, '请输入题目标题', '选项1\n选项2\n选项3\n选项4', NULL, 2, 'false', 10, '中等', '请输入答案分析', 1, '2024-04-17 15:14:48', '2024-04-17 15:14:48', NULL);
INSERT INTO `topic` VALUES (133, 1, '请输入题目标题______', '选项1\n选项2\n选项3\n选项4', NULL, 3, '123\n321', 10, '中等', '请输入答案分析', 1, '2024-04-17 15:14:48', '2024-04-17 15:14:48', NULL);
INSERT INTO `topic` VALUES (134, 1, '请输入题目标题', '选项1\n选项2\n选项3\n选项4', NULL, 4, '3\n33\n123', 10, '中等', '请输入答案分析', 1, '2024-04-17 15:14:48', '2024-04-17 15:14:48', NULL);
INSERT INTO `topic` VALUES (139, 1, '11111', '选项1\n选项2\n选项3\n选项4', NULL, 0, '选项1', 10, '中等', '请输入答案分析', 1, '2024-04-17 15:15:15', '2024-04-17 15:15:15', NULL);
INSERT INTO `topic` VALUES (140, 1, '1+1 = ?', '2\n3\n1\n4', NULL, 0, '选项3', 0, '简单', '1+1=2', 1, '2024-04-17 15:15:15', '2024-04-17 15:15:15', NULL);
INSERT INTO `topic` VALUES (141, 1, '请输入题目标题', '选项1\n选项2\n选项3\n选项4', NULL, 2, 'true', 10, '中等', '请输入答案分析', 1, '2024-04-17 15:15:15', '2024-04-17 15:15:15', NULL);
INSERT INTO `topic` VALUES (142, 1, '请输入题目标题_________', '选项1\n选项2\n选项3\n选项4', NULL, 3, '123\n123\n123', 10, '中等', '请输入答案分析', 1, '2024-04-17 15:15:15', '2024-04-17 15:15:15', NULL);
INSERT INTO `topic` VALUES (148, 1, 'SQL中，下面对于数据定义语言DDL描述正确的是', 'DDL关心的是数据库中的数据\n联盟链\n控制对数据库的访问\n定义数据库的结构', NULL, 0, '定义数据库的结构', 20, '中等', '（1）数据定义（SQL DDL）用于定义SQL模式、基本表、视图和索引的创建和撤消操作。\n（2）数据操纵（SQL DML）数据操纵分成数据查询和数据更新两类。数据更新又分成插入、删除、和修改三种操作。\n（3）数据控制（DCL）包括对基本表和视图的授权，完整性规则的描述，事务控制等内容。\n（4）嵌入式SQL的使用规定（TCL）涉及到SQL语句嵌入在宿主语言程序中使用的规则。', 1, '2024-04-17 15:24:17', '2024-04-17 15:24:17', NULL);
INSERT INTO `topic` VALUES (149, 1, '数据库事务的特性', '选项1\n选项2\n选项3\n选项4', NULL, 4, '原子性\n一致性\n隔离性\n持久性', 20, '中等', '原子性：即不可分割性，事务要么全部被执行，要么就全部不被执行。\n一致性或可串性。事务的执行使得数据库从一种正确状态转换成另一种正确状态\n隔离性。在事务正确提交之前，不允许把该事务对数据的任何改变提供给任何其他事务，\n持久性。事务正确提交后，其结果将永久保存在数据库中，即使在事务提交后有了其他故障，事务的处理结果也会得到保存。', 1, '2024-04-17 15:24:17', '2024-04-17 15:24:17', NULL);
INSERT INTO `topic` VALUES (150, 1, '将jsp翻译成Servlet源码后，用户访问jsp文件时会被调用的方法是', 'jspInit()\njspDesroy()\njspService()\nService()', NULL, 0, 'jspService()', 10, '中等', 'JSP容器先将JSP文件转换成一个Java源文件（Java Servlet源程序），在转换过程中，如果发现JSP文件中存在任何语法错误，则中断转换过程，并向服务端和客户端返回出错信息。 如果转换成功，则JSP容器将生成的Java源文件编译成相应的字节码文件*.class。该class文件就是一个Servlet，Servlet容器会像处理其他Servlet一样来处理它。', 1, '2024-04-17 15:44:29', '2024-04-17 15:44:29', NULL);
INSERT INTO `topic` VALUES (151, 1, 'JSP的Page编译指令的属性Language的默认值是Java', '选项1\n选项2\n选项3\n选项4', NULL, 2, 'true', 10, '中等', '无', 1, '2024-04-17 15:44:29', '2024-04-17 15:44:29', NULL);
INSERT INTO `topic` VALUES (152, 1, '在JSP中，page指令用来引入需要的包或类的属性是import', '选项1\n选项2\n选项3\n选项4', NULL, 2, 'true', 10, '简单', 'import属性用于指定在JSP页面翻译成的Servlet源文件中导入的包或类。import是唯一可以声明多次的page指令属性。一个import属性可以引用多个类，中间用英文逗号隔开', 1, '2024-04-17 15:44:29', '2024-04-17 15:44:29', NULL);
INSERT INTO `topic` VALUES (153, 1, '在JSP页面中，经常需要处理一些异常信息，这时，可以通过___对象来实现。', '选项1\n选项2\n选项3\n选项4', NULL, 3, 'exception\n', 10, '中等', '请输入答案分析', 1, '2024-04-17 15:44:29', '2024-04-17 15:44:29', NULL);
INSERT INTO `topic` VALUES (154, 1, '什么是JSP指令(Directive)？', '选项1\n选项2\n选项3\n选项4', NULL, 4, 'Directive是当JSP页面被编译成Servlet的时候，JSP引擎要处理的指令。Directive用来设置页面级别的指令，从外部文件插入数据，指定自定义的标签库。Directive是定义在 <%@ 和 %>之间的。', 25, '中等', 'JSP指令用来设置整个JSP页面相关的属性，如网页的编码方式和脚本语言。', 1, '2024-04-17 15:44:29', '2024-04-17 15:44:29', NULL);
INSERT INTO `topic` VALUES (155, 1, 'JSP中有哪些不同类型的指令？', '选项1\n选项2\n选项3\n选项4', NULL, 4, '包含指令(Include directive)\n页面指令(Page directive)\nTaglib指令', 25, '中等', '包含指令(Include directive)：用来包含文件和合并文件内容到当前的页面。\n页面指令(Page directive)：用来定义JSP页面中特定的属性，比如错误页面和缓冲区。\nTaglib指令： 用来声明页面中使用的自定义的标签库。', 1, '2024-04-17 15:44:29', '2024-04-17 15:44:29', NULL);
INSERT INTO `topic` VALUES (156, 1, '将jsp翻译成Servlet源码后，用户访问jsp文件时会被调用的方法是', 'jspInit()\njspDesroy()\njspService()\nService()', NULL, 0, 'jspService()', 10, '中等', 'JSP容器先将JSP文件转换成一个Java源文件（Java Servlet源程序），在转换过程中，如果发现JSP文件中存在任何语法错误，则中断转换过程，并向服务端和客户端返回出错信息。 如果转换成功，则JSP容器将生成的Java源文件编译成相应的字节码文件*.class。该class文件就是一个Servlet，Servlet容器会像处理其他Servlet一样来处理它。', 1, '2024-04-17 15:49:28', '2024-04-17 15:49:28', NULL);
INSERT INTO `topic` VALUES (157, 1, 'JSP的Page编译指令的属性Language的默认值是Java', '选项1\n选项2\n选项3\n选项4', NULL, 2, 'true', 10, '中等', '无', 1, '2024-04-17 15:49:28', '2024-04-17 15:49:28', NULL);
INSERT INTO `topic` VALUES (158, 1, '在JSP中，page指令用来引入需要的包或类的属性是import', '选项1\n选项2\n选项3\n选项4', NULL, 2, 'true', 10, '简单', 'import属性用于指定在JSP页面翻译成的Servlet源文件中导入的包或类。import是唯一可以声明多次的page指令属性。一个import属性可以引用多个类，中间用英文逗号隔开', 1, '2024-04-17 15:49:28', '2024-04-17 15:49:28', NULL);
INSERT INTO `topic` VALUES (159, 1, '在JSP页面中，经常需要处理一些异常信息，这时，可以通过___对象来实现。', '选项1\n选项2\n选项3\n选项4', NULL, 3, 'exception\n', 10, '中等', '请输入答案分析', 1, '2024-04-17 15:49:28', '2024-04-17 15:49:28', NULL);
INSERT INTO `topic` VALUES (160, 1, 'JSP页面中out对象是用来向___发送文本形式的实体内容。', '选项1\n选项2\n选项3\n选项4', NULL, 3, '客户端', 10, '简单', '在JSP页面中，经常需要向客户端发送文本内容，向客户端发送文本内容可以使用out对象实现。out对象是javax.servlet.jsp.JspWriter类的实例对象，它的作用与ServletResponse.getWriter()方法返回的PrintWriter对象非常相似，都是用来向客户端发送文本形式的实体内容。', 1, '2024-04-17 15:49:28', '2024-04-17 15:49:28', NULL);
INSERT INTO `topic` VALUES (161, 1, '什么是JSP指令(Directive)？', '选项1\n选项2\n选项3\n选项4', NULL, 4, 'Directive是当JSP页面被编译成Servlet的时候，JSP引擎要处理的指令。Directive用来设置页面级别的指令，从外部文件插入数据，指定自定义的标签库。Directive是定义在 <%@ 和 %>之间的。', 25, '中等', 'JSP指令用来设置整个JSP页面相关的属性，如网页的编码方式和脚本语言。', 1, '2024-04-17 15:49:28', '2024-04-17 15:49:28', NULL);
INSERT INTO `topic` VALUES (162, 1, 'JSP中有哪些不同类型的指令？', '选项1\n选项2\n选项3\n选项4', NULL, 4, '包含指令(Include directive)\n页面指令(Page directive)\nTaglib指令', 25, '中等', '包含指令(Include directive)：用来包含文件和合并文件内容到当前的页面。\n页面指令(Page directive)：用来定义JSP页面中特定的属性，比如错误页面和缓冲区。\nTaglib指令： 用来声明页面中使用的自定义的标签库。', 1, '2024-04-17 15:49:28', '2024-04-17 15:49:28', NULL);
INSERT INTO `topic` VALUES (163, 1, '研究数据结构就是研究', '数据的逻辑结构\n数据的存储结构\n数据的逻辑结构和存储结构\n数据的逻辑结构、存储结构及其基本操作', NULL, 0, '数据的逻辑结构、存储结构及其基本操作', 10, '中等', '无', 1, '2024-04-17 16:01:12', '2024-04-17 16:01:12', NULL);
INSERT INTO `topic` VALUES (164, 1, '链表适用于（）查找', '顺序\n二分法\n顺序和二分法\n随机', NULL, 0, '顺序', 10, '中等', '无', 1, '2024-04-17 16:01:12', '2024-04-17 16:01:12', NULL);
INSERT INTO `topic` VALUES (165, 1, '数据的存储结构有', '顺序存储\n链式存储\n索引存储\n散列存储', NULL, 1, '\n顺序存储\n链式存储\n索引存储\n散列存储', 10, '中等', '请输入答案分析', 1, '2024-04-17 16:01:12', '2024-04-17 16:01:12', NULL);
INSERT INTO `topic` VALUES (166, 1, '请输入题目标题', '选项1\n选项2\n选项3\n选项4', NULL, 2, 'false', 10, '中等', '请输入答案分析', 1, '2024-04-17 16:01:12', '2024-04-17 16:01:12', NULL);
INSERT INTO `topic` VALUES (167, 1, '数据结构按逻辑结构可分为两大类，它们分别是___和___', '选项1\n选项2\n选项3\n选项4', NULL, 3, '线性结构\n非线性结构', 10, '中等', '无', 1, '2024-04-17 16:01:12', '2024-04-17 16:01:12', NULL);
INSERT INTO `topic` VALUES (168, 1, '数据的运算最常用的有5种，它们分别是___、___、___、___、___。', '选项1\n选项2\n选项3\n选项4', NULL, 3, '插入\n删除\n修改\n查找\n排序', 10, '中等', '请输入答案分析', 1, '2024-04-17 16:01:12', '2024-04-17 16:01:12', NULL);
INSERT INTO `topic` VALUES (169, 1, '一个算法的效率可分为___和___。', '选项1\n选项2\n选项3\n选项4', NULL, 3, '时间效率\n空间效率', 10, '中等', '无', 1, '2024-04-17 16:01:12', '2024-04-17 16:01:12', NULL);
INSERT INTO `topic` VALUES (170, 1, '请输入题目标题', '选项1\n选项2\n选项3\n选项4', NULL, 4, '3\n33\n123', 10, '中等', '请输入答案分析', 1, '2024-04-17 16:01:12', '2024-04-17 16:01:12', NULL);
INSERT INTO `topic` VALUES (171, 1, '研究数据结构就是研究', '数据的逻辑结构\n数据的存储结构\n数据的逻辑结构和存储结构\n数据的逻辑结构、存储结构及其基本操作', NULL, 0, '数据的逻辑结构、存储结构及其基本操作', 10, '中等', '无', 1, '2024-04-17 16:36:44', '2024-04-17 16:36:44', NULL);
INSERT INTO `topic` VALUES (172, 1, '链表适用于（）查找', '顺序\n二分法\n顺序和二分法\n随机', NULL, 0, '顺序', 10, '中等', '无', 1, '2024-04-17 16:36:44', '2024-04-17 16:36:44', NULL);
INSERT INTO `topic` VALUES (173, 1, '数据的存储结构有', '顺序存储\n链式存储\n索引存储\n散列存储', NULL, 1, '顺序存储\n链式存储\n散列存储\n索引存储', 10, '中等', '请输入答案分析', 1, '2024-04-17 16:36:44', '2024-04-17 16:36:44', NULL);
INSERT INTO `topic` VALUES (174, 1, '线性表有两种存储方式，分别是', '顺序存储\n链式存储', NULL, 1, '顺序存储\n链式存储', 10, '中等', '请输入答案分析', 1, '2024-04-17 16:36:44', '2024-04-17 16:36:44', NULL);
INSERT INTO `topic` VALUES (175, 1, '请输入题目标题', '选项1\n选项2\n选项3\n选项4', NULL, 2, 'false', 10, '中等', '请输入答案分析', 1, '2024-04-17 16:36:44', '2024-04-17 16:36:44', NULL);
INSERT INTO `topic` VALUES (176, 1, '数据结构按逻辑结构可分为两大类，它们分别是___和___', '选项1\n选项2\n选项3\n选项4', NULL, 3, '线性结构\n非线性结构', 10, '中等', '无', 1, '2024-04-17 16:36:44', '2024-04-17 16:36:44', NULL);
INSERT INTO `topic` VALUES (177, 1, '数据的运算最常用的有5种，它们分别是___、___、___、___、___。', '选项1\n选项2\n选项3\n选项4', NULL, 3, '插入\n删除\n修改\n查找\n排序', 10, '中等', '请输入答案分析', 1, '2024-04-17 16:36:44', '2024-04-17 16:36:44', NULL);
INSERT INTO `topic` VALUES (178, 1, '一个算法的效率可分为___和___。', '选项1\n选项2\n选项3\n选项4', NULL, 3, '时间效率\n空间效率', 10, '中等', '无', 1, '2024-04-17 16:36:44', '2024-04-17 16:36:44', NULL);
INSERT INTO `topic` VALUES (179, 1, '请输入题目标题', '选项1\n选项2\n选项3\n选项4', NULL, 4, '3\n33\n123', 10, '中等', '请输入答案分析', 1, '2024-04-17 16:36:44', '2024-04-17 16:36:44', NULL);
INSERT INTO `topic` VALUES (180, 1, '研究数据结构就是研究', '数据的逻辑结构\n数据的存储结构\n数据的逻辑结构和存储结构\n数据的逻辑结构、存储结构及其基本操作', NULL, 0, '数据的逻辑结构、存储结构及其基本操作', 10, '中等', '无', 1, '2024-04-17 16:37:47', '2024-04-17 16:37:47', NULL);
INSERT INTO `topic` VALUES (181, 1, '链表适用于（）查找', '顺序\n二分法\n顺序和二分法\n随机', NULL, 0, '顺序', 10, '中等', '无', 1, '2024-04-17 16:37:47', '2024-04-17 16:37:47', NULL);
INSERT INTO `topic` VALUES (182, 1, '数据的存储结构有', '顺序存储\n链式存储\n索引存储\n散列存储', NULL, 1, '顺序存储\n链式存储\n散列存储\n索引存储', 10, '中等', '请输入答案分析', 1, '2024-04-17 16:37:47', '2024-04-17 16:37:47', NULL);
INSERT INTO `topic` VALUES (183, 1, '线性表有两种存储方式，分别是', '顺序存储\n链式存储', NULL, 1, '顺序存储\n链式存储', 10, '中等', '请输入答案分析', 1, '2024-04-17 16:37:47', '2024-04-17 16:37:47', NULL);
INSERT INTO `topic` VALUES (184, 1, '请输入题目标题', '选项1\n选项2\n选项3\n选项4', NULL, 2, 'false', 10, '中等', '请输入答案分析', 1, '2024-04-17 16:37:47', '2024-04-17 16:37:47', NULL);
INSERT INTO `topic` VALUES (185, 1, '数据结构按逻辑结构可分为两大类，它们分别是___和___', '选项1\n选项2\n选项3\n选项4', NULL, 3, '线性结构\n非线性结构', 10, '中等', '无', 1, '2024-04-17 16:37:47', '2024-04-17 16:37:47', NULL);
INSERT INTO `topic` VALUES (186, 1, '数据的运算最常用的有5种，它们分别是___、___、___、___、___。', '选项1\n选项2\n选项3\n选项4', NULL, 3, '插入\n删除\n修改\n查找\n排序', 10, '中等', '请输入答案分析', 1, '2024-04-17 16:37:47', '2024-04-17 16:37:47', NULL);
INSERT INTO `topic` VALUES (187, 1, '一个算法的效率可分为___和___。', '选项1\n选项2\n选项3\n选项4', NULL, 3, '时间效率\n空间效率', 10, '中等', '无', 1, '2024-04-17 16:37:47', '2024-04-17 16:37:47', NULL);
INSERT INTO `topic` VALUES (188, 1, '请输入题目标题', '选项1\n选项2\n选项3\n选项4', NULL, 4, '3\n33\n123', 10, '中等', '请输入答案分析', 1, '2024-04-17 16:37:47', '2024-04-17 16:37:47', NULL);
INSERT INTO `topic` VALUES (189, 1, '研究数据结构就是研究', '数据的逻辑结构\n数据的存储结构\n数据的逻辑结构和存储结构\n数据的逻辑结构、存储结构及其基本操作', NULL, 0, '数据的逻辑结构、存储结构及其基本操作', 10, '中等', '无', 1, '2024-04-17 17:32:48', '2024-04-17 17:32:48', NULL);
INSERT INTO `topic` VALUES (190, 1, '链表适用于（）查找', '顺序\n二分法\n顺序和二分法\n随机', NULL, 0, '顺序', 10, '中等', '无', 1, '2024-04-17 17:32:48', '2024-04-17 17:32:48', NULL);
INSERT INTO `topic` VALUES (191, 1, '数据的存储结构有', '顺序存储\n链式存储\n索引存储\n散列存储', NULL, 1, '顺序存储\n链式存储\n散列存储\n索引存储', 10, '中等', '请输入答案分析', 1, '2024-04-17 17:32:48', '2024-04-17 17:32:48', NULL);
INSERT INTO `topic` VALUES (192, 1, '线性表有两种存储方式，分别是', '顺序存储\n链式存储', NULL, 1, '顺序存储\n链式存储', 10, '中等', '请输入答案分析', 1, '2024-04-17 17:32:48', '2024-04-17 17:32:48', NULL);
INSERT INTO `topic` VALUES (193, 1, '请输入题目标题', '选项1\n选项2\n选项3\n选项4', NULL, 2, 'false', 10, '中等', '请输入答案分析', 1, '2024-04-17 17:32:48', '2024-04-17 17:32:48', NULL);
INSERT INTO `topic` VALUES (194, 1, '数据结构按逻辑结构可分为两大类，它们分别是___和___', '选项1\n选项2\n选项3\n选项4', NULL, 3, '线性结构\n非线性结构', 10, '中等', '无', 1, '2024-04-17 17:32:48', '2024-04-17 17:32:48', NULL);
INSERT INTO `topic` VALUES (195, 1, '数据的运算最常用的有5种，它们分别是___、___、___、___、___。', '选项1\n选项2\n选项3\n选项4', NULL, 3, '插入\n删除\n修改\n查找\n排序', 10, '中等', '请输入答案分析', 1, '2024-04-17 17:32:48', '2024-04-17 17:32:48', NULL);
INSERT INTO `topic` VALUES (196, 1, '一个算法的效率可分为___和___。', '选项1\n选项2\n选项3\n选项4', NULL, 3, '时间效率\n空间效率', 10, '中等', '无', 1, '2024-04-17 17:32:48', '2024-04-17 17:32:48', NULL);
INSERT INTO `topic` VALUES (197, 1, '请输入题目标题', '选项1\n选项2\n选项3\n选项4', NULL, 4, '3\n33\n123', 10, '中等', '请输入答案分析', 1, '2024-04-17 17:32:48', '2024-04-17 17:32:48', NULL);
INSERT INTO `topic` VALUES (198, 1, '研究数据结构就是研究', '数据的逻辑结构\n数据的存储结构\n数据的逻辑结构和存储结构\n数据的逻辑结构、存储结构及其基本操作', NULL, 0, '数据的逻辑结构、存储结构及其基本操作', 10, '中等', '无', 1, '2024-04-18 15:17:35', '2024-04-18 15:17:35', NULL);
INSERT INTO `topic` VALUES (199, 1, '链表适用于（）查找', '顺序\n二分法\n顺序和二分法\n随机', NULL, 0, '顺序', 10, '中等', '无', 1, '2024-04-18 15:17:35', '2024-04-18 15:17:35', NULL);
INSERT INTO `topic` VALUES (200, 1, '数据的存储结构有', '顺序存储\n链式存储\n索引存储\n散列存储', NULL, 1, '顺序存储\n链式存储\n散列存储\n索引存储', 10, '中等', '请输入答案分析', 1, '2024-04-18 15:17:35', '2024-04-18 15:17:35', NULL);
INSERT INTO `topic` VALUES (201, 1, '线性表有两种存储方式，分别是', '顺序存储\n链式存储', NULL, 1, '顺序存储\n链式存储', 10, '中等', '请输入答案分析', 1, '2024-04-18 15:17:35', '2024-04-18 15:17:35', NULL);
INSERT INTO `topic` VALUES (202, 1, '请输入题目标题', '选项1\n选项2\n选项3\n选项4', NULL, 2, 'false', 10, '中等', '请输入答案分析', 1, '2024-04-18 15:17:35', '2024-04-18 15:17:35', NULL);
INSERT INTO `topic` VALUES (203, 1, '数据结构按逻辑结构可分为两大类，它们分别是___和___', '选项1\n选项2\n选项3\n选项4', NULL, 3, '线性结构\n非线性结构', 10, '中等', '无', 1, '2024-04-18 15:17:35', '2024-04-18 15:17:35', NULL);
INSERT INTO `topic` VALUES (204, 1, '数据的运算最常用的有5种，它们分别是___、___、___、___、___。', '选项1\n选项2\n选项3\n选项4', NULL, 3, '插入\n删除\n修改\n查找\n排序', 10, '中等', '请输入答案分析', 1, '2024-04-18 15:17:35', '2024-04-18 15:17:35', NULL);
INSERT INTO `topic` VALUES (205, 1, '一个算法的效率可分为___和___。', '选项1\n选项2\n选项3\n选项4', NULL, 3, '时间效率\n空间效率', 10, '中等', '无', 1, '2024-04-18 15:17:35', '2024-04-18 15:17:35', NULL);
INSERT INTO `topic` VALUES (206, 1, '直接插入排序和折半插入排序的相同点和区别？', '选项1\n选项2\n选项3\n选项4', NULL, 4, '相同点：二者都将待插入元素插入前面的有序子表。排序的总趟数取决于元素个数n，两者都是n-1趟。元素的移动次数都取决于初始序列，二者相同。适用辅助空间的数量都是O(1)。都是稳定的排序算法。\n区别：确定当前记录在前面有序子表中的位置时，直接插入排序采用顺序查找法，而折半插入排序采用折半查找法。折半插入排序的比较次数与序列初态无关，为O(nlog2n)；而直接插入排序的比较次数与序列初态有关，为O(n)~O(n^2)。', 20, '中等', '①相同点：二者都将待插入元素插入前面的有序子表。排序的总趟数取决于元素个数n，两者都是n-1趟。元素的移动次数都取决于初始序列，二者相同。适用辅助空间的数量都是O(1)。都是稳定的排序算法。\n\n②区别：确定当前记录在前面有序子表中的位置时，直接插入排序采用顺序查找法，而折半插入排序采用折半查找法。折半插入排序的比较次数与序列初态无关，为；而直接插入排序的比较次数与序列初态有关，为O(n)~O(n^2)。', 1, '2024-04-18 15:17:35', '2024-04-18 15:17:35', NULL);
INSERT INTO `topic` VALUES (207, 1, '研究数据结构就是研究', '数据的逻辑结构\n数据的存储结构\n数据的逻辑结构和存储结构\n数据的逻辑结构、存储结构及其基本操作', NULL, 0, '数据的逻辑结构、存储结构及其基本操作', 10, '中等', '无', 1, '2024-04-18 15:18:13', '2024-04-18 15:18:13', NULL);
INSERT INTO `topic` VALUES (208, 1, '链表适用于（）查找', '顺序\n二分法\n顺序和二分法\n随机', NULL, 0, '顺序', 10, '中等', '无', 1, '2024-04-18 15:18:13', '2024-04-18 15:18:13', NULL);
INSERT INTO `topic` VALUES (209, 1, '数据的存储结构有', '顺序存储\n链式存储\n索引存储\n散列存储', NULL, 1, '顺序存储\n链式存储\n散列存储\n索引存储', 10, '中等', '请输入答案分析', 1, '2024-04-18 15:18:13', '2024-04-18 15:18:13', NULL);
INSERT INTO `topic` VALUES (210, 1, '线性表有两种存储方式，分别是', '顺序存储\n链式存储', NULL, 1, '顺序存储\n链式存储', 10, '中等', '请输入答案分析', 1, '2024-04-18 15:18:13', '2024-04-18 15:18:13', NULL);
INSERT INTO `topic` VALUES (211, 1, '请输入题目标题', '选项1\n选项2\n选项3\n选项4', NULL, 2, 'false', 10, '中等', '请输入答案分析', 1, '2024-04-18 15:18:13', '2024-04-18 15:18:13', NULL);
INSERT INTO `topic` VALUES (212, 1, '数据结构按逻辑结构可分为两大类，它们分别是___和___', '选项1\n选项2\n选项3\n选项4', NULL, 3, '线性结构\n非线性结构', 10, '中等', '无', 1, '2024-04-18 15:18:13', '2024-04-18 15:18:13', NULL);
INSERT INTO `topic` VALUES (213, 1, '数据的运算最常用的有5种，它们分别是___、___、___、___、___。', '选项1\n选项2\n选项3\n选项4', NULL, 3, '插入\n删除\n修改\n查找\n排序', 10, '中等', '请输入答案分析', 1, '2024-04-18 15:18:13', '2024-04-18 15:18:13', NULL);
INSERT INTO `topic` VALUES (214, 1, '一个算法的效率可分为___和___。', '选项1\n选项2\n选项3\n选项4', NULL, 3, '时间效率\n空间效率', 10, '中等', '无', 1, '2024-04-18 15:18:13', '2024-04-18 15:18:13', NULL);
INSERT INTO `topic` VALUES (215, 1, '直接插入排序和折半插入排序的相同点和区别？', '选项1\n选项2\n选项3\n选项4', NULL, 4, '相同点：二者都将待插入元素插入前面的有序子表。排序的总趟数取决于元素个数n，两者都是n-1趟。元素的移动次数都取决于初始序列，二者相同。适用辅助空间的数量都是O(1)。都是稳定的排序算法。\n区别：确定当前记录在前面有序子表中的位置时，直接插入排序采用顺序查找法，而折半插入排序采用折半查找法。折半插入排序的比较次数与序列初态无关，为O(nlog2n)；而直接插入排序的比较次数与序列初态有关，为O(n)~O(n^2)。', 20, '中等', '①相同点：二者都将待插入元素插入前面的有序子表。排序的总趟数取决于元素个数n，两者都是n-1趟。元素的移动次数都取决于初始序列，二者相同。适用辅助空间的数量都是O(1)。都是稳定的排序算法。\n\n②区别：确定当前记录在前面有序子表中的位置时，直接插入排序采用顺序查找法，而折半插入排序采用折半查找法。折半插入排序的比较次数与序列初态无关，为；而直接插入排序的比较次数与序列初态有关，为O(n)~O(n^2)。', 1, '2024-04-18 15:18:13', '2024-04-18 15:18:13', NULL);
INSERT INTO `topic` VALUES (216, 1, '研究数据结构就是研究', '数据的逻辑结构\n数据的存储结构\n数据的逻辑结构和存储结构\n数据的逻辑结构、存储结构及其基本操作', NULL, 0, '数据的逻辑结构、存储结构及其基本操作', 10, '中等', '无', 1, '2024-04-18 21:22:59', '2024-04-18 21:22:59', NULL);
INSERT INTO `topic` VALUES (217, 1, '链表适用于（）查找', '顺序\n二分法\n顺序和二分法\n随机', NULL, 0, '顺序', 10, '中等', '无', 1, '2024-04-18 21:22:59', '2024-04-18 21:22:59', NULL);
INSERT INTO `topic` VALUES (218, 1, '数据的存储结构有', '顺序存储\n链式存储\n索引存储\n散列存储', NULL, 1, '顺序存储\n链式存储\n散列存储\n索引存储', 10, '中等', '请输入答案分析', 1, '2024-04-18 21:22:59', '2024-04-18 21:22:59', NULL);
INSERT INTO `topic` VALUES (219, 1, '线性表有两种存储方式，分别是', '顺序存储\n链式存储', NULL, 1, '顺序存储\n链式存储', 10, '中等', '请输入答案分析', 1, '2024-04-18 21:22:59', '2024-04-18 21:22:59', NULL);
INSERT INTO `topic` VALUES (220, 1, '请输入题目标题', '选项1\n选项2\n选项3\n选项4', NULL, 2, 'false', 10, '中等', '请输入答案分析', 1, '2024-04-18 21:22:59', '2024-04-18 21:22:59', NULL);
INSERT INTO `topic` VALUES (221, 1, '数据结构按逻辑结构可分为两大类，它们分别是___和___', '选项1\n选项2\n选项3\n选项4', NULL, 3, '线性结构\n非线性结构', 10, '中等', '无', 1, '2024-04-18 21:22:59', '2024-04-18 21:22:59', NULL);
INSERT INTO `topic` VALUES (222, 1, '数据的运算最常用的有5种，它们分别是___、___、___、___、___。', '选项1\n选项2\n选项3\n选项4', NULL, 3, '插入\n删除\n修改\n查找\n排序', 10, '中等', '请输入答案分析', 1, '2024-04-18 21:22:59', '2024-04-18 21:22:59', NULL);
INSERT INTO `topic` VALUES (223, 1, '一个算法的效率可分为___和___。', '选项1\n选项2\n选项3\n选项4', NULL, 3, '时间效率\n空间效率', 10, '中等', '无', 1, '2024-04-18 21:22:59', '2024-04-18 21:22:59', NULL);
INSERT INTO `topic` VALUES (224, 1, '直接插入排序和折半插入排序的相同点和区别？', '选项1\n选项2\n选项3\n选项4', NULL, 4, '相同点：二者都将待插入元素插入前面的有序子表。排序的总趟数取决于元素个数n，两者都是n-1趟。元素的移动次数都取决于初始序列，二者相同。适用辅助空间的数量都是O(1)。都是稳定的排序算法。\n区别：确定当前记录在前面有序子表中的位置时，直接插入排序采用顺序查找法，而折半插入排序采用折半查找法。折半插入排序的比较次数与序列初态无关，为O(nlog2n)；而直接插入排序的比较次数与序列初态有关，为O(n)~O(n^2)。', 20, '中等', '①相同点：二者都将待插入元素插入前面的有序子表。排序的总趟数取决于元素个数n，两者都是n-1趟。元素的移动次数都取决于初始序列，二者相同。适用辅助空间的数量都是O(1)。都是稳定的排序算法。\n\n②区别：确定当前记录在前面有序子表中的位置时，直接插入排序采用顺序查找法，而折半插入排序采用折半查找法。折半插入排序的比较次数与序列初态无关，为；而直接插入排序的比较次数与序列初态有关，为O(n)~O(n^2)。', 1, '2024-04-18 21:22:59', '2024-04-18 21:22:59', NULL);
INSERT INTO `topic` VALUES (225, 1, '研究数据结构就是研究', '数据的逻辑结构\n数据的存储结构\n数据的逻辑结构和存储结构\n数据的逻辑结构、存储结构及其基本操作', NULL, 0, '数据的逻辑结构、存储结构及其基本操作', 10, '中等', '无', 1, '2024-04-18 21:34:51', '2024-04-18 21:34:51', NULL);
INSERT INTO `topic` VALUES (226, 1, '链表适用于（）查找', '顺序\n二分法\n顺序和二分法\n随机', NULL, 0, '顺序', 10, '中等', '无', 1, '2024-04-18 21:34:51', '2024-04-18 21:34:51', NULL);
INSERT INTO `topic` VALUES (227, 1, '1+1', '1\n2\n3\n4', NULL, 0, '2', 10, '中等', '请输入答案分析', 1, '2024-04-18 21:34:51', '2024-04-18 21:34:51', NULL);
INSERT INTO `topic` VALUES (228, 1, '数据的存储结构有', '顺序存储\n链式存储\n索引存储\n散列存储', NULL, 1, '顺序存储\n链式存储\n散列存储\n索引存储', 10, '中等', '请输入答案分析', 1, '2024-04-18 21:34:51', '2024-04-18 21:34:51', NULL);
INSERT INTO `topic` VALUES (229, 1, '线性表有两种存储方式，分别是', '顺序存储\n链式存储', NULL, 1, '顺序存储\n链式存储', 10, '中等', '请输入答案分析', 1, '2024-04-18 21:34:51', '2024-04-18 21:34:51', NULL);
INSERT INTO `topic` VALUES (230, 1, '请输入题目标题', '选项1\n选项2\n选项3\n选项4', NULL, 2, 'false', 10, '中等', '请输入答案分析', 1, '2024-04-18 21:34:51', '2024-04-18 21:34:51', NULL);
INSERT INTO `topic` VALUES (231, 1, '数据结构按逻辑结构可分为两大类，它们分别是___和___', '选项1\n选项2\n选项3\n选项4', NULL, 3, '线性结构\n非线性结构', 10, '中等', '无', 1, '2024-04-18 21:34:51', '2024-04-18 21:34:51', NULL);
INSERT INTO `topic` VALUES (232, 1, '数据的运算最常用的有5种，它们分别是___、___、___、___、___。', '选项1\n选项2\n选项3\n选项4', NULL, 3, '插入\n删除\n修改\n查找\n排序', 10, '中等', '请输入答案分析', 1, '2024-04-18 21:34:51', '2024-04-18 21:34:51', NULL);
INSERT INTO `topic` VALUES (233, 1, '一个算法的效率可分为___和___。', '选项1\n选项2\n选项3\n选项4', NULL, 3, '时间效率\n空间效率', 10, '中等', '无', 1, '2024-04-18 21:34:51', '2024-04-18 21:34:51', NULL);
INSERT INTO `topic` VALUES (234, 1, '直接插入排序和折半插入排序的相同点和区别？', '选项1\n选项2\n选项3\n选项4', NULL, 4, '相同点：二者都将待插入元素插入前面的有序子表。排序的总趟数取决于元素个数n，两者都是n-1趟。元素的移动次数都取决于初始序列，二者相同。适用辅助空间的数量都是O(1)。都是稳定的排序算法。\n区别：确定当前记录在前面有序子表中的位置时，直接插入排序采用顺序查找法，而折半插入排序采用折半查找法。折半插入排序的比较次数与序列初态无关，为O(nlog2n)；而直接插入排序的比较次数与序列初态有关，为O(n)~O(n^2)。', 20, '中等', '①相同点：二者都将待插入元素插入前面的有序子表。排序的总趟数取决于元素个数n，两者都是n-1趟。元素的移动次数都取决于初始序列，二者相同。适用辅助空间的数量都是O(1)。都是稳定的排序算法。\n\n②区别：确定当前记录在前面有序子表中的位置时，直接插入排序采用顺序查找法，而折半插入排序采用折半查找法。折半插入排序的比较次数与序列初态无关，为；而直接插入排序的比较次数与序列初态有关，为O(n)~O(n^2)。', 1, '2024-04-18 21:34:51', '2024-04-18 21:34:51', NULL);
INSERT INTO `topic` VALUES (235, 1, '研究数据结构就是研究', '数据的逻辑结构\n数据的存储结构\n数据的逻辑结构和存储结构\n数据的逻辑结构、存储结构及其基本操作', NULL, 0, '数据的逻辑结构、存储结构及其基本操作', 10, '中等', '无', 1, '2024-04-18 21:37:38', '2024-04-18 21:37:38', NULL);
INSERT INTO `topic` VALUES (236, 1, '链表适用于（）查找', '顺序\n二分法\n顺序和二分法\n随机', NULL, 0, '顺序', 10, '中等', '无', 1, '2024-04-18 21:37:38', '2024-04-18 21:37:38', NULL);
INSERT INTO `topic` VALUES (237, 1, '1+1', '1\n2\n3\n4', NULL, 0, '1', 10, '中等', '请输入答案分析', 1, '2024-04-18 21:37:38', '2024-04-18 21:37:38', NULL);
INSERT INTO `topic` VALUES (238, 1, '数据的存储结构有', '顺序存储\n链式存储\n索引存储\n散列存储', NULL, 1, '顺序存储\n链式存储\n散列存储\n索引存储', 10, '中等', '请输入答案分析', 1, '2024-04-18 21:37:38', '2024-04-18 21:37:38', NULL);
INSERT INTO `topic` VALUES (239, 1, '线性表有两种存储方式，分别是', '顺序存储\n链式存储', NULL, 1, '顺序存储\n链式存储', 10, '中等', '请输入答案分析', 1, '2024-04-18 21:37:38', '2024-04-18 21:37:38', NULL);
INSERT INTO `topic` VALUES (240, 1, '请输入题目标题', '选项1\n选项2\n选项3\n选项4', NULL, 2, 'false', 10, '中等', '请输入答案分析', 1, '2024-04-18 21:37:38', '2024-04-18 21:37:38', NULL);
INSERT INTO `topic` VALUES (241, 1, '数据结构按逻辑结构可分为两大类，它们分别是___和___', '选项1\n选项2\n选项3\n选项4', NULL, 3, '线性结构\n非线性结构', 10, '中等', '无', 1, '2024-04-18 21:37:38', '2024-04-18 21:37:38', NULL);
INSERT INTO `topic` VALUES (242, 1, '数据的运算最常用的有5种，它们分别是___、___、___、___、___。', '选项1\n选项2\n选项3\n选项4', NULL, 3, '插入\n删除\n修改\n查找\n排序', 10, '中等', '请输入答案分析', 1, '2024-04-18 21:37:38', '2024-04-18 21:37:38', NULL);
INSERT INTO `topic` VALUES (243, 1, '一个算法的效率可分为___和___。', '选项1\n选项2\n选项3\n选项4', NULL, 3, '时间效率\n空间效率', 10, '中等', '无', 1, '2024-04-18 21:37:38', '2024-04-18 21:37:38', NULL);
INSERT INTO `topic` VALUES (244, 1, '直接插入排序和折半插入排序的相同点和区别？', '选项1\n选项2\n选项3\n选项4', NULL, 4, '相同点：二者都将待插入元素插入前面的有序子表。排序的总趟数取决于元素个数n，两者都是n-1趟。元素的移动次数都取决于初始序列，二者相同。适用辅助空间的数量都是O(1)。都是稳定的排序算法。\n区别：确定当前记录在前面有序子表中的位置时，直接插入排序采用顺序查找法，而折半插入排序采用折半查找法。折半插入排序的比较次数与序列初态无关，为O(nlog2n)；而直接插入排序的比较次数与序列初态有关，为O(n)~O(n^2)。', 20, '中等', '①相同点：二者都将待插入元素插入前面的有序子表。排序的总趟数取决于元素个数n，两者都是n-1趟。元素的移动次数都取决于初始序列，二者相同。适用辅助空间的数量都是O(1)。都是稳定的排序算法。\n\n②区别：确定当前记录在前面有序子表中的位置时，直接插入排序采用顺序查找法，而折半插入排序采用折半查找法。折半插入排序的比较次数与序列初态无关，为；而直接插入排序的比较次数与序列初态有关，为O(n)~O(n^2)。', 1, '2024-04-18 21:37:38', '2024-04-18 21:37:38', NULL);
INSERT INTO `topic` VALUES (253, 24, '（）反映数据的精细化程度，越细化的数据，价值越高。', '规模\n活性\n关联度\n颗粒度', NULL, 0, '颗粒度', 10, '中等', '无', 1, '2024-04-20 21:27:00', '2024-04-20 21:27:00', NULL);
INSERT INTO `topic` VALUES (254, 24, '在收集数据时，数据来源包含两种方式，这两种方式是（）', '直接数据\n移动端数据', NULL, 0, '选项3', 10, '中等', '请输入答案分析', 1, '2024-04-20 21:27:00', '2024-04-20 21:27:00', NULL);
INSERT INTO `topic` VALUES (255, 24, '关于Hadoop MapReduce分片（split）概念，下列说法不正确的是()', 'Hadoop为每个split创建一个Map任务\nsplit的多少决定了Map任务的数目\n在大多数情况下，理想的分片大小是一个HDFS块对应一个split\nsplit是一个物理概念', NULL, 1, 'Hadoop为每个split创建一个Map任务\nsplit的多少决定了Map任务的数目\n在大多数情况下，理想的分片大小是一个HDFS块对应一个split', 10, '中等', '无', 1, '2024-04-20 21:27:00', '2024-04-20 21:27:00', NULL);
INSERT INTO `topic` VALUES (256, 24, '数据采集指新的数据产生或现有数据内容发生显著改变或更新的阶段。', '选项1\n选项2\n选项3\n选项4', NULL, 2, 'true', 10, '中等', '无', 1, '2024-04-20 21:27:00', '2024-04-20 21:27:00', NULL);
INSERT INTO `topic` VALUES (257, 24, 'WMware提供两种类型的克隆，是___和___', '选项1\n选项2\n选项3\n选项4', NULL, 3, '完全克隆\n链接克隆', 10, '中等', '完全克隆的虚拟机不依赖源虚拟机，是完全独立的虚拟机，它的性能与被克隆虚拟机相同。由于完整克隆不与父虚拟机共享虚拟磁盘，所以创建完整克隆所需的时间比链接克隆更长。如果涉及的文件较大，完整克隆可能需要数分钟才能创建完成。完整克隆只复制克隆操作时的虚拟机状态，因此无法访问父虚拟机的快照。\n链接克隆是通过父虚拟机的快照创建而成，因此节省了磁盘空间，而且克隆速度非常快，但是克隆后的虚拟机性能能会有所下降。但是如果父虚拟机损坏或快照点删除，链接克隆的虚拟机也不能使用；如果父虚拟机移动位置，需要重新指定父虚拟机的位置，再启动链接克隆虚拟机。', 1, '2024-04-20 21:27:00', '2024-04-20 21:27:00', NULL);
INSERT INTO `topic` VALUES (258, 24, '数据分析的步骤通常有哪些？', '选项1\n选项2\n选项3\n选项4', NULL, 4, '收集数据\n清理数据\n探索性数据分析\n数据预处理\n数据建模\n解释结果\n结果呈现', 20, '中等', '收集数据：收集与研究目标相关的数据；清理数据：清除数据中的错误、缺失或重复项；探索性数据分析：通过可视化和摘要统计量来了解数据的特征；数据预处理：对数据进行转换、归一花或标准化，以便更好地进行分析；数据建模：使用统计模型或机器学习算法来分析数据；解释结果：解释模型的结果，并从中提取有用的见解；结果呈现：使用可视化工具将结果以易于理解的方式呈现出来。', 1, '2024-04-20 21:27:00', '2024-04-20 21:27:00', NULL);
INSERT INTO `topic` VALUES (259, 24, '什么是数据可视化？', '选项1\n选项2\n选项3\n选项4', NULL, 4, '使用图表、图形和其他可视元素将数据呈现出来的过程。\n通过可视化可以更好地理解数据的模式、关系和趋势\n常见的数据可视化工具包括折线图、柱状图、散点图和热力图等。', 20, '中等', '请输入答案分析', 1, '2024-04-20 21:27:00', '2024-04-20 21:27:00', NULL);
INSERT INTO `topic` VALUES (260, 24, '（）反映数据的精细化程度，越细化的数据，价值越高。', '规模\n活性\n关联度\n颗粒度', NULL, 0, '颗粒度', 10, '中等', '无', 1, '2024-04-20 21:44:09', '2024-04-20 21:44:09', NULL);
INSERT INTO `topic` VALUES (261, 24, '在收集数据时，数据来源包含两种方式，这两种方式是（）', '直接数据\n移动端数据', NULL, 0, '选项3', 10, '中等', '请输入答案分析', 1, '2024-04-20 21:44:09', '2024-04-20 21:44:09', NULL);
INSERT INTO `topic` VALUES (262, 24, '关于Hadoop MapReduce分片（split）概念，下列说法不正确的是()', 'Hadoop为每个split创建一个Map任务\nsplit的多少决定了Map任务的数目\n在大多数情况下，理想的分片大小是一个HDFS块对应一个split\nsplit是一个物理概念', NULL, 1, 'Hadoop为每个split创建一个Map任务\nsplit的多少决定了Map任务的数目\n在大多数情况下，理想的分片大小是一个HDFS块对应一个split', 10, '中等', '无', 1, '2024-04-20 21:44:09', '2024-04-20 21:44:09', NULL);
INSERT INTO `topic` VALUES (263, 24, '调用Zookeeper客户端命令中包含哪些信息？', 'ip地址\n端口号\n服务器名称\n用户名', NULL, 1, 'ip地址\n端口号\n服务器名称\n用户名', 10, '中等', '无', 1, '2024-04-20 21:44:09', '2024-04-20 21:44:09', NULL);
INSERT INTO `topic` VALUES (264, 24, '数据采集指新的数据产生或现有数据内容发生显著改变或更新的阶段。', '选项1\n选项2\n选项3\n选项4', NULL, 2, 'true', 10, '中等', '无', 1, '2024-04-20 21:44:09', '2024-04-20 21:44:09', NULL);
INSERT INTO `topic` VALUES (265, 24, 'WMware提供两种类型的克隆，是___和___', '选项1\n选项2\n选项3\n选项4', NULL, 3, '完全克隆\n链接克隆', 10, '中等', '完全克隆的虚拟机不依赖源虚拟机，是完全独立的虚拟机，它的性能与被克隆虚拟机相同。由于完整克隆不与父虚拟机共享虚拟磁盘，所以创建完整克隆所需的时间比链接克隆更长。如果涉及的文件较大，完整克隆可能需要数分钟才能创建完成。完整克隆只复制克隆操作时的虚拟机状态，因此无法访问父虚拟机的快照。\n链接克隆是通过父虚拟机的快照创建而成，因此节省了磁盘空间，而且克隆速度非常快，但是克隆后的虚拟机性能能会有所下降。但是如果父虚拟机损坏或快照点删除，链接克隆的虚拟机也不能使用；如果父虚拟机移动位置，需要重新指定父虚拟机的位置，再启动链接克隆虚拟机。', 1, '2024-04-20 21:44:09', '2024-04-20 21:44:09', NULL);
INSERT INTO `topic` VALUES (266, 24, '数据分析的步骤通常有哪些？', '选项1\n选项2\n选项3\n选项4', NULL, 4, '收集数据\n清理数据\n探索性数据分析\n数据预处理\n数据建模\n解释结果\n结果呈现', 20, '中等', '收集数据：收集与研究目标相关的数据；清理数据：清除数据中的错误、缺失或重复项；探索性数据分析：通过可视化和摘要统计量来了解数据的特征；数据预处理：对数据进行转换、归一花或标准化，以便更好地进行分析；数据建模：使用统计模型或机器学习算法来分析数据；解释结果：解释模型的结果，并从中提取有用的见解；结果呈现：使用可视化工具将结果以易于理解的方式呈现出来。', 1, '2024-04-20 21:44:09', '2024-04-20 21:44:09', NULL);
INSERT INTO `topic` VALUES (267, 24, '什么是数据可视化？', '选项1\n选项2\n选项3\n选项4', NULL, 4, '使用图表、图形和其他可视元素将数据呈现出来的过程。\n通过可视化可以更好地理解数据的模式、关系和趋势\n常见的数据可视化工具包括折线图、柱状图、散点图和热力图等。', 20, '中等', '请输入答案分析', 1, '2024-04-20 21:44:09', '2024-04-20 21:44:09', NULL);
INSERT INTO `topic` VALUES (268, 24, '（）反映数据的精细化程度，越细化的数据，价值越高。', '规模\n活性\n关联度\n颗粒度', NULL, 0, '颗粒度', 10, '中等', '无', 1, '2024-04-20 21:53:00', '2024-04-20 21:53:00', NULL);
INSERT INTO `topic` VALUES (269, 24, '在收集数据时，数据来源包含两种方式，这两种方式是（）', '直接数据\n移动端数据', NULL, 0, '选项3', 10, '中等', '请输入答案分析', 1, '2024-04-20 21:53:00', '2024-04-20 21:53:00', NULL);
INSERT INTO `topic` VALUES (270, 24, '关于Hadoop MapReduce分片（split）概念，下列说法不正确的是()', 'Hadoop为每个split创建一个Map任务\nsplit的多少决定了Map任务的数目\n在大多数情况下，理想的分片大小是一个HDFS块对应一个split\nsplit是一个物理概念', NULL, 1, 'Hadoop为每个split创建一个Map任务\nsplit的多少决定了Map任务的数目\n在大多数情况下，理想的分片大小是一个HDFS块对应一个split', 10, '中等', '无', 1, '2024-04-20 21:53:00', '2024-04-20 21:53:00', NULL);
INSERT INTO `topic` VALUES (271, 24, '调用Zookeeper客户端命令中包含哪些信息？', 'ip地址\n端口号\n服务器名称\n用户名', NULL, 1, 'ip地址\n端口号\n服务器名称\n用户名', 10, '中等', '无', 1, '2024-04-20 21:53:00', '2024-04-20 21:53:00', NULL);
INSERT INTO `topic` VALUES (272, 24, '数据采集指新的数据产生或现有数据内容发生显著改变或更新的阶段。', '选项1\n选项2\n选项3\n选项4', NULL, 2, 'true', 10, '中等', '无', 1, '2024-04-20 21:53:00', '2024-04-20 21:53:00', NULL);
INSERT INTO `topic` VALUES (273, 24, 'WMware提供两种类型的克隆，是___和___', '选项1\n选项2\n选项3\n选项4', NULL, 3, '完全克隆\n链接克隆', 10, '中等', '完全克隆的虚拟机不依赖源虚拟机，是完全独立的虚拟机，它的性能与被克隆虚拟机相同。由于完整克隆不与父虚拟机共享虚拟磁盘，所以创建完整克隆所需的时间比链接克隆更长。如果涉及的文件较大，完整克隆可能需要数分钟才能创建完成。完整克隆只复制克隆操作时的虚拟机状态，因此无法访问父虚拟机的快照。\n链接克隆是通过父虚拟机的快照创建而成，因此节省了磁盘空间，而且克隆速度非常快，但是克隆后的虚拟机性能能会有所下降。但是如果父虚拟机损坏或快照点删除，链接克隆的虚拟机也不能使用；如果父虚拟机移动位置，需要重新指定父虚拟机的位置，再启动链接克隆虚拟机。', 1, '2024-04-20 21:53:00', '2024-04-20 21:53:00', NULL);
INSERT INTO `topic` VALUES (274, 24, '数据分析的步骤通常有哪些？', '选项1\n选项2\n选项3\n选项4', NULL, 4, '收集数据\n清理数据\n探索性数据分析\n数据预处理\n数据建模\n解释结果\n结果呈现', 20, '中等', '收集数据：收集与研究目标相关的数据；清理数据：清除数据中的错误、缺失或重复项；探索性数据分析：通过可视化和摘要统计量来了解数据的特征；数据预处理：对数据进行转换、归一花或标准化，以便更好地进行分析；数据建模：使用统计模型或机器学习算法来分析数据；解释结果：解释模型的结果，并从中提取有用的见解；结果呈现：使用可视化工具将结果以易于理解的方式呈现出来。', 1, '2024-04-20 21:53:00', '2024-04-20 21:53:00', NULL);
INSERT INTO `topic` VALUES (275, 24, '什么是数据可视化？', '选项1\n选项2\n选项3\n选项4', NULL, 4, '使用图表、图形和其他可视元素将数据呈现出来的过程。\n通过可视化可以更好地理解数据的模式、关系和趋势\n常见的数据可视化工具包括折线图、柱状图、散点图和热力图等。', 20, '中等', '请输入答案分析', 1, '2024-04-20 21:53:00', '2024-04-20 21:53:00', NULL);
INSERT INTO `topic` VALUES (276, 1, 'Spark是用以下哪种编程语言实现的？', 'C语言\nC++语言\nJava语言\nScala语言', NULL, 0, 'Scala语言', 10, '简单', 'Spark中用Scala开发语法简洁许多，且支持类型推断，可以大大提升开发效率。', 1, '2024-04-28 17:06:42', '2024-04-28 17:06:42', NULL);
INSERT INTO `topic` VALUES (277, 1, '在FusinlnsightManager界面中，对Lader的操作不包括下列哪个选项（）', '切换Lader主备节点\n启动Lader实例\n配置Lader参数\n查看Lader服务状态', NULL, 0, '切换Lader主备节点', 10, '中等', '在Fusinlnsight界面中，对Lader的操作不包括切换lader主备节点', 1, '2024-04-28 17:06:42', '2024-04-28 17:06:42', NULL);
INSERT INTO `topic` VALUES (278, 1, 'Hive不适用于以下哪个场景单选？', '非实时分析，例如日析\n数据挖掘，例如用户析，区域展示\n数据汇总，例如每天，每击数，点击排行\n实时在线数', NULL, 0, '实时在线数', 10, '中等', 'Hive不适用于实时在线数单选。由于hive主要用于数据分析，因此延时比较高，不适用于实时场景，适用于离线大数据分析。', 1, '2024-04-28 17:06:42', '2024-04-28 17:06:42', NULL);
INSERT INTO `topic` VALUES (279, 1, 'hadp平台中HBase的Regin是由哪个服务进程来管理？', 'HMaster\nDataNde\nReginServer\nZkeeper', NULL, 0, 'ReginServer', 10, '中等', 'Hadp平台中HBase的Regin是由ReginServer管理', 1, '2024-04-28 17:06:42', '2024-04-28 17:06:42', NULL);
INSERT INTO `topic` VALUES (280, 1, 'Hadp组件在企业应用中，能用于大数据集实时查询的产品有（）', 'Hive\nPig\nMahut\nHbase', NULL, 0, 'Hbase', 10, '中等', 'Hadp组件在企业应用中，能用于大数据集实时查询的产品有Hbase', 1, '2024-04-28 17:06:42', '2024-04-28 17:06:42', NULL);
INSERT INTO `topic` VALUES (281, 1, '下列选项中无法通过大数据技术实现的是？（）', '商业模式发现\n信用评估\n商品推荐\n运营分析', NULL, 0, '商业模式发现', 10, '中等', '商业模式发现无法通过大数据技术实现', 1, '2024-04-28 17:06:42', '2024-04-28 17:06:42', NULL);
INSERT INTO `topic` VALUES (282, 1, '日常数据通报型报告的特点错误的是（）', '进度性\n规范性\n时效性\n全面性', NULL, 0, '全面性', 10, '中等', '日常数据通报型报告的特点有进度性、规范性、时效性。\n日常数据通报是以定期数据分析报表为依据，反映计划执行情况，并分析影响和形成原因的一种数据分析报告。这种数据分析报告一般是按日、周、月、季、年等时间阶段定期进行，所以也叫定期分析报告。', 1, '2024-04-28 17:06:42', '2024-04-28 17:06:42', NULL);
INSERT INTO `topic` VALUES (283, 1, 'HBase依赖（）提供强大的计算能力', 'Prtbuf\nJava\nKafka\nChubby', NULL, 0, 'Chubby', 10, '中等', '谷歌收购云计算公司CuldSimple强化云计算能力', 1, '2024-04-28 17:06:42', '2024-04-28 17:06:42', NULL);
INSERT INTO `topic` VALUES (284, 1, '当前大数据技术的基础是由（）', 'Hive是一个建立在Hadp文件系统上的数据仓库架构，可以用其对HDFS上\n选项2\n选项3\n选项4', NULL, 0, '', 10, '中等', '请输入答案分析', 1, '2024-04-28 17:06:42', '2024-04-28 17:06:42', NULL);
INSERT INTO `topic` VALUES (285, 1, 'Spark是用以下哪种编程语言实现的？', 'C语言\nC++语言\nJava语言\nScala语言', NULL, 0, 'Scala语言', 10, '简单', 'Spark中用Scala开发语法简洁许多，且支持类型推断，可以大大提升开发效率。', 1, '2024-05-06 16:32:46', '2024-05-06 16:32:46', NULL);
INSERT INTO `topic` VALUES (286, 1, '在FusinlnsightManager界面中，对Lader的操作不包括下列哪个选项（）', '切换Lader主备节点\n启动Lader实例\n配置Lader参数\n查看Lader服务状态', NULL, 0, '切换Lader主备节点', 10, '中等', '在Fusinlnsight界面中，对Lader的操作不包括切换lader主备节点', 1, '2024-05-06 16:32:46', '2024-05-06 16:32:46', NULL);
INSERT INTO `topic` VALUES (287, 1, 'Hive不适用于以下哪个场景单选？', '非实时分析，例如日析\n数据挖掘，例如用户析，区域展示\n数据汇总，例如每天，每击数，点击排行\n实时在线数', NULL, 0, '实时在线数', 10, '中等', 'Hive不适用于实时在线数单选。由于hive主要用于数据分析，因此延时比较高，不适用于实时场景，适用于离线大数据分析。', 1, '2024-05-06 16:32:46', '2024-05-06 16:32:46', NULL);
INSERT INTO `topic` VALUES (288, 1, 'hadp平台中HBase的Regin是由哪个服务进程来管理？', 'HMaster\nDataNde\nReginServer\nZkeeper', NULL, 0, 'ReginServer', 10, '中等', 'Hadp平台中HBase的Regin是由ReginServer管理', 1, '2024-05-06 16:32:46', '2024-05-06 16:32:46', NULL);
INSERT INTO `topic` VALUES (289, 1, 'Hadp组件在企业应用中，能用于大数据集实时查询的产品有（）', 'Hive\nPig\nMahut\nHbase', NULL, 0, 'Hbase', 10, '中等', 'Hadp组件在企业应用中，能用于大数据集实时查询的产品有Hbase', 1, '2024-05-06 16:32:46', '2024-05-06 16:32:46', NULL);
INSERT INTO `topic` VALUES (290, 1, '下列选项中无法通过大数据技术实现的是？（）', '商业模式发现\n信用评估\n商品推荐\n运营分析', NULL, 0, '商业模式发现', 10, '中等', '商业模式发现无法通过大数据技术实现', 1, '2024-05-06 16:32:46', '2024-05-06 16:32:46', NULL);
INSERT INTO `topic` VALUES (291, 1, '日常数据通报型报告的特点错误的是（）', '进度性\n规范性\n时效性\n全面性', NULL, 0, '全面性', 10, '中等', '日常数据通报型报告的特点有进度性、规范性、时效性。\n日常数据通报是以定期数据分析报表为依据，反映计划执行情况，并分析影响和形成原因的一种数据分析报告。这种数据分析报告一般是按日、周、月、季、年等时间阶段定期进行，所以也叫定期分析报告。', 1, '2024-05-06 16:32:46', '2024-05-06 16:32:46', NULL);
INSERT INTO `topic` VALUES (292, 1, 'HBase依赖（）提供强大的计算能力', 'Prtbuf\nJava\nKafka\nChubby', NULL, 0, 'Chubby', 10, '中等', '谷歌收购云计算公司CuldSimple强化云计算能力', 1, '2024-05-06 16:32:46', '2024-05-06 16:32:46', NULL);
INSERT INTO `topic` VALUES (293, 1, 'linux查看磁盘的分区，磁盘、内存使用情况', '选项1\n选项2\n选项3\n选项4', NULL, 4, 'df: disk free 查看磁盘空余\nfree/top 查看内存使用情况\nfdisk -l 查看分区', 20, '中等', 'df: disk free 查看磁盘空余；free/top 查看内存使用情况；fdisk -l 查看分区', 1, '2024-05-06 16:32:46', '2024-05-06 16:32:46', NULL);
INSERT INTO `topic` VALUES (294, 1, 'Spark是用以下哪种编程语言实现的？', 'C语言\nC++语言\nJava语言\nScala语言', NULL, 0, 'Scala语言', 10, '简单', 'Spark中用Scala开发语法简洁许多，且支持类型推断，可以大大提升开发效率。', 1, '2024-05-06 16:33:16', '2024-05-06 16:33:16', NULL);
INSERT INTO `topic` VALUES (295, 1, '在FusinlnsightManager界面中，对Lader的操作不包括下列哪个选项（）', '切换Lader主备节点\n启动Lader实例\n配置Lader参数\n查看Lader服务状态', NULL, 0, '切换Lader主备节点', 10, '中等', '在Fusinlnsight界面中，对Lader的操作不包括切换lader主备节点', 1, '2024-05-06 16:33:16', '2024-05-06 16:33:16', NULL);
INSERT INTO `topic` VALUES (296, 1, 'Hive不适用于以下哪个场景单选？', '非实时分析，例如日析\n数据挖掘，例如用户析，区域展示\n数据汇总，例如每天，每击数，点击排行\n实时在线数', NULL, 0, '实时在线数', 10, '中等', 'Hive不适用于实时在线数单选。由于hive主要用于数据分析，因此延时比较高，不适用于实时场景，适用于离线大数据分析。', 1, '2024-05-06 16:33:16', '2024-05-06 16:33:16', NULL);
INSERT INTO `topic` VALUES (297, 1, 'hadp平台中HBase的Regin是由哪个服务进程来管理？', 'HMaster\nDataNde\nReginServer\nZkeeper', NULL, 0, 'ReginServer', 10, '中等', 'Hadp平台中HBase的Regin是由ReginServer管理', 1, '2024-05-06 16:33:16', '2024-05-06 16:33:16', NULL);
INSERT INTO `topic` VALUES (298, 1, 'Hadp组件在企业应用中，能用于大数据集实时查询的产品有（）', 'Hive\nPig\nMahut\nHbase', NULL, 0, 'Hbase', 10, '中等', 'Hadp组件在企业应用中，能用于大数据集实时查询的产品有Hbase', 1, '2024-05-06 16:33:16', '2024-05-06 16:33:16', NULL);
INSERT INTO `topic` VALUES (299, 1, '下列选项中无法通过大数据技术实现的是？（）', '商业模式发现\n信用评估\n商品推荐\n运营分析', NULL, 0, '商业模式发现', 10, '中等', '商业模式发现无法通过大数据技术实现', 1, '2024-05-06 16:33:16', '2024-05-06 16:33:16', NULL);
INSERT INTO `topic` VALUES (300, 1, '日常数据通报型报告的特点错误的是（）', '进度性\n规范性\n时效性\n全面性', NULL, 0, '全面性', 10, '中等', '日常数据通报型报告的特点有进度性、规范性、时效性。\n日常数据通报是以定期数据分析报表为依据，反映计划执行情况，并分析影响和形成原因的一种数据分析报告。这种数据分析报告一般是按日、周、月、季、年等时间阶段定期进行，所以也叫定期分析报告。', 1, '2024-05-06 16:33:16', '2024-05-06 16:33:16', NULL);
INSERT INTO `topic` VALUES (301, 1, 'HBase依赖（）提供强大的计算能力', 'Prtbuf\nJava\nKafka\nChubby', NULL, 0, 'Chubby', 10, '中等', '谷歌收购云计算公司CuldSimple强化云计算能力', 1, '2024-05-06 16:33:16', '2024-05-06 16:33:16', NULL);
INSERT INTO `topic` VALUES (302, 1, 'linux查看磁盘的分区，磁盘、内存使用情况', '选项1\n选项2\n选项3\n选项4', NULL, 4, 'df: disk free 查看磁盘空余\nfree/top 查看内存使用情况\nfdisk -l 查看分区', 20, '中等', 'df: disk free 查看磁盘空余；free/top 查看内存使用情况；fdisk -l 查看分区', 1, '2024-05-06 16:33:16', '2024-05-06 16:33:16', NULL);
INSERT INTO `topic` VALUES (303, 28, '计算机网络的功能有', '用户管理\n病毒管理\n资源共享\n站点管理', NULL, 0, '资源共享', 10, '简单', '计算机网络的功能有：（1）资源共享；（2）数据通信；（3）集中管理；（4）增加可靠性；（5）\n提高系统的处理能力和安全功能。其中，资源共享和数据通信是计算机网络最基本的两大功\n能。', 1, '2024-05-11 01:16:45', '2024-05-11 01:16:45', NULL);
INSERT INTO `topic` VALUES (304, 28, '网络资源子网负责', '信息处理\n数据通信\n数字认证机制\n路由', NULL, 0, '信息处理', 10, '中等', '“资源子网”主要负责：（1）全网的信息处理；（2）为网络用户提供网络服务；（3）资源共\n享功能。', 1, '2024-05-11 01:16:45', '2024-05-11 01:16:45', NULL);
INSERT INTO `topic` VALUES (305, 28, '通常按网络覆盖的地理范围分类，可分为局域网、（）和广域网三种。', '星型网络\n有线网\n城域网\n无线网', NULL, 0, '城域网', 10, '简单', '计算机网络按网络覆盖的地理范围进行分类可以分为：（1）局域网；（2）城域网；（3）广域\n网。', 1, '2024-05-11 01:16:45', '2024-05-11 01:16:45', NULL);
INSERT INTO `topic` VALUES (306, 28, '在下列传输介质中,哪种介质的典型传输率最高', '双绞线\n同轴电缆\n光纤\n无线介质', NULL, 0, '光纤', 10, '中等', '无', 1, '2024-05-11 01:16:45', '2024-05-11 01:16:45', NULL);
INSERT INTO `topic` VALUES (307, 28, 'DNS必须具有一个', '动态IP地址\n静态IP地址\n动态计算机名\n固定的计算机名', NULL, 0, '静态IP地址', 10, '中等', 'DNS这个域名解析服务器自身的地址，为了稳定，DNS的IP地址必须是静态的', 1, '2024-05-11 01:16:45', '2024-05-11 01:16:45', NULL);
INSERT INTO `topic` VALUES (308, 28, '在下列说法中哪些是正确的', '串行通信一般用于近距离传输,并行通信用于远距离传输\n串行通信的频带利用率比并行通信的高\n串行通信的传输速度比并行通信的快\n串行通信可通过通信缓冲区来进行数据流速匹配', NULL, 1, '电路交换\n\n串行通信的频带利用率比并行通信的高\n串行通信可通过通信缓冲区来进行数据流速匹配', 10, '中等', '串行通信的频带利用率比并行通信的高，串行通信可通过通信缓冲区来进行数据流速匹配', 1, '2024-05-11 01:16:45', '2024-05-11 01:16:45', NULL);
INSERT INTO `topic` VALUES (309, 28, '光纤接入网就是指采用蓝牙传输技术的接入网。', '选项1\n选项2\n选项3\n选项4', NULL, 2, 'false', 10, '中等', '无', 1, '2024-05-11 01:16:45', '2024-05-11 01:16:45', NULL);
INSERT INTO `topic` VALUES (310, 28, '可靠、有效的传输数据是FTP的目标', '选项1\n选项2\n选项3\n选项4', NULL, 2, 'true', 10, '中等', 'ftp 的目标是提高文件的共享性，提供非直接使用远程计算机，使存储介质对用户透明和可靠高效地传送数据。', 1, '2024-05-11 01:16:45', '2024-05-11 01:16:45', NULL);
INSERT INTO `topic` VALUES (311, 28, '___是OSI 参考模型中最靠近用户的一层，负责为用户的应用程序提供网络服务。', '选项1\n选项2\n选项3\n选项4', NULL, 3, '应用层', 10, '简单', '应用层，是OSI 参考模型中最靠近用户的一层，负责为用户的应用程序提供网络服务。与\nOSI 参考模型其他层不同的是，它不为任何其他OSI 层提供服务，而只是为OSI 模型以外\n的应用程序提供服务，如电子表格程序和文字处理程序。', 1, '2024-05-11 01:16:45', '2024-05-11 01:16:45', NULL);
INSERT INTO `topic` VALUES (312, 28, 'MAC地址和IP地址各表示什么意义?', '选项1\n选项2\n选项3\n选项4', NULL, 4, 'MAC地址是数据链路层和物理层使用的地址，写在网卡上的物理地址。\nIP地址是网络层和以上各层使用的地址，是一种逻辑地址。', 10, '中等', 'MAC地址是数据链路层和物理层使用的地址，写在网卡上的物理地址。\nIP地址是网络层和以上各层使用的地址，是一种逻辑地址。MAC地址用来定义网络设备的位置，IP地址用来区别网络上的计算机。', 1, '2024-05-11 01:16:45', '2024-05-11 01:16:45', NULL);
INSERT INTO `topic` VALUES (313, 28, '计算机网络是指将地理位置不同的计算机和计算机设备通过通信线路互相连接起来，实现资源共享和信息传输的系统。请问以下哪个选项不属于计算机网络的定义', '地理位置不同的计算机和计算机设备\n通过通信线路互相连接起来\n实现资源共享和信息传输的系统\n仅限于局域网范围内的计算机连接', NULL, 0, '仅限于局域网范围内的计算机连接', 10, '中等', '不仅仅限于局域网', 1, '2024-05-11 08:14:06', '2024-05-11 08:14:06', NULL);
INSERT INTO `topic` VALUES (314, 28, ' TCP/IP是目前广泛应用于互联网的一种协议组合，它由哪两种协议组成？', 'TCP和UDP\nTCP和IP\nUDP和IP\nHTTP和FTP', NULL, 0, 'TCP和IP', 10, '中等', ' TCP/IP是目前广泛应用于互联网的一种协议组合，由TCP和IP两种协议组成。', 1, '2024-05-11 08:14:06', '2024-05-11 08:14:06', NULL);
INSERT INTO `topic` VALUES (315, 28, '下列四项内容中，不属于Internet（因特网）基本功能是', '电子邮件\n文件传输\n远程登录\n实时监测控制', NULL, 0, '实时监测控制', 10, '中等', '实时监测控制不属于Internet（因特网）基本功能', 1, '2024-05-11 08:14:06', '2024-05-11 08:14:06', NULL);
INSERT INTO `topic` VALUES (316, 28, '关于Internet，以下说法正确的是', 'Internet属于中国\nInternet属于联合国\nInternet属于国际红十字会\nInternet不属于某个国家或组织', NULL, 0, 'Internet不属于某个国家或组织', 10, '中等', 'Internet不属于某个国家或组织', 1, '2024-05-11 08:14:06', '2024-05-11 08:14:06', NULL);
INSERT INTO `topic` VALUES (317, 28, '在OSI 参考模型中能实现路由选择、拥塞控制与互连功能的层是___', '选项1\n选项2\n选项3\n选项4', NULL, 3, '网络层', 10, '中等', '在OSI 参考模型中能实现路由选择、拥塞控制与互连功能的层是网络层', 1, '2024-05-11 08:14:06', '2024-05-11 08:14:06', NULL);
INSERT INTO `topic` VALUES (318, 28, '就交换技术而言，局域网中的以太网采用的是___', '选项1\n选项2\n选项3\n选项4', NULL, 3, '分组交换技术', 10, '中等', '就交换技术而言，局域网中的以太网采用的是分组交换技术', 1, '2024-05-11 08:14:06', '2024-05-11 08:14:06', NULL);
INSERT INTO `topic` VALUES (319, 28, '计算机网络由哪几个部分组成 ', '选项1\n选项2\n选项3\n选项4', NULL, 4, '若干个主机;它们向各用户提供服务\n一个通信子网;它由一些专用的结点交换机和连接这些结点的通信链路所组成\n一系列的协议，这些协议是为在主机之间或主机和子网之间的通信而用的', 20, '中等', '一个计算机网络由以下三个主要部分组成：1、若干个主机;它们向各用户提供服务；2、一个通信子网;它由一些专用的结点交换机和连接这些结点的通信链路所组成；3、一系列的协议..这些协议是为在主机之间或主机和子网之间的通信而用的..', 1, '2024-05-11 08:14:06', '2024-05-11 08:14:06', NULL);
INSERT INTO `topic` VALUES (320, 28, '简述传输层的作用及其提供的两种服务', '选项1\n选项2\n选项3\n选项4', NULL, 4, '传输层是计算机网络中的第四层，负责为应用层提供可靠的数据传输服务。\n它提供了两种服务：面向连接的可靠传输和无连接的不可靠传输。面向连接的可靠传输使用TCP（传输控制协议），它确保数据能够按顺序到达目的地，且不丢失和重复。而无连接的不可靠传输使用UDP（用户数据报协议），它不保证数据的可靠传输，但是传输效率较高。', 20, '中等', '传输层是计算机网络中的第四层，负责为应用层提供可靠的数据传输服务。它提供了两种服务：面向连接的可靠传输和无连接的不可靠传输。面向连接的可靠传输使用TCP（传输控制协议），它确保数据能够按顺序到达目的地，且不丢失和重复。而无连接的不可靠传输使用UDP（用户数据报协议），它不保证数据的可靠传输，但是传输效率较高。', 1, '2024-05-11 08:14:06', '2024-05-11 08:14:06', NULL);
INSERT INTO `topic` VALUES (321, 24, '（）反映数据的精细化程度，越细化的数据，价值越高。', '规模\n活性\n关联度\n颗粒度', NULL, 0, '颗粒度', 10, '中等', '无', 1, '2024-05-11 11:12:34', '2024-05-11 11:12:34', NULL);
INSERT INTO `topic` VALUES (322, 24, '在收集数据时，数据来源包含两种方式，这两种方式是（）', '直接数据\n移动端数据', NULL, 0, '选项3', 10, '中等', '请输入答案分析', 1, '2024-05-11 11:12:34', '2024-05-11 11:12:34', NULL);
INSERT INTO `topic` VALUES (323, 24, '关于Hadoop MapReduce分片（split）概念，下列说法不正确的是()', 'Hadoop为每个split创建一个Map任务\nsplit的多少决定了Map任务的数目\n在大多数情况下，理想的分片大小是一个HDFS块对应一个split\nsplit是一个物理概念', NULL, 1, 'Hadoop为每个split创建一个Map任务\nsplit的多少决定了Map任务的数目\n在大多数情况下，理想的分片大小是一个HDFS块对应一个split', 10, '中等', '无', 1, '2024-05-11 11:12:34', '2024-05-11 11:12:34', NULL);
INSERT INTO `topic` VALUES (324, 24, '调用Zookeeper客户端命令中包含哪些信息？', 'ip地址\n端口号\n服务器名称\n用户名', NULL, 1, 'ip地址\n端口号\n服务器名称\n用户名', 10, '中等', '无', 1, '2024-05-11 11:12:34', '2024-05-11 11:12:34', NULL);
INSERT INTO `topic` VALUES (325, 24, '数据采集指新的数据产生或现有数据内容发生显著改变或更新的阶段。', '选项1\n选项2\n选项3\n选项4', NULL, 2, 'true', 10, '中等', '无', 1, '2024-05-11 11:12:34', '2024-05-11 11:12:34', NULL);
INSERT INTO `topic` VALUES (326, 24, 'WMware提供两种类型的克隆，是___和___', '选项1\n选项2\n选项3\n选项4', NULL, 3, '完全克隆\n链接克隆', 10, '中等', '完全克隆的虚拟机不依赖源虚拟机，是完全独立的虚拟机，它的性能与被克隆虚拟机相同。由于完整克隆不与父虚拟机共享虚拟磁盘，所以创建完整克隆所需的时间比链接克隆更长。如果涉及的文件较大，完整克隆可能需要数分钟才能创建完成。完整克隆只复制克隆操作时的虚拟机状态，因此无法访问父虚拟机的快照。\n链接克隆是通过父虚拟机的快照创建而成，因此节省了磁盘空间，而且克隆速度非常快，但是克隆后的虚拟机性能能会有所下降。但是如果父虚拟机损坏或快照点删除，链接克隆的虚拟机也不能使用；如果父虚拟机移动位置，需要重新指定父虚拟机的位置，再启动链接克隆虚拟机。', 1, '2024-05-11 11:12:34', '2024-05-11 11:12:34', NULL);
INSERT INTO `topic` VALUES (327, 24, '数据分析的步骤通常有哪些？', '选项1\n选项2\n选项3\n选项4', NULL, 4, '收集数据\n清理数据\n探索性数据分析\n数据预处理\n数据建模\n解释结果\n结果呈现', 20, '中等', '收集数据：收集与研究目标相关的数据；清理数据：清除数据中的错误、缺失或重复项；探索性数据分析：通过可视化和摘要统计量来了解数据的特征；数据预处理：对数据进行转换、归一花或标准化，以便更好地进行分析；数据建模：使用统计模型或机器学习算法来分析数据；解释结果：解释模型的结果，并从中提取有用的见解；结果呈现：使用可视化工具将结果以易于理解的方式呈现出来。', 1, '2024-05-11 11:12:34', '2024-05-11 11:12:34', NULL);
INSERT INTO `topic` VALUES (328, 24, '什么是数据可视化？', '选项1\n选项2\n选项3\n选项4', NULL, 4, '使用图表、图形和其他可视元素将数据呈现出来的过程。\n通过可视化可以更好地理解数据的模式、关系和趋势\n常见的数据可视化工具包括折线图、柱状图、散点图和热力图等。', 20, '中等', '请输入答案分析', 1, '2024-05-11 11:12:34', '2024-05-11 11:12:34', NULL);
INSERT INTO `topic` VALUES (329, 24, '（）反映数据的精细化程度，越细化的数据，价值越高。', '规模\n活性\n关联度\n颗粒度', NULL, 0, '颗粒度', 5, '中等', '无', 1, '2024-05-11 11:14:36', '2024-05-11 11:14:36', NULL);
INSERT INTO `topic` VALUES (330, 24, '在收集数据时，数据来源包含两种方式，这种方式是（）', '直接数据\n移动端数据', NULL, 0, '直接数据', 5, '中等', '请输入答案分析', 1, '2024-05-11 11:14:36', '2024-05-11 11:14:36', NULL);
INSERT INTO `topic` VALUES (331, 24, '1+1', '1\n2\n3\n4', NULL, 0, '2', 10, '中等', '1+1=2', 1, '2024-05-11 11:14:36', '2024-05-11 11:14:36', NULL);
INSERT INTO `topic` VALUES (332, 24, '关于Hadoop MapReduce分片（split）概念，下列说法不正确的是()', 'Hadoop为每个split创建一个Map任务\nsplit的多少决定了Map任务的数目\n在大多数情况下，理想的分片大小是一个HDFS块对应一个split\nsplit是一个物理概念', NULL, 1, 'Hadoop为每个split创建一个Map任务\nsplit的多少决定了Map任务的数目\n在大多数情况下，理想的分片大小是一个HDFS块对应一个split', 10, '中等', '无', 1, '2024-05-11 11:14:36', '2024-05-11 11:14:36', NULL);
INSERT INTO `topic` VALUES (333, 24, '调用Zookeeper客户端命令中包含哪些信息？', 'ip地址\n端口号\n服务器名称\n用户名', NULL, 1, 'ip地址\n端口号\n服务器名称\n用户名', 10, '中等', '无', 1, '2024-05-11 11:14:36', '2024-05-11 11:14:36', NULL);
INSERT INTO `topic` VALUES (334, 24, '数据采集指新的数据产生或现有数据内容发生显著改变或更新的阶段。', '选项1\n选项2\n选项3\n选项4', NULL, 2, 'true', 10, '中等', '无', 1, '2024-05-11 11:14:36', '2024-05-11 11:14:36', NULL);
INSERT INTO `topic` VALUES (335, 24, 'WMware提供两种类型的克隆，是___和___', '选项1\n选项2\n选项3\n选项4', NULL, 3, '完全克隆\n链接克隆', 10, '中等', '完全克隆的虚拟机不依赖源虚拟机，是完全独立的虚拟机，它的性能与被克隆虚拟机相同。由于完整克隆不与父虚拟机共享虚拟磁盘，所以创建完整克隆所需的时间比链接克隆更长。如果涉及的文件较大，完整克隆可能需要数分钟才能创建完成。完整克隆只复制克隆操作时的虚拟机状态，因此无法访问父虚拟机的快照。\n链接克隆是通过父虚拟机的快照创建而成，因此节省了磁盘空间，而且克隆速度非常快，但是克隆后的虚拟机性能能会有所下降。但是如果父虚拟机损坏或快照点删除，链接克隆的虚拟机也不能使用；如果父虚拟机移动位置，需要重新指定父虚拟机的位置，再启动链接克隆虚拟机。', 1, '2024-05-11 11:14:36', '2024-05-11 11:14:36', NULL);
INSERT INTO `topic` VALUES (336, 24, '数据分析的步骤通常有哪些？', '选项1\n选项2\n选项3\n选项4', NULL, 4, '收集数据\n清理数据\n探索性数据分析\n数据预处理\n数据建模\n解释结果\n结果呈现', 20, '中等', '收集数据：收集与研究目标相关的数据；清理数据：清除数据中的错误、缺失或重复项；探索性数据分析：通过可视化和摘要统计量来了解数据的特征；数据预处理：对数据进行转换、归一花或标准化，以便更好地进行分析；数据建模：使用统计模型或机器学习算法来分析数据；解释结果：解释模型的结果，并从中提取有用的见解；结果呈现：使用可视化工具将结果以易于理解的方式呈现出来。', 1, '2024-05-11 11:14:36', '2024-05-11 11:14:36', NULL);
INSERT INTO `topic` VALUES (337, 24, '什么是数据可视化？', '选项1\n选项2\n选项3\n选项4', NULL, 4, '使用图表、图形和其他可视元素将数据呈现出来的过程。\n通过可视化可以更好地理解数据的模式、关系和趋势\n常见的数据可视化工具包括折线图、柱状图、散点图和热力图等。', 20, '中等', '请输入答案分析', 1, '2024-05-11 11:14:36', '2024-05-11 11:14:36', NULL);

-- ----------------------------
-- Table structure for topic_subject
-- ----------------------------
DROP TABLE IF EXISTS `topic_subject`;
CREATE TABLE `topic_subject`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `subject_id` int(0) NULL DEFAULT NULL,
  `exam_id` int(0) NULL DEFAULT NULL,
  `topic_id` int(0) NULL DEFAULT NULL,
  `create_date` datetime(0) NULL DEFAULT NULL,
  `update_date` datetime(0) NULL DEFAULT NULL,
  `classes_id` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of topic_subject
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `user_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名称',
  `sex` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '男' COMMENT '性别',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号码',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '电子邮箱',
  `role` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'student' COMMENT '身份 student:学生  teacher:是教师身份',
  `work` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '工作职位',
  `update_date` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `create_date` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `photo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像图片',
  `photo_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片名称',
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `souyin1`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'admin', '女', '13000000000', '222@qq.com', 'teacher', '教师', '2024-07-09 22:31:14', '2024-02-10 14:07:42', 'a183e77216fa40fea6bfe760b149706e.JPG', '2021_08_09_17_00_IMG_0271.JPG');
INSERT INTO `user` VALUES (19, 'user', '女', '123', '123@qq.com', 'student', '学生', '2024-04-18 17:16:26', '2024-02-11 09:06:04', 'b7f06aad9c574ad89b614becee8c5923.jpg', '头像1.jpg');
INSERT INTO `user` VALUES (20, '456', '男', '456', '456@qq.com', 'student', '学生', '2024-04-18 15:10:01', '2024-02-11 10:05:25', '86ad7980db7a469a9ffa489ca7ea192e.png', '1.png');
INSERT INTO `user` VALUES (24, '柯柯', '女', '123456789', '123456789@163.com', 'teacher', '教师', '2024-05-11 11:32:28', '2024-04-20 10:21:13', 'de60b4e049dd4db3b0077953d14af13d.jpg', '头像.jpg');

-- ----------------------------
-- Table structure for user_classes
-- ----------------------------
DROP TABLE IF EXISTS `user_classes`;
CREATE TABLE `user_classes`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `user_id` int(0) NOT NULL COMMENT '用户id',
  `classes_id` int(0) NOT NULL COMMENT '班级id',
  `position` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '身份   creator:创建者  student:学生  admin:管理员',
  `enter_date` datetime(0) NULL DEFAULT NULL COMMENT '加入时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 91 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_classes
-- ----------------------------
INSERT INTO `user_classes` VALUES (76, 22, 29, 'student', '2024-02-11 11:40:07');
INSERT INTO `user_classes` VALUES (77, 19, 29, 'student', '2024-02-11 11:40:14');
INSERT INTO `user_classes` VALUES (81, 20, 30, 'student', '2024-04-20 10:00:04');
INSERT INTO `user_classes` VALUES (82, 21, 33, 'student', '2024-04-20 16:25:54');
INSERT INTO `user_classes` VALUES (83, 25, 30, 'student', '2024-04-20 22:32:08');
INSERT INTO `user_classes` VALUES (85, 26, 36, 'student', '2024-05-10 18:55:38');
INSERT INTO `user_classes` VALUES (89, 23, 34, 'student', '2024-05-11 11:23:54');
INSERT INTO `user_classes` VALUES (90, 27, 34, 'student', '2024-05-11 11:23:54');

-- ----------------------------
-- Table structure for user_grade
-- ----------------------------
DROP TABLE IF EXISTS `user_grade`;
CREATE TABLE `user_grade`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(0) NOT NULL COMMENT '用户id',
  `classes_id` int(0) NOT NULL COMMENT '班级id',
  `exam_id` int(0) NOT NULL COMMENT '考试id',
  `grade` double NULL DEFAULT 0 COMMENT '得分',
  `grade_auto` double NULL DEFAULT 0 COMMENT '得分(自动评分)',
  `answer_date` datetime(0) NULL DEFAULT NULL COMMENT '答题日期',
  `answer_time` int(0) NULL DEFAULT NULL COMMENT '答题时长',
  `mark_status` int(0) NULL DEFAULT 0 COMMENT '批改状态 0:待批改 1:批改完成',
  `exam_status` int(0) NULL DEFAULT 0 COMMENT '试卷状态 0:未完成  1:已完成',
  `mark_date` datetime(0) NULL DEFAULT NULL COMMENT '批改日期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_grade
-- ----------------------------
INSERT INTO `user_grade` VALUES (24, 21, 29, 31, 10, 10, '2024-02-11 14:13:47', 6, 1, 1, '2024-02-11 14:14:51');
INSERT INTO `user_grade` VALUES (25, 21, 29, 30, 11, 11, '2024-02-11 14:16:06', 10, 1, 1, '2024-02-11 14:16:34');
INSERT INTO `user_grade` VALUES (26, 19, 29, 31, 20, 20, '2024-02-29 15:06:36', 28, 0, 1, NULL);
INSERT INTO `user_grade` VALUES (27, 19, 29, 35, 46, 46, '2024-04-17 17:51:30', 512, 0, 1, NULL);
INSERT INTO `user_grade` VALUES (28, 21, 29, 35, 58, 58, '2024-04-17 20:56:13', 133, 0, 1, NULL);
INSERT INTO `user_grade` VALUES (29, 23, 30, 38, 85, 68, '2024-04-19 17:38:44', 621, 1, 1, '2024-04-20 16:13:09');
INSERT INTO `user_grade` VALUES (31, 23, 30, 35, 80, 80, '2024-04-20 09:58:35', 281, 0, 1, NULL);
INSERT INTO `user_grade` VALUES (32, 20, 30, 35, 80, 80, '2024-04-20 10:02:31', 110, 0, 1, NULL);

-- ----------------------------
-- Table structure for user_password
-- ----------------------------
DROP TABLE IF EXISTS `user_password`;
CREATE TABLE `user_password`  (
  `user_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户登录密码',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_password
-- ----------------------------
INSERT INTO `user_password` VALUES (1, 'e10adc3949ba59abbe56e057f20f883e');
INSERT INTO `user_password` VALUES (18, 'e10adc3949ba59abbe56e057f20f883e');
INSERT INTO `user_password` VALUES (19, 'e10adc3949ba59abbe56e057f20f883e');
INSERT INTO `user_password` VALUES (20, 'e10adc3949ba59abbe56e057f20f883e');
INSERT INTO `user_password` VALUES (21, 'e10adc3949ba59abbe56e057f20f883e');
INSERT INTO `user_password` VALUES (22, 'e10adc3949ba59abbe56e057f20f883e');
INSERT INTO `user_password` VALUES (23, 'e10adc3949ba59abbe56e057f20f883e');
INSERT INTO `user_password` VALUES (24, 'e10adc3949ba59abbe56e057f20f883e');
INSERT INTO `user_password` VALUES (25, 'e10adc3949ba59abbe56e057f20f883e');
INSERT INTO `user_password` VALUES (26, 'e10adc3949ba59abbe56e057f20f883e');
INSERT INTO `user_password` VALUES (27, 'e10adc3949ba59abbe56e057f20f883e');
INSERT INTO `user_password` VALUES (28, 'e10adc3949ba59abbe56e057f20f883e');

-- ----------------------------
-- Table structure for user_topic
-- ----------------------------
DROP TABLE IF EXISTS `user_topic`;
CREATE TABLE `user_topic`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(0) NOT NULL COMMENT '用户id',
  `classes_id` int(0) NOT NULL COMMENT '班级id',
  `exam_id` int(0) NOT NULL COMMENT '试卷id',
  `topic_id` int(0) NOT NULL COMMENT '题目id',
  `user_answer` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户答案',
  `user_score` double NULL DEFAULT NULL COMMENT '用户得分',
  `topic_status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '0:待批改 1:批改完成',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 739 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_topic
-- ----------------------------
INSERT INTO `user_topic` VALUES (323, 21, 29, 31, 98, '选项2', 0, '1');
INSERT INTO `user_topic` VALUES (324, 21, 29, 31, 99, '选项1\n选项2', 0, '1');
INSERT INTO `user_topic` VALUES (325, 21, 29, 31, 100, 'true', 10, '1');
INSERT INTO `user_topic` VALUES (326, 21, 29, 30, 97, '选项2', 0, '1');
INSERT INTO `user_topic` VALUES (327, 21, 29, 30, 106, '选项1', 0, '1');
INSERT INTO `user_topic` VALUES (328, 21, 29, 30, 107, 'true', 0, '1');
INSERT INTO `user_topic` VALUES (329, 21, 29, 30, 108, '123\n123', 5, '1');
INSERT INTO `user_topic` VALUES (330, 21, 29, 30, 109, '123123123', 6, '1');
INSERT INTO `user_topic` VALUES (331, 19, 29, 31, 98, '选项1', 10, '0');
INSERT INTO `user_topic` VALUES (332, 19, 29, 31, 99, '选项2', 0, '0');
INSERT INTO `user_topic` VALUES (333, 19, 29, 31, 100, 'true', 10, '0');
INSERT INTO `user_topic` VALUES (334, 19, 29, 35, 189, '数据的逻辑结构、存储结构及其基本操作', 10, '0');
INSERT INTO `user_topic` VALUES (335, 19, 29, 35, 190, '顺序', 10, '0');
INSERT INTO `user_topic` VALUES (336, 19, 29, 35, 191, '顺序存储\n链式存储\n索引存储\n散列存储', 0, '0');
INSERT INTO `user_topic` VALUES (337, 19, 29, 35, 192, '顺序存储\n链式存储', 10, '0');
INSERT INTO `user_topic` VALUES (338, 19, 29, 35, 193, 'true', 0, '0');
INSERT INTO `user_topic` VALUES (339, 19, 29, 35, 194, '顺序存储结构\n链式存储结构', 0, '0');
INSERT INTO `user_topic` VALUES (340, 19, 29, 35, 195, '插入\n删除\n修改\n排序\n查找', 6, '0');
INSERT INTO `user_topic` VALUES (341, 19, 29, 35, 196, '时间效率\n空间效率', 10, '0');
INSERT INTO `user_topic` VALUES (342, 19, 29, 35, 197, '11111', 0, '0');
INSERT INTO `user_topic` VALUES (343, 19, 29, 35, 189, '数据的逻辑结构、存储结构及其基本操作', 10, '0');
INSERT INTO `user_topic` VALUES (344, 19, 29, 35, 190, '顺序', 10, '0');
INSERT INTO `user_topic` VALUES (345, 19, 29, 35, 191, '顺序存储\n链式存储\n索引存储\n散列存储', 0, '0');
INSERT INTO `user_topic` VALUES (346, 19, 29, 35, 192, '顺序存储\n链式存储', 10, '0');
INSERT INTO `user_topic` VALUES (347, 19, 29, 35, 193, 'true', 0, '0');
INSERT INTO `user_topic` VALUES (348, 19, 29, 35, 194, '顺序存储结构\n链式存储结构', 0, '0');
INSERT INTO `user_topic` VALUES (349, 19, 29, 35, 195, '插入\n删除\n修改\n排序\n查找', 6, '0');
INSERT INTO `user_topic` VALUES (350, 19, 29, 35, 196, '时间效率\n空间效率', 10, '0');
INSERT INTO `user_topic` VALUES (351, 19, 29, 35, 197, '11111', 0, '0');
INSERT INTO `user_topic` VALUES (352, 19, 29, 35, 189, '数据的逻辑结构、存储结构及其基本操作', 10, '0');
INSERT INTO `user_topic` VALUES (353, 19, 29, 35, 190, '顺序', 10, '0');
INSERT INTO `user_topic` VALUES (354, 19, 29, 35, 191, '顺序存储\n链式存储\n索引存储\n散列存储', 0, '0');
INSERT INTO `user_topic` VALUES (355, 19, 29, 35, 192, '顺序存储\n链式存储', 10, '0');
INSERT INTO `user_topic` VALUES (356, 19, 29, 35, 193, 'true', 0, '0');
INSERT INTO `user_topic` VALUES (357, 19, 29, 35, 194, '顺序存储结构\n链式存储结构', 0, '0');
INSERT INTO `user_topic` VALUES (358, 19, 29, 35, 195, '插入\n删除\n修改\n排序\n查找', 6, '0');
INSERT INTO `user_topic` VALUES (359, 19, 29, 35, 196, '时间效率\n空间效率', 10, '0');
INSERT INTO `user_topic` VALUES (360, 19, 29, 35, 197, '11111', 0, '0');
INSERT INTO `user_topic` VALUES (361, 19, 29, 35, 189, '数据的逻辑结构、存储结构及其基本操作', 10, '0');
INSERT INTO `user_topic` VALUES (362, 19, 29, 35, 190, '顺序', 10, '0');
INSERT INTO `user_topic` VALUES (363, 19, 29, 35, 191, '顺序存储\n链式存储\n索引存储\n散列存储', 0, '0');
INSERT INTO `user_topic` VALUES (364, 19, 29, 35, 192, '顺序存储\n链式存储', 10, '0');
INSERT INTO `user_topic` VALUES (365, 19, 29, 35, 193, 'true', 0, '0');
INSERT INTO `user_topic` VALUES (366, 19, 29, 35, 194, '顺序存储结构\n链式存储结构', 0, '0');
INSERT INTO `user_topic` VALUES (367, 19, 29, 35, 195, '插入\n删除\n修改\n排序\n查找', 6, '0');
INSERT INTO `user_topic` VALUES (368, 19, 29, 35, 196, '时间效率\n空间效率', 10, '0');
INSERT INTO `user_topic` VALUES (369, 19, 29, 35, 197, '11111', 0, '0');
INSERT INTO `user_topic` VALUES (370, 19, 29, 35, 189, '数据的逻辑结构、存储结构及其基本操作', 10, '0');
INSERT INTO `user_topic` VALUES (371, 19, 29, 35, 190, '顺序', 10, '0');
INSERT INTO `user_topic` VALUES (372, 19, 29, 35, 191, '顺序存储\n链式存储\n索引存储\n散列存储', 0, '0');
INSERT INTO `user_topic` VALUES (373, 19, 29, 35, 192, '顺序存储\n链式存储', 10, '0');
INSERT INTO `user_topic` VALUES (374, 19, 29, 35, 193, 'true', 0, '0');
INSERT INTO `user_topic` VALUES (375, 19, 29, 35, 194, '顺序存储结构\n链式存储结构', 0, '0');
INSERT INTO `user_topic` VALUES (376, 19, 29, 35, 195, '插入\n删除\n修改\n排序\n查找', 6, '0');
INSERT INTO `user_topic` VALUES (377, 19, 29, 35, 196, '时间效率\n空间效率', 10, '0');
INSERT INTO `user_topic` VALUES (378, 19, 29, 35, 197, '11111', 0, '0');
INSERT INTO `user_topic` VALUES (379, 19, 29, 35, 189, '数据的逻辑结构、存储结构及其基本操作', 10, '0');
INSERT INTO `user_topic` VALUES (380, 19, 29, 35, 190, '顺序', 10, '0');
INSERT INTO `user_topic` VALUES (381, 19, 29, 35, 191, '顺序存储\n链式存储\n索引存储\n散列存储', 0, '0');
INSERT INTO `user_topic` VALUES (382, 19, 29, 35, 192, '顺序存储\n链式存储', 10, '0');
INSERT INTO `user_topic` VALUES (383, 19, 29, 35, 193, 'true', 0, '0');
INSERT INTO `user_topic` VALUES (384, 19, 29, 35, 194, '顺序存储结构\n链式存储结构', 0, '0');
INSERT INTO `user_topic` VALUES (385, 19, 29, 35, 195, '插入\n删除\n修改\n排序\n查找', 6, '0');
INSERT INTO `user_topic` VALUES (386, 19, 29, 35, 196, '时间效率\n空间效率', 10, '0');
INSERT INTO `user_topic` VALUES (387, 19, 29, 35, 197, '11111', 0, '0');
INSERT INTO `user_topic` VALUES (388, 19, 29, 35, 189, '数据的逻辑结构、存储结构及其基本操作', 10, '0');
INSERT INTO `user_topic` VALUES (389, 19, 29, 35, 190, '顺序', 10, '0');
INSERT INTO `user_topic` VALUES (390, 19, 29, 35, 191, '顺序存储\n链式存储\n索引存储\n散列存储', 0, '0');
INSERT INTO `user_topic` VALUES (391, 19, 29, 35, 192, '顺序存储\n链式存储', 10, '0');
INSERT INTO `user_topic` VALUES (392, 19, 29, 35, 193, 'true', 0, '0');
INSERT INTO `user_topic` VALUES (393, 19, 29, 35, 194, '顺序存储结构\n链式存储结构', 0, '0');
INSERT INTO `user_topic` VALUES (394, 19, 29, 35, 195, '插入\n删除\n修改\n排序\n查找', 6, '0');
INSERT INTO `user_topic` VALUES (395, 19, 29, 35, 196, '时间效率\n空间效率', 10, '0');
INSERT INTO `user_topic` VALUES (396, 19, 29, 35, 197, '11111', 0, '0');
INSERT INTO `user_topic` VALUES (397, 19, 29, 35, 189, '数据的逻辑结构、存储结构及其基本操作', 10, '0');
INSERT INTO `user_topic` VALUES (398, 19, 29, 35, 190, '顺序', 10, '0');
INSERT INTO `user_topic` VALUES (399, 19, 29, 35, 191, '顺序存储\n链式存储\n索引存储\n散列存储', 0, '0');
INSERT INTO `user_topic` VALUES (400, 19, 29, 35, 192, '顺序存储\n链式存储', 10, '0');
INSERT INTO `user_topic` VALUES (401, 19, 29, 35, 193, 'true', 0, '0');
INSERT INTO `user_topic` VALUES (402, 19, 29, 35, 194, '顺序存储结构\n链式存储结构', 0, '0');
INSERT INTO `user_topic` VALUES (403, 19, 29, 35, 195, '插入\n删除\n修改\n排序\n查找', 6, '0');
INSERT INTO `user_topic` VALUES (404, 19, 29, 35, 196, '时间效率\n空间效率', 10, '0');
INSERT INTO `user_topic` VALUES (405, 19, 29, 35, 197, '11111', 0, '0');
INSERT INTO `user_topic` VALUES (406, 19, 29, 35, 189, '数据的逻辑结构、存储结构及其基本操作', 10, '0');
INSERT INTO `user_topic` VALUES (407, 19, 29, 35, 190, '顺序', 10, '0');
INSERT INTO `user_topic` VALUES (408, 19, 29, 35, 191, '顺序存储\n链式存储\n索引存储\n散列存储', 0, '0');
INSERT INTO `user_topic` VALUES (409, 19, 29, 35, 192, '顺序存储\n链式存储', 10, '0');
INSERT INTO `user_topic` VALUES (410, 19, 29, 35, 193, 'true', 0, '0');
INSERT INTO `user_topic` VALUES (411, 19, 29, 35, 194, '顺序存储结构\n链式存储结构', 0, '0');
INSERT INTO `user_topic` VALUES (412, 19, 29, 35, 195, '插入\n删除\n修改\n排序\n查找', 6, '0');
INSERT INTO `user_topic` VALUES (413, 19, 29, 35, 196, '时间效率\n空间效率', 10, '0');
INSERT INTO `user_topic` VALUES (414, 19, 29, 35, 197, '11111', 0, '0');
INSERT INTO `user_topic` VALUES (415, 19, 29, 35, 189, '数据的逻辑结构、存储结构及其基本操作', 10, '0');
INSERT INTO `user_topic` VALUES (416, 19, 29, 35, 190, '顺序', 10, '0');
INSERT INTO `user_topic` VALUES (417, 19, 29, 35, 191, '顺序存储\n链式存储\n索引存储\n散列存储', 0, '0');
INSERT INTO `user_topic` VALUES (418, 19, 29, 35, 192, '顺序存储\n链式存储', 10, '0');
INSERT INTO `user_topic` VALUES (419, 19, 29, 35, 193, 'true', 0, '0');
INSERT INTO `user_topic` VALUES (420, 19, 29, 35, 194, '顺序存储结构\n链式存储结构', 0, '0');
INSERT INTO `user_topic` VALUES (421, 19, 29, 35, 195, '插入\n删除\n修改\n排序\n查找', 6, '0');
INSERT INTO `user_topic` VALUES (422, 19, 29, 35, 196, '时间效率\n空间效率', 10, '0');
INSERT INTO `user_topic` VALUES (423, 19, 29, 35, 197, '11111', 0, '0');
INSERT INTO `user_topic` VALUES (424, 19, 29, 35, 189, '数据的逻辑结构、存储结构及其基本操作', 10, '0');
INSERT INTO `user_topic` VALUES (425, 19, 29, 35, 190, '顺序', 10, '0');
INSERT INTO `user_topic` VALUES (426, 19, 29, 35, 191, '顺序存储\n链式存储\n索引存储\n散列存储', 0, '0');
INSERT INTO `user_topic` VALUES (427, 19, 29, 35, 192, '顺序存储\n链式存储', 10, '0');
INSERT INTO `user_topic` VALUES (428, 19, 29, 35, 193, 'true', 0, '0');
INSERT INTO `user_topic` VALUES (429, 19, 29, 35, 194, '顺序存储结构\n链式存储结构', 0, '0');
INSERT INTO `user_topic` VALUES (430, 19, 29, 35, 195, '插入\n删除\n修改\n排序\n查找', 6, '0');
INSERT INTO `user_topic` VALUES (431, 19, 29, 35, 196, '时间效率\n空间效率', 10, '0');
INSERT INTO `user_topic` VALUES (432, 19, 29, 35, 197, '11111', 0, '0');
INSERT INTO `user_topic` VALUES (433, 19, 29, 35, 189, '数据的逻辑结构、存储结构及其基本操作', 10, '0');
INSERT INTO `user_topic` VALUES (434, 19, 29, 35, 190, '顺序', 10, '0');
INSERT INTO `user_topic` VALUES (435, 19, 29, 35, 191, '顺序存储\n链式存储\n索引存储\n散列存储', 0, '0');
INSERT INTO `user_topic` VALUES (436, 19, 29, 35, 192, '顺序存储\n链式存储', 10, '0');
INSERT INTO `user_topic` VALUES (437, 19, 29, 35, 193, 'true', 0, '0');
INSERT INTO `user_topic` VALUES (438, 19, 29, 35, 194, '顺序存储结构\n链式存储结构', 0, '0');
INSERT INTO `user_topic` VALUES (439, 19, 29, 35, 195, '插入\n删除\n修改\n排序\n查找', 6, '0');
INSERT INTO `user_topic` VALUES (440, 19, 29, 35, 196, '时间效率\n空间效率', 10, '0');
INSERT INTO `user_topic` VALUES (441, 19, 29, 35, 197, '11111', 0, '0');
INSERT INTO `user_topic` VALUES (442, 19, 29, 35, 189, '数据的逻辑结构、存储结构及其基本操作', 10, '0');
INSERT INTO `user_topic` VALUES (443, 19, 29, 35, 190, '顺序', 10, '0');
INSERT INTO `user_topic` VALUES (444, 19, 29, 35, 191, '顺序存储\n链式存储\n索引存储\n散列存储', 0, '0');
INSERT INTO `user_topic` VALUES (445, 19, 29, 35, 192, '顺序存储\n链式存储', 10, '0');
INSERT INTO `user_topic` VALUES (446, 19, 29, 35, 193, 'true', 0, '0');
INSERT INTO `user_topic` VALUES (447, 19, 29, 35, 194, '顺序存储结构\n链式存储结构', 0, '0');
INSERT INTO `user_topic` VALUES (448, 19, 29, 35, 195, '插入\n删除\n修改\n排序\n查找', 6, '0');
INSERT INTO `user_topic` VALUES (449, 19, 29, 35, 196, '时间效率\n空间效率', 10, '0');
INSERT INTO `user_topic` VALUES (450, 19, 29, 35, 197, '11111', 0, '0');
INSERT INTO `user_topic` VALUES (451, 19, 29, 35, 189, '数据的逻辑结构、存储结构及其基本操作', 10, '0');
INSERT INTO `user_topic` VALUES (452, 19, 29, 35, 190, '顺序', 10, '0');
INSERT INTO `user_topic` VALUES (453, 19, 29, 35, 191, '顺序存储\n链式存储\n索引存储\n散列存储', 0, '0');
INSERT INTO `user_topic` VALUES (454, 19, 29, 35, 192, '顺序存储\n链式存储', 10, '0');
INSERT INTO `user_topic` VALUES (455, 19, 29, 35, 193, 'true', 0, '0');
INSERT INTO `user_topic` VALUES (456, 19, 29, 35, 194, '顺序存储结构\n链式存储结构', 0, '0');
INSERT INTO `user_topic` VALUES (457, 19, 29, 35, 195, '插入\n删除\n修改\n排序\n查找', 6, '0');
INSERT INTO `user_topic` VALUES (458, 19, 29, 35, 196, '时间效率\n空间效率', 10, '0');
INSERT INTO `user_topic` VALUES (459, 19, 29, 35, 197, '11111', 0, '0');
INSERT INTO `user_topic` VALUES (460, 19, 29, 35, 189, '数据的逻辑结构、存储结构及其基本操作', 10, '0');
INSERT INTO `user_topic` VALUES (461, 19, 29, 35, 190, '顺序', 10, '0');
INSERT INTO `user_topic` VALUES (462, 19, 29, 35, 191, '顺序存储\n链式存储\n索引存储\n散列存储', 0, '0');
INSERT INTO `user_topic` VALUES (463, 19, 29, 35, 192, '顺序存储\n链式存储', 10, '0');
INSERT INTO `user_topic` VALUES (464, 19, 29, 35, 193, 'true', 0, '0');
INSERT INTO `user_topic` VALUES (465, 19, 29, 35, 194, '顺序存储结构\n链式存储结构', 0, '0');
INSERT INTO `user_topic` VALUES (466, 19, 29, 35, 195, '插入\n删除\n修改\n排序\n查找', 6, '0');
INSERT INTO `user_topic` VALUES (467, 19, 29, 35, 196, '时间效率\n空间效率', 10, '0');
INSERT INTO `user_topic` VALUES (468, 19, 29, 35, 197, '11111', 0, '0');
INSERT INTO `user_topic` VALUES (469, 19, 29, 35, 189, '数据的逻辑结构、存储结构及其基本操作', 10, '0');
INSERT INTO `user_topic` VALUES (470, 19, 29, 35, 190, '顺序', 10, '0');
INSERT INTO `user_topic` VALUES (471, 19, 29, 35, 191, '顺序存储\n链式存储\n索引存储\n散列存储', 0, '0');
INSERT INTO `user_topic` VALUES (472, 19, 29, 35, 192, '顺序存储\n链式存储', 10, '0');
INSERT INTO `user_topic` VALUES (473, 19, 29, 35, 193, 'true', 0, '0');
INSERT INTO `user_topic` VALUES (474, 19, 29, 35, 194, '顺序存储结构\n链式存储结构', 0, '0');
INSERT INTO `user_topic` VALUES (475, 19, 29, 35, 195, '插入\n删除\n修改\n排序\n查找', 6, '0');
INSERT INTO `user_topic` VALUES (476, 19, 29, 35, 196, '时间效率\n空间效率', 10, '0');
INSERT INTO `user_topic` VALUES (477, 19, 29, 35, 197, '11111', 0, '0');
INSERT INTO `user_topic` VALUES (478, 19, 29, 35, 189, '数据的逻辑结构、存储结构及其基本操作', 10, '0');
INSERT INTO `user_topic` VALUES (479, 19, 29, 35, 190, '顺序', 10, '0');
INSERT INTO `user_topic` VALUES (480, 19, 29, 35, 191, '顺序存储\n链式存储\n索引存储\n散列存储', 0, '0');
INSERT INTO `user_topic` VALUES (481, 19, 29, 35, 192, '顺序存储\n链式存储', 10, '0');
INSERT INTO `user_topic` VALUES (482, 19, 29, 35, 193, 'true', 0, '0');
INSERT INTO `user_topic` VALUES (483, 19, 29, 35, 194, '顺序存储结构\n链式存储结构', 0, '0');
INSERT INTO `user_topic` VALUES (484, 19, 29, 35, 195, '插入\n删除\n修改\n排序\n查找', 6, '0');
INSERT INTO `user_topic` VALUES (485, 19, 29, 35, 196, '时间效率\n空间效率', 10, '0');
INSERT INTO `user_topic` VALUES (486, 19, 29, 35, 197, '11111', 0, '0');
INSERT INTO `user_topic` VALUES (487, 19, 29, 35, 189, '数据的逻辑结构、存储结构及其基本操作', 10, '0');
INSERT INTO `user_topic` VALUES (488, 19, 29, 35, 190, '顺序', 10, '0');
INSERT INTO `user_topic` VALUES (489, 19, 29, 35, 191, '顺序存储\n链式存储\n索引存储\n散列存储', 0, '0');
INSERT INTO `user_topic` VALUES (490, 19, 29, 35, 192, '顺序存储\n链式存储', 10, '0');
INSERT INTO `user_topic` VALUES (491, 19, 29, 35, 193, 'true', 0, '0');
INSERT INTO `user_topic` VALUES (492, 19, 29, 35, 194, '顺序存储结构\n链式存储结构', 0, '0');
INSERT INTO `user_topic` VALUES (493, 19, 29, 35, 195, '插入\n删除\n修改\n排序\n查找', 6, '0');
INSERT INTO `user_topic` VALUES (494, 19, 29, 35, 196, '时间效率\n空间效率', 10, '0');
INSERT INTO `user_topic` VALUES (495, 19, 29, 35, 197, '11111', 0, '0');
INSERT INTO `user_topic` VALUES (496, 19, 29, 35, 189, '数据的逻辑结构、存储结构及其基本操作', 10, '0');
INSERT INTO `user_topic` VALUES (497, 19, 29, 35, 190, '顺序', 10, '0');
INSERT INTO `user_topic` VALUES (498, 19, 29, 35, 191, '顺序存储\n链式存储\n索引存储\n散列存储', 0, '0');
INSERT INTO `user_topic` VALUES (499, 19, 29, 35, 192, '顺序存储\n链式存储', 10, '0');
INSERT INTO `user_topic` VALUES (500, 19, 29, 35, 193, 'true', 0, '0');
INSERT INTO `user_topic` VALUES (501, 19, 29, 35, 194, '顺序存储结构\n链式存储结构', 0, '0');
INSERT INTO `user_topic` VALUES (502, 19, 29, 35, 195, '插入\n删除\n修改\n排序\n查找', 6, '0');
INSERT INTO `user_topic` VALUES (503, 19, 29, 35, 196, '时间效率\n空间效率', 10, '0');
INSERT INTO `user_topic` VALUES (504, 19, 29, 35, 197, '11111', 0, '0');
INSERT INTO `user_topic` VALUES (505, 19, 29, 35, 189, '数据的逻辑结构、存储结构及其基本操作', 10, '0');
INSERT INTO `user_topic` VALUES (506, 19, 29, 35, 190, '顺序', 10, '0');
INSERT INTO `user_topic` VALUES (507, 19, 29, 35, 191, '顺序存储\n链式存储\n索引存储\n散列存储', 0, '0');
INSERT INTO `user_topic` VALUES (508, 19, 29, 35, 192, '顺序存储\n链式存储', 10, '0');
INSERT INTO `user_topic` VALUES (509, 19, 29, 35, 193, 'true', 0, '0');
INSERT INTO `user_topic` VALUES (510, 19, 29, 35, 194, '顺序存储结构\n链式存储结构', 0, '0');
INSERT INTO `user_topic` VALUES (511, 19, 29, 35, 195, '插入\n删除\n修改\n排序\n查找', 6, '0');
INSERT INTO `user_topic` VALUES (512, 19, 29, 35, 196, '时间效率\n空间效率', 10, '0');
INSERT INTO `user_topic` VALUES (513, 19, 29, 35, 197, '11111', 0, '0');
INSERT INTO `user_topic` VALUES (514, 19, 29, 35, 189, '数据的逻辑结构、存储结构及其基本操作', 10, '0');
INSERT INTO `user_topic` VALUES (515, 19, 29, 35, 190, '顺序', 10, '0');
INSERT INTO `user_topic` VALUES (516, 19, 29, 35, 191, '顺序存储\n链式存储\n索引存储\n散列存储', 0, '0');
INSERT INTO `user_topic` VALUES (517, 19, 29, 35, 192, '顺序存储\n链式存储', 10, '0');
INSERT INTO `user_topic` VALUES (518, 19, 29, 35, 193, 'true', 0, '0');
INSERT INTO `user_topic` VALUES (519, 19, 29, 35, 194, '顺序存储结构\n链式存储结构', 0, '0');
INSERT INTO `user_topic` VALUES (520, 19, 29, 35, 195, '插入\n删除\n修改\n排序\n查找', 6, '0');
INSERT INTO `user_topic` VALUES (521, 19, 29, 35, 196, '时间效率\n空间效率', 10, '0');
INSERT INTO `user_topic` VALUES (522, 19, 29, 35, 197, '11111', 0, '0');
INSERT INTO `user_topic` VALUES (523, 19, 29, 35, 189, '数据的逻辑结构、存储结构及其基本操作', 10, '0');
INSERT INTO `user_topic` VALUES (524, 19, 29, 35, 190, '顺序', 10, '0');
INSERT INTO `user_topic` VALUES (525, 19, 29, 35, 191, '顺序存储\n链式存储\n索引存储\n散列存储', 0, '0');
INSERT INTO `user_topic` VALUES (526, 19, 29, 35, 192, '顺序存储\n链式存储', 10, '0');
INSERT INTO `user_topic` VALUES (527, 19, 29, 35, 193, 'true', 0, '0');
INSERT INTO `user_topic` VALUES (528, 19, 29, 35, 194, '顺序存储结构\n链式存储结构', 0, '0');
INSERT INTO `user_topic` VALUES (529, 19, 29, 35, 195, '插入\n删除\n修改\n排序\n查找', 6, '0');
INSERT INTO `user_topic` VALUES (530, 19, 29, 35, 196, '时间效率\n空间效率', 10, '0');
INSERT INTO `user_topic` VALUES (531, 19, 29, 35, 197, '11111', 0, '0');
INSERT INTO `user_topic` VALUES (532, 19, 29, 35, 189, '数据的逻辑结构、存储结构及其基本操作', 10, '0');
INSERT INTO `user_topic` VALUES (533, 19, 29, 35, 190, '顺序', 10, '0');
INSERT INTO `user_topic` VALUES (534, 19, 29, 35, 191, '顺序存储\n链式存储\n索引存储\n散列存储', 0, '0');
INSERT INTO `user_topic` VALUES (535, 19, 29, 35, 192, '顺序存储\n链式存储', 10, '0');
INSERT INTO `user_topic` VALUES (536, 19, 29, 35, 193, 'true', 0, '0');
INSERT INTO `user_topic` VALUES (537, 19, 29, 35, 194, '顺序存储结构\n链式存储结构', 0, '0');
INSERT INTO `user_topic` VALUES (538, 19, 29, 35, 195, '插入\n删除\n修改\n排序\n查找', 6, '0');
INSERT INTO `user_topic` VALUES (539, 19, 29, 35, 196, '时间效率\n空间效率', 10, '0');
INSERT INTO `user_topic` VALUES (540, 19, 29, 35, 197, '11111', 0, '0');
INSERT INTO `user_topic` VALUES (541, 19, 29, 35, 189, '数据的逻辑结构、存储结构及其基本操作', 10, '0');
INSERT INTO `user_topic` VALUES (542, 19, 29, 35, 190, '顺序', 10, '0');
INSERT INTO `user_topic` VALUES (543, 19, 29, 35, 191, '顺序存储\n链式存储\n索引存储\n散列存储', 0, '0');
INSERT INTO `user_topic` VALUES (544, 19, 29, 35, 192, '顺序存储\n链式存储', 10, '0');
INSERT INTO `user_topic` VALUES (545, 19, 29, 35, 193, 'true', 0, '0');
INSERT INTO `user_topic` VALUES (546, 19, 29, 35, 194, '顺序存储结构\n链式存储结构', 0, '0');
INSERT INTO `user_topic` VALUES (547, 19, 29, 35, 195, '插入\n删除\n修改\n排序\n查找', 6, '0');
INSERT INTO `user_topic` VALUES (548, 19, 29, 35, 196, '时间效率\n空间效率', 10, '0');
INSERT INTO `user_topic` VALUES (549, 19, 29, 35, 197, '11111', 0, '0');
INSERT INTO `user_topic` VALUES (550, 19, 29, 35, 189, '数据的逻辑结构、存储结构及其基本操作', 10, '0');
INSERT INTO `user_topic` VALUES (551, 19, 29, 35, 190, '顺序', 10, '0');
INSERT INTO `user_topic` VALUES (552, 19, 29, 35, 191, '顺序存储\n链式存储\n索引存储\n散列存储', 0, '0');
INSERT INTO `user_topic` VALUES (553, 19, 29, 35, 192, '顺序存储\n链式存储', 10, '0');
INSERT INTO `user_topic` VALUES (554, 19, 29, 35, 193, 'true', 0, '0');
INSERT INTO `user_topic` VALUES (555, 19, 29, 35, 194, '顺序存储结构\n链式存储结构', 0, '0');
INSERT INTO `user_topic` VALUES (556, 19, 29, 35, 195, '插入\n删除\n修改\n排序\n查找', 6, '0');
INSERT INTO `user_topic` VALUES (557, 19, 29, 35, 196, '时间效率\n空间效率', 10, '0');
INSERT INTO `user_topic` VALUES (558, 19, 29, 35, 197, '11111', 0, '0');
INSERT INTO `user_topic` VALUES (559, 19, 29, 35, 189, '数据的逻辑结构、存储结构及其基本操作', 10, '0');
INSERT INTO `user_topic` VALUES (560, 19, 29, 35, 190, '顺序', 10, '0');
INSERT INTO `user_topic` VALUES (561, 19, 29, 35, 191, '顺序存储\n链式存储\n索引存储\n散列存储', 0, '0');
INSERT INTO `user_topic` VALUES (562, 19, 29, 35, 192, '顺序存储\n链式存储', 10, '0');
INSERT INTO `user_topic` VALUES (563, 19, 29, 35, 193, 'true', 0, '0');
INSERT INTO `user_topic` VALUES (564, 19, 29, 35, 194, '顺序存储结构\n链式存储结构', 0, '0');
INSERT INTO `user_topic` VALUES (565, 19, 29, 35, 195, '插入\n删除\n修改\n排序\n查找', 6, '0');
INSERT INTO `user_topic` VALUES (566, 19, 29, 35, 196, '时间效率\n空间效率', 10, '0');
INSERT INTO `user_topic` VALUES (567, 19, 29, 35, 197, '11111', 0, '0');
INSERT INTO `user_topic` VALUES (568, 19, 29, 35, 189, '数据的逻辑结构、存储结构及其基本操作', 10, '0');
INSERT INTO `user_topic` VALUES (569, 19, 29, 35, 190, '顺序', 10, '0');
INSERT INTO `user_topic` VALUES (570, 19, 29, 35, 191, '顺序存储\n链式存储\n索引存储\n散列存储', 0, '0');
INSERT INTO `user_topic` VALUES (571, 19, 29, 35, 192, '顺序存储\n链式存储', 10, '0');
INSERT INTO `user_topic` VALUES (572, 19, 29, 35, 193, 'true', 0, '0');
INSERT INTO `user_topic` VALUES (573, 19, 29, 35, 194, '顺序存储结构\n链式存储结构', 0, '0');
INSERT INTO `user_topic` VALUES (574, 19, 29, 35, 195, '插入\n删除\n修改\n排序\n查找', 6, '0');
INSERT INTO `user_topic` VALUES (575, 19, 29, 35, 196, '时间效率\n空间效率', 10, '0');
INSERT INTO `user_topic` VALUES (576, 19, 29, 35, 197, '11111', 0, '0');
INSERT INTO `user_topic` VALUES (577, 19, 29, 35, 189, '数据的逻辑结构、存储结构及其基本操作', 10, '0');
INSERT INTO `user_topic` VALUES (578, 19, 29, 35, 190, '顺序', 10, '0');
INSERT INTO `user_topic` VALUES (579, 19, 29, 35, 191, '顺序存储\n链式存储\n索引存储\n散列存储', 0, '0');
INSERT INTO `user_topic` VALUES (580, 19, 29, 35, 192, '顺序存储\n链式存储', 10, '0');
INSERT INTO `user_topic` VALUES (581, 19, 29, 35, 193, 'true', 0, '0');
INSERT INTO `user_topic` VALUES (582, 19, 29, 35, 194, '顺序存储结构\n链式存储结构', 0, '0');
INSERT INTO `user_topic` VALUES (583, 19, 29, 35, 195, '插入\n删除\n修改\n排序\n查找', 6, '0');
INSERT INTO `user_topic` VALUES (584, 19, 29, 35, 196, '时间效率\n空间效率', 10, '0');
INSERT INTO `user_topic` VALUES (585, 19, 29, 35, 197, '11111', 0, '0');
INSERT INTO `user_topic` VALUES (586, 19, 29, 35, 189, '数据的逻辑结构、存储结构及其基本操作', 10, '0');
INSERT INTO `user_topic` VALUES (587, 19, 29, 35, 190, '顺序', 10, '0');
INSERT INTO `user_topic` VALUES (588, 19, 29, 35, 191, '顺序存储\n链式存储\n索引存储\n散列存储', 0, '0');
INSERT INTO `user_topic` VALUES (589, 19, 29, 35, 192, '顺序存储\n链式存储', 10, '0');
INSERT INTO `user_topic` VALUES (590, 19, 29, 35, 193, 'true', 0, '0');
INSERT INTO `user_topic` VALUES (591, 19, 29, 35, 194, '顺序存储结构\n链式存储结构', 0, '0');
INSERT INTO `user_topic` VALUES (592, 19, 29, 35, 195, '插入\n删除\n修改\n排序\n查找', 6, '0');
INSERT INTO `user_topic` VALUES (593, 19, 29, 35, 196, '时间效率\n空间效率', 10, '0');
INSERT INTO `user_topic` VALUES (594, 19, 29, 35, 197, '11111', 0, '0');
INSERT INTO `user_topic` VALUES (595, 19, 29, 35, 189, '数据的逻辑结构、存储结构及其基本操作', 10, '0');
INSERT INTO `user_topic` VALUES (596, 19, 29, 35, 190, '顺序', 10, '0');
INSERT INTO `user_topic` VALUES (597, 19, 29, 35, 191, '顺序存储\n链式存储\n索引存储\n散列存储', 0, '0');
INSERT INTO `user_topic` VALUES (598, 19, 29, 35, 192, '顺序存储\n链式存储', 10, '0');
INSERT INTO `user_topic` VALUES (599, 19, 29, 35, 193, 'true', 0, '0');
INSERT INTO `user_topic` VALUES (600, 19, 29, 35, 194, '顺序存储结构\n链式存储结构', 0, '0');
INSERT INTO `user_topic` VALUES (601, 19, 29, 35, 195, '插入\n删除\n修改\n排序\n查找', 6, '0');
INSERT INTO `user_topic` VALUES (602, 19, 29, 35, 196, '时间效率\n空间效率', 10, '0');
INSERT INTO `user_topic` VALUES (603, 19, 29, 35, 197, '11111', 0, '0');
INSERT INTO `user_topic` VALUES (604, 19, 29, 35, 189, '数据的逻辑结构、存储结构及其基本操作', 10, '0');
INSERT INTO `user_topic` VALUES (605, 19, 29, 35, 190, '顺序', 10, '0');
INSERT INTO `user_topic` VALUES (606, 19, 29, 35, 191, '顺序存储\n链式存储\n索引存储\n散列存储', 0, '0');
INSERT INTO `user_topic` VALUES (607, 19, 29, 35, 192, '顺序存储\n链式存储', 10, '0');
INSERT INTO `user_topic` VALUES (608, 19, 29, 35, 193, 'true', 0, '0');
INSERT INTO `user_topic` VALUES (609, 19, 29, 35, 194, '顺序存储结构\n链式存储结构', 0, '0');
INSERT INTO `user_topic` VALUES (610, 19, 29, 35, 195, '插入\n删除\n修改\n排序\n查找', 6, '0');
INSERT INTO `user_topic` VALUES (611, 19, 29, 35, 196, '时间效率\n空间效率', 10, '0');
INSERT INTO `user_topic` VALUES (612, 19, 29, 35, 197, '11111', 0, '0');
INSERT INTO `user_topic` VALUES (613, 19, 29, 35, 189, '数据的逻辑结构、存储结构及其基本操作', 10, '0');
INSERT INTO `user_topic` VALUES (614, 19, 29, 35, 190, '顺序', 10, '0');
INSERT INTO `user_topic` VALUES (615, 19, 29, 35, 191, '顺序存储\n链式存储\n索引存储\n散列存储', 0, '0');
INSERT INTO `user_topic` VALUES (616, 19, 29, 35, 192, '顺序存储\n链式存储', 10, '0');
INSERT INTO `user_topic` VALUES (617, 19, 29, 35, 193, 'true', 0, '0');
INSERT INTO `user_topic` VALUES (618, 19, 29, 35, 194, '顺序存储结构\n链式存储结构', 0, '0');
INSERT INTO `user_topic` VALUES (619, 19, 29, 35, 195, '插入\n删除\n修改\n排序\n查找', 6, '0');
INSERT INTO `user_topic` VALUES (620, 19, 29, 35, 196, '时间效率\n空间效率', 10, '0');
INSERT INTO `user_topic` VALUES (621, 19, 29, 35, 197, '11111', 0, '0');
INSERT INTO `user_topic` VALUES (622, 19, 29, 35, 189, '数据的逻辑结构、存储结构及其基本操作', 10, '0');
INSERT INTO `user_topic` VALUES (623, 19, 29, 35, 190, '顺序', 10, '0');
INSERT INTO `user_topic` VALUES (624, 19, 29, 35, 191, '顺序存储\n链式存储\n索引存储\n散列存储', 0, '0');
INSERT INTO `user_topic` VALUES (625, 19, 29, 35, 192, '顺序存储\n链式存储', 10, '0');
INSERT INTO `user_topic` VALUES (626, 19, 29, 35, 193, 'true', 0, '0');
INSERT INTO `user_topic` VALUES (627, 19, 29, 35, 194, '顺序存储结构\n链式存储结构', 0, '0');
INSERT INTO `user_topic` VALUES (628, 19, 29, 35, 195, '插入\n删除\n修改\n排序\n查找', 10, '0');
INSERT INTO `user_topic` VALUES (629, 19, 29, 35, 196, '时间效率\n空间效率', 10, '0');
INSERT INTO `user_topic` VALUES (630, 19, 29, 35, 197, '11111', 0, '0');
INSERT INTO `user_topic` VALUES (631, 21, 29, 35, 189, '数据的逻辑结构、存储结构及其基本操作', 10, '0');
INSERT INTO `user_topic` VALUES (632, 21, 29, 35, 190, '顺序', 10, '0');
INSERT INTO `user_topic` VALUES (633, 21, 29, 35, 191, '顺序存储\n链式存储\n索引存储\n散列存储', 0, '0');
INSERT INTO `user_topic` VALUES (634, 21, 29, 35, 192, '顺序存储\n链式存储', 10, '0');
INSERT INTO `user_topic` VALUES (635, 21, 29, 35, 193, 'false', 10, '0');
INSERT INTO `user_topic` VALUES (636, 21, 29, 35, 194, '线性存储结构\n非线性存储结构', 0, '0');
INSERT INTO `user_topic` VALUES (637, 21, 29, 35, 195, '查找\n插入\n排序\n新增\n修改', 8, '0');
INSERT INTO `user_topic` VALUES (638, 21, 29, 35, 196, '时间效率\n空间效率', 10, '0');
INSERT INTO `user_topic` VALUES (639, 21, 29, 35, 197, '软件测试广泛应用于软件开发中。', 0, '0');
INSERT INTO `user_topic` VALUES (640, 21, 29, 35, 189, '数据的逻辑结构、存储结构及其基本操作', 10, '0');
INSERT INTO `user_topic` VALUES (641, 21, 29, 35, 190, '顺序', 10, '0');
INSERT INTO `user_topic` VALUES (642, 21, 29, 35, 191, '顺序存储\n链式存储\n索引存储\n散列存储', 0, '0');
INSERT INTO `user_topic` VALUES (643, 21, 29, 35, 192, '顺序存储\n链式存储', 10, '0');
INSERT INTO `user_topic` VALUES (644, 21, 29, 35, 193, 'false', 10, '0');
INSERT INTO `user_topic` VALUES (645, 21, 29, 35, 194, '线性存储结构\n非线性存储结构', 0, '0');
INSERT INTO `user_topic` VALUES (646, 21, 29, 35, 195, '查找\n插入\n排序\n新增\n修改', 8, '0');
INSERT INTO `user_topic` VALUES (647, 21, 29, 35, 196, '时间效率\n空间效率', 10, '0');
INSERT INTO `user_topic` VALUES (648, 21, 29, 35, 197, '软件测试广泛应用于软件开发中。', 0, '0');
INSERT INTO `user_topic` VALUES (649, 21, 29, 35, 189, '数据的逻辑结构、存储结构及其基本操作', 10, '0');
INSERT INTO `user_topic` VALUES (650, 21, 29, 35, 190, '顺序', 10, '0');
INSERT INTO `user_topic` VALUES (651, 21, 29, 35, 191, '顺序存储\n链式存储\n索引存储\n散列存储', 0, '0');
INSERT INTO `user_topic` VALUES (652, 21, 29, 35, 192, '顺序存储\n链式存储', 10, '0');
INSERT INTO `user_topic` VALUES (653, 21, 29, 35, 193, 'false', 10, '0');
INSERT INTO `user_topic` VALUES (654, 21, 29, 35, 194, '线性存储结构\n非线性存储结构', 0, '0');
INSERT INTO `user_topic` VALUES (655, 21, 29, 35, 195, '查找\n插入\n排序\n新增\n修改', 8, '0');
INSERT INTO `user_topic` VALUES (656, 21, 29, 35, 196, '时间效率\n空间效率', 10, '0');
INSERT INTO `user_topic` VALUES (657, 21, 29, 35, 197, '软件测试广泛应用于软件开发中。', 0, '0');
INSERT INTO `user_topic` VALUES (658, 21, 29, 35, 189, '数据的逻辑结构、存储结构及其基本操作', 10, '0');
INSERT INTO `user_topic` VALUES (659, 21, 29, 35, 190, '顺序', 10, '0');
INSERT INTO `user_topic` VALUES (660, 21, 29, 35, 191, '顺序存储\n链式存储\n索引存储\n散列存储', 0, '0');
INSERT INTO `user_topic` VALUES (661, 21, 29, 35, 192, '顺序存储\n链式存储', 10, '0');
INSERT INTO `user_topic` VALUES (662, 21, 29, 35, 193, 'false', 10, '0');
INSERT INTO `user_topic` VALUES (663, 21, 29, 35, 194, '线性存储结构\n非线性存储结构', 0, '0');
INSERT INTO `user_topic` VALUES (664, 21, 29, 35, 195, '查找\n插入\n排序\n新增\n修改', 8, '0');
INSERT INTO `user_topic` VALUES (665, 21, 29, 35, 196, '时间效率\n空间效率', 10, '0');
INSERT INTO `user_topic` VALUES (666, 21, 29, 35, 197, '软件测试广泛应用于软件开发中。', 0, '0');
INSERT INTO `user_topic` VALUES (667, 21, 29, 35, 189, '数据的逻辑结构、存储结构及其基本操作', 10, '0');
INSERT INTO `user_topic` VALUES (668, 21, 29, 35, 190, '顺序', 10, '0');
INSERT INTO `user_topic` VALUES (669, 21, 29, 35, 191, '顺序存储\n链式存储\n索引存储\n散列存储', 0, '0');
INSERT INTO `user_topic` VALUES (670, 21, 29, 35, 192, '顺序存储\n链式存储', 10, '0');
INSERT INTO `user_topic` VALUES (671, 21, 29, 35, 193, 'false', 10, '0');
INSERT INTO `user_topic` VALUES (672, 21, 29, 35, 194, '线性存储结构\n非线性存储结构', 0, '0');
INSERT INTO `user_topic` VALUES (673, 21, 29, 35, 195, '查找\n插入\n排序\n新增\n修改', 8, '0');
INSERT INTO `user_topic` VALUES (674, 21, 29, 35, 196, '时间效率\n空间效率', 10, '0');
INSERT INTO `user_topic` VALUES (675, 21, 29, 35, 197, '软件测试广泛应用于软件开发中。', 0, '0');
INSERT INTO `user_topic` VALUES (676, 21, 29, 35, 189, '数据的逻辑结构、存储结构及其基本操作', 10, '0');
INSERT INTO `user_topic` VALUES (677, 21, 29, 35, 190, '顺序', 10, '0');
INSERT INTO `user_topic` VALUES (678, 21, 29, 35, 191, '顺序存储\n链式存储\n索引存储\n散列存储', 0, '0');
INSERT INTO `user_topic` VALUES (679, 21, 29, 35, 192, '顺序存储\n链式存储', 10, '0');
INSERT INTO `user_topic` VALUES (680, 21, 29, 35, 193, 'false', 10, '0');
INSERT INTO `user_topic` VALUES (681, 21, 29, 35, 194, '线性存储结构\n非线性存储结构', 0, '0');
INSERT INTO `user_topic` VALUES (682, 21, 29, 35, 195, '查找\n插入\n排序\n新增\n修改', 8, '0');
INSERT INTO `user_topic` VALUES (683, 21, 29, 35, 196, '时间效率\n空间效率', 10, '0');
INSERT INTO `user_topic` VALUES (684, 21, 29, 35, 197, '软件测试广泛应用于软件开发中。', 0, '0');
INSERT INTO `user_topic` VALUES (685, 21, 29, 35, 189, '数据的逻辑结构、存储结构及其基本操作', 10, '0');
INSERT INTO `user_topic` VALUES (686, 21, 29, 35, 190, '顺序', 10, '0');
INSERT INTO `user_topic` VALUES (687, 21, 29, 35, 191, '顺序存储\n链式存储\n索引存储\n散列存储', 8, '0');
INSERT INTO `user_topic` VALUES (688, 21, 29, 35, 192, '顺序存储\n链式存储', 10, '0');
INSERT INTO `user_topic` VALUES (689, 21, 29, 35, 193, 'false', 10, '0');
INSERT INTO `user_topic` VALUES (690, 21, 29, 35, 194, '线性存储结构\n非线性存储结构', 0, '0');
INSERT INTO `user_topic` VALUES (691, 21, 29, 35, 195, '查找\n插入\n排序\n新增\n修改', 8, '0');
INSERT INTO `user_topic` VALUES (692, 21, 29, 35, 196, '时间效率\n空间效率', 10, '0');
INSERT INTO `user_topic` VALUES (693, 21, 29, 35, 197, '软件测试广泛应用于软件开发中。', 0, '0');
INSERT INTO `user_topic` VALUES (694, 23, 30, 38, 235, '数据的逻辑结构、存储结构及其基本操作', 10, '1');
INSERT INTO `user_topic` VALUES (695, 23, 30, 38, 236, '顺序', 10, '1');
INSERT INTO `user_topic` VALUES (696, 23, 30, 38, 237, '2', 0, '1');
INSERT INTO `user_topic` VALUES (697, 23, 30, 38, 238, '链式存储\n索引存储\n散列存储\n顺序存储', 10, '1');
INSERT INTO `user_topic` VALUES (698, 23, 30, 38, 239, '顺序存储\n链式存储', 10, '1');
INSERT INTO `user_topic` VALUES (699, 23, 30, 38, 240, 'false', 10, '1');
INSERT INTO `user_topic` VALUES (700, 23, 30, 38, 241, '线性存储结构\n非线性存储结构', 10, '1');
INSERT INTO `user_topic` VALUES (701, 23, 30, 38, 242, '插入\n删除\n修改\n排序\n查找', 10, '1');
INSERT INTO `user_topic` VALUES (702, 23, 30, 38, 243, '时间效率\n空间效率', 10, '1');
INSERT INTO `user_topic` VALUES (703, 23, 30, 38, 244, '相同点：\n区别：', 5, '1');
INSERT INTO `user_topic` VALUES (704, 23, 30, 35, 189, '数据的逻辑结构、存储结构及其基本操作', 10, '0');
INSERT INTO `user_topic` VALUES (705, 23, 30, 35, 190, '顺序', 10, '0');
INSERT INTO `user_topic` VALUES (706, 23, 30, 35, 191, '顺序存储\n链式存储\n索引存储\n散列存储', 10, '0');
INSERT INTO `user_topic` VALUES (707, 23, 30, 35, 192, '顺序存储\n链式存储', 10, '0');
INSERT INTO `user_topic` VALUES (708, 23, 30, 35, 193, 'false', 10, '0');
INSERT INTO `user_topic` VALUES (709, 23, 30, 35, 194, '线性结构\n非线性结构', 10, '0');
INSERT INTO `user_topic` VALUES (710, 23, 30, 35, 195, '插入\n查找\n删除\n排序\n修改', 10, '0');
INSERT INTO `user_topic` VALUES (711, 23, 30, 35, 196, '时间效率\n空间效率', 10, '0');
INSERT INTO `user_topic` VALUES (712, 23, 30, 35, 197, '相同点：二者都将待插入元素插入前面的有序子表。排序的总趟数取决于元素的个数n。\n区别：确定当前记录在前面有序子表中的位置时，直接插入排序采用顺序查找法，而折半插入排序采用折半查找法。', 0, '0');
INSERT INTO `user_topic` VALUES (713, 23, 30, 35, 189, '数据的逻辑结构、存储结构及其基本操作', 10, '0');
INSERT INTO `user_topic` VALUES (714, 23, 30, 35, 190, '顺序', 10, '0');
INSERT INTO `user_topic` VALUES (715, 23, 30, 35, 191, '顺序存储\n链式存储\n索引存储\n散列存储', 10, '0');
INSERT INTO `user_topic` VALUES (716, 23, 30, 35, 192, '顺序存储\n链式存储', 10, '0');
INSERT INTO `user_topic` VALUES (717, 23, 30, 35, 193, 'false', 10, '0');
INSERT INTO `user_topic` VALUES (718, 23, 30, 35, 194, '线性结构\n非线性结构', 10, '0');
INSERT INTO `user_topic` VALUES (719, 23, 30, 35, 195, '插入\n查找\n删除\n排序\n修改', 10, '0');
INSERT INTO `user_topic` VALUES (720, 23, 30, 35, 196, '时间效率\n空间效率', 10, '0');
INSERT INTO `user_topic` VALUES (721, 23, 30, 35, 197, '相同点：二者都将待插入元素插入前面的有序子表。排序的总趟数取决于元素的个数n。\n区别：确定当前记录在前面有序子表中的位置时，直接插入排序采用顺序查找法，而折半插入排序采用折半查找法。', 0, '0');
INSERT INTO `user_topic` VALUES (722, 20, 30, 35, 189, '数据的逻辑结构、存储结构及其基本操作', 10, '0');
INSERT INTO `user_topic` VALUES (723, 20, 30, 35, 190, '顺序', 10, '0');
INSERT INTO `user_topic` VALUES (724, 20, 30, 35, 191, '顺序存储\n链式存储\n索引存储\n散列存储', 10, '0');
INSERT INTO `user_topic` VALUES (725, 20, 30, 35, 192, '顺序存储\n链式存储', 10, '0');
INSERT INTO `user_topic` VALUES (726, 20, 30, 35, 193, 'false', 10, '0');
INSERT INTO `user_topic` VALUES (727, 20, 30, 35, 194, '线性结构\n非线性结构', 10, '0');
INSERT INTO `user_topic` VALUES (728, 20, 30, 35, 195, '插入\n查找\n排序\n删除\n修改', 10, '0');
INSERT INTO `user_topic` VALUES (729, 20, 30, 35, 196, '时间效率\n空间效率', 10, '0');
INSERT INTO `user_topic` VALUES (730, 20, 30, 35, 197, '相同点：二者都将待插入元素插入前面的有序子表。排序的总趟数取决于元素的个数n。\n区别：确定当前记录在前面有序子表中的位置时，直接插入排序采用顺序查找法，而折半插入排序采用折半查找法', 0, '0');
INSERT INTO `user_topic` VALUES (731, 27, 34, 44, 313, '仅限于局域网范围内的计算机连接', 10, '0');
INSERT INTO `user_topic` VALUES (732, 27, 34, 44, 314, 'TCP和IP', 10, '0');
INSERT INTO `user_topic` VALUES (733, 27, 34, 44, 315, '实时监测控制', 10, '0');
INSERT INTO `user_topic` VALUES (734, 27, 34, 44, 316, 'Internet不属于某个国家或组织', 10, '0');
INSERT INTO `user_topic` VALUES (735, 27, 34, 44, 317, '网络层', 10, '0');
INSERT INTO `user_topic` VALUES (736, 27, 34, 44, 318, '分组交换技术', 10, '0');
INSERT INTO `user_topic` VALUES (737, 27, 34, 44, 319, '一个计算机网络由以下三个主要部分组成：\n1若干个主机;它们向各用户提供服务；\n2一个通信子网;它由一些专用的结点交换机和连接这些结点的通信链路所组成；\n3一系列的协议..这些协议是为在主机之间或主机和子网之间的通信而用的..', 13.333333333333334, '0');
INSERT INTO `user_topic` VALUES (738, 27, 34, 44, 320, '传输层是计算机网络中的第四层，负责为应用层提供可靠的数据传输服务。它提供了两种服务：面向连接的可靠传输和无连接的不可靠传输。面向连接的可靠传输使用TCP（传输控制协议），它确保数据能够按顺序到达目的地，且不丢失和重复。而无连接的不可靠传输使用UDP（用户数据报协议），它不保证数据的可靠传输，但是传输效率较高。', 20, '0');

-- ----------------------------
-- Table structure for zj_paper_test
-- ----------------------------
DROP TABLE IF EXISTS `zj_paper_test`;
CREATE TABLE `zj_paper_test`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `classes_id` int(0) NULL DEFAULT NULL,
  `exam_id` int(0) NULL DEFAULT NULL,
  `topic_id` int(0) NULL DEFAULT NULL,
  `correct_answer` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标准答案',
  `user_answer` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '学生答案',
  `score` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '本题分数',
  `user_id` int(0) NULL DEFAULT NULL,
  `user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_date` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of zj_paper_test
-- ----------------------------

-- ----------------------------
-- Table structure for zj_paper_user
-- ----------------------------
DROP TABLE IF EXISTS `zj_paper_user`;
CREATE TABLE `zj_paper_user`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `exam_id` int(0) NULL DEFAULT NULL COMMENT '试卷id',
  `user_id` int(0) NULL DEFAULT NULL COMMENT '考试人',
  `status` int(0) NOT NULL COMMENT '0未考试',
  `score` int(0) NULL DEFAULT NULL COMMENT '分数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of zj_paper_user
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
