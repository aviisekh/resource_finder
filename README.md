
# Problem: Develop an app of name “Who is available”.

Description: a database table has person’s available time [24 hrs format] as shown below.
<br>

<center>

| Person Name | Start Time | End Time |
|:------------|-----------:|---------:|
| Ram         | 05:00      | 07:00    |
| Ram         | 15:00      | 20:45    |
| Shyam       | 12:00      | 18:30    |
| Hari        | 08:00      | 23:59    |

</center>

User can ask to the system like this:

Is Ram available at **15:30 to 16:00** with some input (name, start time, end time) either in console or UI form?

Solution: A simple solution we proposed is: We define a binary timeline vector with considering 30 minutes time unit i.e. 48 time units in a day (hrs). For example a vector of Shyam looks like: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] Where 1 means available, 0 means busy.

1. Represent the availability time range for a person in the database of your choice. (We prefer PostgreSQL)
2. Construct the vectors from given time ranges in the database table and load in memory.
3. Perform vector operation whether the given time range is available for some person or not? The vector operation is: define overlapping function for the query time range to the memory vector of a person. If all overlaps then display someone is available in the given time range otherwise, not available.
4. Perform the save operation of the list of memory vectors to the database table as above after converting the vectors to the time ranges.

Implementation: You can write this program in any language of your choice? But we prefer Ruby in this case, as you are going use in the company.

Assumptions: While writing the program, make your necessary assumptions. Using immutable style of code and passing/using code blocks/proc makes concise program which leads you a high scorer.

