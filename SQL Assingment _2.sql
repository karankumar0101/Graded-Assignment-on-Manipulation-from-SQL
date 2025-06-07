SQL Codes:

Here are the **SQL scripts** for each of the analysis tasks outlined in your assignment:

---

### **1. Employee Productivity Analysis**
Identify employees with the highest total hours worked and least absenteeism:

SELECT employeeid, employeename, 
       SUM(total_hours) AS total_hours_worked, 
       SUM(days_present) AS total_days_present, 
       SUM(days_absent) AS total_days_absent
FROM attendance
GROUP BY employeeid, employeename
ORDER BY total_hours_worked DESC, total_days_absent ASC;

---

### **2. Departmental Training Impact**
Analyze how training programs improve departmental performance:

SELECT e.department_id, t.program_name, 
       AVG(t.feedback_score) AS avg_feedback_score, 
       COUNT(t.employeeid) AS num_employees_trained
FROM Training_Programs t
JOIN Employee_Details e ON t.employeeid = e.employeeid
GROUP BY e.department_id, t.program_name
ORDER BY e.department_id, avg_feedback_score DESC;
---

### **3. Project Budget Efficiency**
Evaluate the efficiency of project budgets by calculating cost per hour worked:

SELECT p.project_id, p.project_name, p.budget, 
       SUM(p.hours_worked) AS total_hours_worked, 
       (p.budget / SUM(p.hours_worked)) AS cost_per_hour
FROM Project_Assignments p
GROUP BY p.project_id, p.project_name, p.budget
ORDER BY cost_per_hour ASC;

---

### **4. Attendance Consistency**
Measure attendance trends and identify departments with significant deviations:

SELECT e.department_id, 
       AVG(a.total_hours) AS avg_hours_worked, 
       AVG(a.days_present) AS avg_days_present, 
       AVG(a.days_absent) AS avg_days_absent
FROM Attendance a
JOIN Employee_Details e ON a.employeeid = e.employeeid
GROUP BY e.department_id
ORDER BY avg_hours_worked DESC;

---

### **5. Training and Project Success Correlation**
Link training technologies with project milestones to assess training impact:

SELECT t.employeeid, t.employeename, t.program_name, 
       p.project_name, p.milestones_achieved, t.feedback_score
FROM Training_Programs t
JOIN Project_Assignments p ON t.employeeid = p.employeeid
WHERE t.technologies_covered = p.technologies_used
ORDER BY t.feedback_score DESC, p.milestones_achieved DESC;

---

### **6. High-Impact Employees**
Identify employees contributing to high-budget projects with excellent performance:

SELECT e.employeeid, e.employeename, e.performance_score, 
       p.project_name, p.budget
FROM Employee_Details e
JOIN Project_Assignments p ON e.employeeid = p.employeeid
WHERE e.performance_score = 'Excellent' 
  AND p.budget > (SELECT AVG(budget) FROM Project_Assignments)
ORDER BY p.budget DESC, e.performance_score DESC;
