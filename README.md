MAIN PROJECT (REQUIRED):

Please build an iOS app to manage a list of users with their associated
application tokens. Each user should contain ID, username, password, created
timestamp, and last updated timestamp. Each user may also contain zero or more
tokens. You're welcome to utilize the 3rd party libraries and frameworks of your
choice. This application should have a pleasing user interface and should be
accounted for iPhone-5 and iPhone-6 and iPad screen sizes. 

Minimum requirements:
- ID should be at least 20 characters and unique
    - Username should be an email and unique
    - Password should be at least 8 characters long and contain at least one
        numeric character
    - Token string should be at least 20 characters and unique Please write up a
        README.md with any explanation and instructions for running this
        application. 

  Minimum functionality:
  - Data can be stored using Core Data or sqlite 
  - User can be created, updated, and deleted
  - Full user list is displayed (pagination is optional)
  - Auto-generated token can be added to a user. It can also be removed. List of
      tokens for each user is revealed upon clicking a user’s list.

  ADDITIONAL PROJECTS. Please complete one of the following:

    Option 1: Add unit tests with a goal of getting to 100% of code coverage. 

    Option 2: Describe how would you hookup a backend server to store the data -
    explain the frameworks and tools you would use for doing this.  Also, assume
    there is another way to add this data to the server (say via a web
    interface), how would you ensure that the data is in sync with the mobile
    app, and potentially how you would resolve conflicts?
