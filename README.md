# README  
  
This README would normally document whatever steps are necessary to get the  
application up and running.  
  
## Ruby version >= 2.6.2  
  
## System dependencies:  
chackability gem  
  
## Configuration  
```
bundle install  
```
## Database creation  
```
rails db:migrate  
```
## Database initialization  
```
rails db:seed
```
## How to run the test suite  
```
rspec
```
  
## Services (job queues, cache servers, search engines, etc.)  
  
## Deployment instructions
It is not developed for production  
For use on local computer:  
```
clone https://github.com/azazelo/postcode_checker.git  
cd postcode_checker
bundle install  
rails db:migrate
rails db:seed
rails s  
```
In browser see page http://localhost:3000  

## Future works

- [ ] Separate result messages in lines and give them appropriate colors  
- [ ] Make other configurations e.g.ZIP(USA), RU Postcodes. etc
- [ ] Make validation with postcodes.io
- [ ] Make autocomplete with postcodes.io

