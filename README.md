# Multi-Mode-Counter-Winner-Loser-Game-SystemVerilog-Design-and-Verification


# Test Cases Discussed and how to excite them :

| Test Case # | Description | INIT Value | Ctrl Sequence 
| --- | --- | --- | --- |
| 1 | make sure of Loser winning functionality Making the counter increment by 2 so 7 is not reached so the Winner count doesn't Increase | 0 | 01
| 2 | Check Loser winning functionality by incrementing counter by 1 and starting at zero so eventually the loser will reach 15 points first | 0 | 00
| 3 | alternate the count up and down and make sure winner wins (increase 1 time to 7 and decrease to 6 till the winner count to 15) | 0 | 00 - 10 ... 
| U | alternate the count up and down by 2 from zero to 2 and 2 to zero to make sure Loser wins | 0 | 00 - 10 ... (Useless)
| 4 | add initial value 7 and increase by 2 to make sure winner wins | 7 | 01
| U | add initial value 6 and increase by 1 , so eventually the winner will win useless test case  | 6 | 00
| U | add initial value 6 and decrease counter 2 so eventually loser will win useless test case  | 6 | 11
| 5 | make the count start at zero increase by 1 and then by 2 0 , 1, 3,4,6,7,1 ... Then eventualy the Winner will win | 0 | 00 - 01 ...
| 6 | to test reset functionality , make it at zero then count up by 1 then after 4 iterations reset and give initial value 7 and make it count up by 2  | 0 then  7 | 00 - 01 






