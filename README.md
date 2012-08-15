# ActsAsNotifiable
[![Build Status](https://secure.travis-ci.org/QFive/acts_as_notifiable.png)](http://travis-ci.org/QFive/acts_as_notifiable)

ActsAsNotifiable aims to be a flexibile notification system for your Rails application. On social networks, notifications are can be sent from any kind of action. ActsAsNotifiable has 2 goals:

1. Centralize the creation of notifications on different objects in a system
2. Provide a modular way to deliver these notifications across various methods

## Notifications
Some examples of various things that may generate a notification include:

* A user follows another user
* A user comments on a user's post
* A user likes another post


### Couriers
As systems become larger and users have more ways to receive notifications, a flexibile delivery system is needed. ActsAsNotifiable couriers will do just this.

Example couriers:

* Email
* Apple Push Notification
* SMS

## Example Usage

First, you will need a model to hold notifications.

`
class Notification < ActiveRecord::Base
	include ActsAsNotifiable::Notification
end
`


A notification has the following properties:

`
belongs_to :sender, polymorphic: true
belongs_to :receiver, polymorphic: true
belongs_to :notifiable: polymorphic: true
belongs_to :target, polymorphic: true
`

### Notifiable
With a base notification class in place we can start generating notifications for a user.

`
class Post < ActiveRecord::Base
	has_many :comments
	belongs_to :author
end

class Comment < ActiveRecord::Base
	notifiable receiver: lambda { |c| c.post.author }, sender: :author
	notify_via :email
	
	belongs_to :author
	belongs_to :post
end
`
Whenever a comment is created, the author of the post the comment belongs to will receive a notification notifying them that the comment author commented on their post.

notify_va specifies any couriers to use to deliver this notification, in this case an email will be generated.

## ToDo

* Document advanced usage
* Abstract APNS courier out
* Example courier creation
* Refactor ActsAsNotifiable::Notification

## License
MIT License. Copyright 2012 QFive, Inc. [http://www.qfive.com](http://www.qfive.com)