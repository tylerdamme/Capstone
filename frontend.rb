require "unirest"
require "pp"

jwt = ""

while true
  system "clear"
  puts "Welcome to the Sports News App!"
  puts
  puts "[1] View my teams"
  puts "[2] Create news sources"
  puts
  puts "[signup] Signup"
  puts "[login] Login"
  puts "[logout] Logout"
  puts
  puts "[q] Quit"

  print "Please make a selection: "
  input_option = gets.chomp

  if input_option == "1"
    response = Unirest.get("http://localhost:3000/v1/teams")
    teams = response.body
    pp teams
    puts
    print "Enter the id of the team you wish to view: "
    team_id = gets.chomp
    response = Unirest.get("http://localhost:3000/v1/teams/#{team_id}")
    team = response.body
    pp team
  elsif input_option == "2"
    params = {}
    puts "Fox Sports? (y/n)"
    choice = gets.chomp
    if choice == y
      params[:display_name] = "Fox Sports"
      params[:api_name] = "fox-sports"
      response = Unirest.post("http:localhost:3000/v1/news_sources", parameters: params)
      news = response.body
      pp news
  elsif input_option == "signup"
    params = {}
    print "Enter a name: "
    params[:name] = gets.chomp
    print "Enter an email: "
    params[:email] = gets.chomp
    print "Enter a password: "
    params[:password] = gets.chomp
    print "Please confirm password: "
    params[:password_confirmation] = gets.chomp
    response = Unirest.post("http://localhost:3000/v1/users", parameters: params)
    pp response.body
  elsif input_option == "login"
    params = {}
    puts "Login to the app"
    print "Enter email: "
    params[:email] = gets.chomp
    print "Enter password: "
    params[:password] = gets.chomp
    response = Unirest.post("http://localhost:3000/user_token",
      parameters: {auth: {email: params[:email], password: params[:password]}}
      )
    pp response.body
    jwt = response.body["jwt"]
    Unirest.default_header("Authorization", "Bearer #{jwt}")
  elsif input_option == "logout"
    jwt = ""
    Unirest.clear_default_headers()
  elsif input_option == "q"
    puts "Goodbye!"
    break    
  end
  puts
  puts "Press enter to continue"
  gets.chomp
end