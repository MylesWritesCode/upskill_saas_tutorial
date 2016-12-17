[Upskill](http://upskillcourses.com) Tutorial: Software-as-a-Service Ruby on Rails App

This is a full, but basic implementation of a rails app that can save users, bill subscribing members using Stripe, and display data based on if that user is a "Pro" member or a "Basic" member. Users are able to view other profiles and get their contact information if they have the right account privileges.

Notable gems used:
* Devise - user implementation
* Paperclip - image (avatar) uploads
* Figaro - hiding private keys (mainly for stripe)
* Stripe - payment handler (no cc info is saved on the rails app)
