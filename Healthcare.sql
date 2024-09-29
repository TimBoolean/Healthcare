use healthcare_dataset;

Create table healthy (

Name varchar(255),
Age	int,
Gender enum ('Male','Female'),
BloodType varchar(50),
MedicalCondition varchar(50),	
DateofAdmission date,
Doctor varchar(255),
Hospital Varchar(255),
InsuranceProvider varchar(255),
BillingAmount decimal (13,8),
RoomNumber int,
AdmissionType varchar(50),
DischargeDate date,
Medication	varchar(50),
TestResults varchar(50)
);

Load data infile 'health.csv' into table healthy
fields terminated by ','
ignore 1 lines;


select * from healthy;

select
billingamount,
medicalcondition,
rank() over (partition by medicalcondition orderby billingamount) as nums 
from healthy
order by nums desc;

select Medicalcondition, count(medicalcondition) as cnt_meds, sum(billingamount) as total_billing
from healthy
group by medicalcondition
order by total_billing desc;

select age, medicalcondition, count(medicalcondition) cnt_meds
from healthy
group by 1,2
order by cnt_meds desc;

select gender, medicalcondition, count(medicalcondition) cnt_meds
from healthy
group by 1,2
order by cnt_meds desc;

select gender, count(medicalcondition) cnt_meds
from healthy
group by 1
order by cnt_meds desc;

select bloodtype, count(bloodtype) as cnt_blood, count(medicalcondition) as cnt_meds
from healthy
group by 1
order by bloodtype asc;

select medicalcondition,  round(avg(dischargedate - dateofadmission),0) as avg_stay,
case 
	when round(avg(dischargedate - dateofadmission),0)  > 10 then "long"
	when round(avg(dischargedate - dateofadmission),0)  < 10 then "short"
else "equal"
end as Length_of_stay		
from healthy
group by 1;

select medicalcondition, avg(dischargedate-dateofadmission) as avg
from healthy
group by medicalcondition
