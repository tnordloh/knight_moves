This is a solution to the ruby quiz http://rubyquiz.com/quiz27.html

to run, execute like this:

./bin/findpath.rb start_postion finish_postion [list of squares to exclude]

Some examples:

git@github.com:tnordloh/knight_moves.git ~/code/knight_moves :./bin/findpath.rb a1 a2
a1,c2,b4,a2
git@github.com:tnordloh/knight_moves.git ~/code/knight_moves :./bin/findpath.rb a1 a2 c2
a1,b3,c1,a2
git@github.com:tnordloh/knight_moves.git ~/code/knight_moves :./bin/findpath.rb a1 a2 c2 c1
a1,b3,d4,c6,b4,a2
git@github.com:tnordloh/knight_moves.git ~/code/knight_moves :./bin/findpath.rb a1 a2 c2 c1 b3
no path found
