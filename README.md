# Analyzing Consumer Complaints using Neo4j

## Description:
The Consumer Complaint Database is a collection of complaints about consumer financial products and services that we sent to companies for response. Complaints are published after the company responds, confirming a commercial relationship with the consumer, or after 15 days, whichever comes first.

## Setup

* Download `Consumer_Complaints.csv` [here](http://catalog.data.gov/dataset/consumer-complaint-database). Note that your .csv file might have more rows than mine did; they appear to update the data regularly.

## Import

- Change line 1 of `load.cql` to point to the location of your `Consumer_Complaints.csv` file.
    - OSX and Unix: `file:///path/to/Consumer_Complaints.csv`
    - Windows: `file:C:/path/to/Consumer_Complaints.csv`

- Send `load.cql` to the `neo4j-shell`: `./bin/neo4j-shell -file load.cql`

## Query

Run all the example queries:
```
./bin/neo4j-shell -file query.cql
```

## Reference

* http://jexp.de/blog/2014/06/load-csv-into-neo4j-quickly-and-successfully/
* http://www.markhneedham.com/blog/2014/10/23/neo4j-cypher-avoiding-the-eager/
* http://jexp.de/blog/2014/10/load-cvs-with-success/
