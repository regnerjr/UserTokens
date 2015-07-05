MAIN PROJECT:

Built starting from the bare SplitViewController Template. 
The UserTokens application requires Xcode 7 Beta 2. (I wanted to user the fancy
new code coverage reporting and try out Swift 2).

When launched on an ipad or iPhone the Users list is shown from there you can
use the Add User button to create a new user.

This new user will be added to the list of all users. If you select the user
from the list you can view all the users details. When viewing the details the
user can be edited or you can manage the users tokens. Buttons are supplied for
both.

The Edit user functionality allows change of Username, Password and Even ID. The
manage tokens screen allows generation of new tokens and removal of old tokens,
through a simple list display.

Data is persisted on disk between launches by utilizing Foundation's
NSKeyedArchiver.

ADDITIONAL PROJECTS:
I opted to add Unit tests with the goal of getting to 100% coverage. While I was
not able to achieve 100% coverage. I did learn a lot about unit testing while
working on this project. There are a few places where unit testing was not a
good fit, for these areas I have implemented UITesting. This gives my app a
great Foundation to ensure desired functionality stays operational.
