select co.contest_id,hacker_id,name, sum(ss.total_submission) Total_Submission,sum(ss.total_accepted_submission) Total_Accepted_Submission 
into #temp1
from contests co 
inner join colleges cl on co.contest_id=cl.contest_id 
inner join challenges ch on cl.college_id=ch.college_id 
inner join submission_stats ss on ch.challenge_id=ss.challenge_id
group by co.contest_id,hacker_id,name

select co.contest_id,hacker_id,name, sum(vs.total_views) Total_views,sum(vs.total_unique_views) Total_unique_views
into #temp2
 from contests co 
inner join colleges cl on co.contest_id=cl.contest_id 
inner join challenges ch on cl.college_id=ch.college_id 
inner join view_stats vs on ch.challenge_id=vs.challenge_id
group by co.contest_id,hacker_id,name


select isnull(A.contest_id,b.contest_id) CONTEST_ID,isnull(a.hacker_id,b.hacker_id) HACKER_ID,isnull(a.Name,b.name) NAME,isnull(a.Total_Submission,0) TOTAL_SUBMISSION,
isnull(a.Total_Accepted_Submission,0) TOTAL_ACCEPTED_SUBMISSION,isnull(b.Total_views,0) TOTAL_VIEWS,isnull(b.Total_unique_views,0) TOTAL_UNIQUE_VIEWS 
from #temp1 a
full outer join  #temp2 b
on A.contest_id = B.contest_id 
where a.Total_Submission<>0 or a.Total_Accepted_Submission<>0 or b.Total_unique_views<>0 or b.Total_views<>0 order by 1 asc 
