This is a solution to the ruby quiz described at:

http://rubyquiz.com/quiz27.html

to run, execute like this:

./bin/findpath.rb start_postion finish_postion [list of squares to exclude]

Here is the output from a few sample runs, where I find a path between a1 and a2, and then remove the first possible move from the returned routes, until I eliminate all possible paths between those two positions:

./bin/findpath.rb a1 a2

a1,c2,b4,a2

./bin/findpath.rb a1 a2 c2

a1,b3,c1,a2

./bin/findpath.rb a1 a2 c2 c1

a1,b3,d4,c6,b4,a2

./bin/findpath.rb a1 a2 c2 c1 b3

no path found
