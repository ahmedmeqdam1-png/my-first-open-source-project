-- قاعدة بيانات مركز الاختبارات الإلكترونية - جامعة صنعاء
CREATE DATABASE IF NOT EXISTS sanaa_eec DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE sanaa_eec;

CREATE TABLE IF NOT EXISTS students (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name_ar VARCHAR(190) NOT NULL,
  name_en VARCHAR(190) NOT NULL,
  phone VARCHAR(9) NOT NULL UNIQUE,
  university VARCHAR(150) NOT NULL,
  college VARCHAR(150) NOT NULL,
  major VARCHAR(150) NOT NULL,
  level ENUM('ماجستير', 'دكتوراه', 'دبلوم عالي') NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS invoices (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  invoice_no INT UNSIGNED NOT NULL UNIQUE,
  student_id INT UNSIGNED NOT NULL,
  type ENUM('initial', 'retake') NOT NULL DEFAULT 'initial',
  total_amount DECIMAL(10,2) NOT NULL DEFAULT 5000.00,
  status ENUM('requested', 'issued', 'submitted', 'approved') NOT NULL DEFAULT 'requested',
  receipt_ref VARCHAR(100) NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS student_subjects (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  student_id INT UNSIGNED NOT NULL,
  subject_name ENUM('اللغة العربية', 'اللغة الإنجليزية', 'الحاسوب') NOT NULL,
  exam_date DATE NULL,
  status ENUM('unbooked', 'booked', 'inv_requested', 'inv_issued', 'confirmed', 'passed', 'failed', 'retake_requested', 'retake_issued') NOT NULL DEFAULT 'unbooked',
  invoice_id INT UNSIGNED NULL,
  score TINYINT UNSIGNED NULL,
  FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
  UNIQUE KEY uq_student_exam_date (student_id, exam_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO students (id, name_ar, name_en, phone, university, college, major, level) 
VALUES (1, 'أحمد محمد العمري', 'Ahmed Al-Omari', '777123456', 'جامعة صنعاء', 'كلية الحاسوب وتكنولوجيا المعلومات', 'علوم الحاسوب', 'ماجستير')
ON DUPLICATE KEY UPDATE id=id;
