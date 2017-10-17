# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
    This app is built in Sinatra.
- [x] Use ActiveRecord for storing information in a database
    ActiveRecord is used to migrate and relate classes to one another.
- [x] Include more than one model class (list of model class names e.g. User, Post, Category)
    My app uses three models: User, Challenge, and Log.  
- [x] Include at least one has_many relationship (x has_many y e.g. User has_many Posts)
    My user has many challenges and logs.  A challenge has many logs.  A log can also belong to many challenges.
    A join table is used to achieve the relationship between challenges and logs.
- [x] Include user accounts
    Users must create an account in order to use my app.  Passwords are authenticated.  
- [x] Ensure that users can't modify content created by other users
    Users and only see their own budget challenges and their own logs.  Trying to access their way in to other people's budget challenges and/or logs will redirect them back to their home page with a warning telling them that they cannot access others' info.
- [x] Include user input validations
    Users cannot put in blank username, email, or password.  They cannot also put in negative values for their budget limits or spending logs.    
- [x] Display validation failures to user with error message (example form URL e.g. /posts/new)
    Any time a user does not input things correctly, they're greeted with a flash message citing which fields they input correctly/or not given permission to.
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code
  README.md has been included, along with a contributor guide and a license for my code.

Confirm
- [x] You have a large number of small Git commits
  I wouldn't say large, but I am getting in a better habit of committing more frequently.
- [x] Your commit messages are meaningful
  I would commit when a functionality works and citing what functionality works in the commit message.
- [x] You made the changes in a commit that relate to the commit message
  I can confirm this.
- [x] You don't include changes in a commit that aren't related to the commit message
  I do not do this.
