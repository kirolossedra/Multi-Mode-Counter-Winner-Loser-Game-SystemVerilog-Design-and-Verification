# Multi-Mode-Counter-Winner-Loser-Game-SystemVerilog-Design-and-Verification


# Test Cases Discussed and how to excite them :

| Test Case # | Description | INIT Value | Ctrl Sequence 
| --- | --- | --- | --- |
| 1 | make sure of Loser winning functionality Making the counter increment by 2 so 7 is not reached so the Winner count doesn't Increase | 0 | 01
| 2 | Check loser winning functionality by incrementing counter by 1 and starting at zero so eventually the loser will reach 15 points first | 0 | 00
| 3 | alternate the count up and down and make sure winner wins (increase 1 time to 7 and decrease to 6 till the winner count to 15) | 0 | 00 - 10 ... 
| 4 | alternate the count up and down by 1 from zero to 1 and 1 to zero to make sure Loser wins | 0 | 00 - 10 ... 
| 5 | add initial value 7 and increase by 2 to make sure winner wins | 7 | 01
| 6 | add initial value 6 and increase by 1 , so eventually the winner will win | 6 | 00
| 7 | add initial value 6 and decrease counter 2 so eventually loser will win | 6 | 11
| 8 | make the count start at zero increase by 1 and then by 2 0 , 1, 3,4,6,7,1 ... Then eventualy the Winner will win | 0 | 00 - 01 ...
| 9 | to test reset functionality  | 0 then  7 | 00 - 01 






