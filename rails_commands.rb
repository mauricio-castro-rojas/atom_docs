#kill rails server
Assuming you're looking to kill whatever is on port 3000 (which is what webrick normally uses), type this in your terminal to find out the PID of the process:

$ lsof -wni tcp:3000
Then, use the number in the PID column to kill the process:

$ kill -9 PID

kill -9 $(lsof -t -i:3000)


#start tailwind SERVICE
rails tailwindcss:watch

#watch Services
mauro@192 syapp % brew services
Name               Status  User  File
dbus               none
elasticsearch-full started mauro ~/Library/LaunchAgents/homebrew.mxcl.elasticsearch-full.plist
postgresql         started mauro ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
redis              started mauro ~/Library/LaunchAgents/homebrew.mxcl.redis.plist
unbound            none



Jahir Alejandro Rodriguez
  8:32 AM
3112629088



admin1@mail.com
123456Aa

<Employer id: 1, email: "employer_a@mail.com",
