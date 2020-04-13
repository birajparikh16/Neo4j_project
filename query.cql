
// Total complaints
MATCH (c:Complaint)
RETURN count(c) AS total_complaints

// Top product having most complaints
MATCH (Complaint)-[:ABOUT]->(p:Product)
RETURN p.name AS product, COUNT(*) AS `Most Complaints`
ORDER BY `Most Complaints` DESC
LIMIT 25;

// Finding product having sub-products with most issues
MATCH (Complaint)-[:ABOUT]->(p:Product)
MATCH (subproduct:SubProduct)-[:IN_CATEGORY]->(p:Product)
MATCH (Complaint)-[:ABOUT]->(subproduct:subProduct)
MATCH (Complaint)-[:WITH]->(subissue:SubIssue)
RETURN p.name AS Product, subproduct.name AS `Sub-Product`, COUNT(*) AS `Most Issues`
ORDER BY `Most Issues` DESC;

// All issues.
MATCH (issue:Issue)
RETURN issue.name AS issue
ORDER BY issue;

// All sub-issues within the 'Unable to get credit report/credit score' issue.
MATCH (i:Issue {name:'UNABLE TO GET CREDIT REPORT/CREDIT SCORE'})
MATCH (sub:SubIssue)-[:IN_CATEGORY]->(i)
RETURN sub.name AS subissue, COUNT(*) as count
ORDER BY count;

// Top Companies with products having most number of complaints
MATCH (c:Complaint)-[:AGAINST]->(co:Company)
MATCH (c)-[:ABOUT]->(p:Product)
RETURN co.name AS Company, p.name AS Product, COUNT(*) AS `Complaints`
ORDER BY `Complaints` DESC
LIMIT 25;

// Top product and issue combinations with disputed responses at Bank Of America
MATCH (boa:Company {name:'BANK OF AMERICA'})
MATCH (complaint:Complaint)-[:AGAINST]->(boa)
MATCH (:Response)-[:TO {disputed:true}]->(complaint)
MATCH (complaint)-[:ABOUT]->(p:Product)
MATCH (complaint)-[:WITH]->(i:Issue)
RETURN p.name AS product, i.name AS issue, COUNT(*) AS count
ORDER BY count DESC;

// Top company associated with the Transaction issue.
MATCH (complaint:Complaint)-[:WITH]->(issue:Issue {name:'TRANSACTION ISSUE'} )
MATCH (complaint)-[:AGAINST]->(company:Company)
RETURN company.name AS company, COUNT(*) AS count
ORDER BY count DESC
LIMIT 10;

// Finding companies which gives timely response for the given issue
MATCH (complaint:Complaint)-[:WITH]->(issue:Issue {name:'TRANSACTION ISSUE'} )
MATCH (complaint)-[:AGAINST]->(company:Company)
MATCH (:Response)-[:TO {timely:true}]->(complaint)
RETURN company.name AS company, COUNT(*) AS count

// Exploring second degree connection with product havinf "card" in it
MATCH p=(pro:Product) – [*..2] – () WHERE pro.name CONTAINS "CARD" RETURN p LIMIT 50

// Finding Products having responses that are timely disputed
Top types of responses that are disputed.
MATCH (c:Complaint)-[:ABOUT]->(p:Product)
MATCH (r:Response)-[:TO]->(c:Complaint)
MATCH (r:Response)-[:TO {disputed:true}]->(:Complaint)
MATCH (r:Response)-[:TO {timely:true}]->(:Complaint)
RETURN p.name AS product, r.name AS response, COUNT(*) AS count
ORDER BY count DESC;

// Top products and sub-products associated with the obscene / abusive language sub-issue.
MATCH (subIssue:SubIssue {name:'USED OBSCENE/PROFANE/ABUSIVE LANGUAGE'})
MATCH (complaint:Complaint)-[:WITH]->(subIssue)
MATCH (complaint)-[:ABOUT]->(p:Product)
OPTIONAL MATCH (complaint)-[:ABOUT]->(sub:SubProduct)
RETURN p.name AS product, sub.name AS subproduct, COUNT(*) AS count
ORDER BY count DESC;