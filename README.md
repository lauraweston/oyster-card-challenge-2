# Oystercard Challenge

This challenge will start with going back over the basics we covered last week in Boris Bikes, giving you the chance to reinforce what you learned last week. You'll then be challenged to build a more complex system which should really stretch your skills in Code Design, Ruby, RSpec and Object-Oriented Programming.

User Stories
---------------

Here are the user stories for this project:

```
In order to use public transport
As a customer
I want money on my card

In order to keep using public transport
As a customer
I want to add money to my card

In order to protect my money
As a customer
I don't want to put too much money on my card

In order to pay for my journey
As a customer
I need my fare deducted from my card

In order to get through the barriers
As a customer
I need to touch in and out

In order to pay for my journey
As a customer
I need to have the minimum amount for a single journey

In order to pay for my journey
As a customer
I need to pay for my journey when it's complete

In order to pay for my journey
As a customer
I need to know where I've travelled from

In order to know where I have been
As a customer
I want to see to all my previous trips

In order to know how far I have travelled
As a customer
I want to know what zone a station is in

In order to be charged correctly
As a customer
I need a penalty charge deducted if I fail to touch in or out

In order to be charged the correct amount
As a customer
I need to have the correct fare calculated
```
Example input
-------------
```
2.3.0 :010 > bank = Station.new("bank", 1)
 => #<Station:0x007ff2fa96a808 @name="bank", @zone=1>
2.3.0 :011 > aldgate = Station.new("aldgate", 1)
 => #<Station:0x007ff2fa958d10 @name="aldgate", @zone=1>
2.3.0 :012 > card = OysterCard.new(JourneyLog.new(Journey))
 => #<OysterCard:0x007ff2fa943938 @balance=0, @journey_log=#<JourneyLog:0x007ff2fa943988 @journey_class=Journey, @journeys=[]>>
2.3.0 :013 > card.top_up(100)
RuntimeError: The maximum amount allowed on the card is £90
       	from /Users/lauraweston/code/makers/week-2/oystercard-day-3/lib/oyster_card.rb:13:in `top_up'
       	from (irb):13
       	from /Users/lauraweston/.rvm/rubies/ruby-2.3.0/bin/irb:11:in `<main>'
2.3.0 :014 > card.top_up(10)
 => 10
2.3.0 :015 > card.touch_in(bank)
 => 10
2.3.0 :016 > card.touch_out(aldgate)
 => 9
2.3.0 :017 > card.touch_out(bank)
 => 3
2.3.0 :018 > card.touch_in(bank)
 => 3
2.3.0 :019 > card.touch_in(bank)
 => -3
2.3.0 :020 > card.touch_in(bank)
RuntimeError: Please top up the card
       	from /Users/lauraweston/code/makers/week-2/oystercard-day-3/lib/oyster_card.rb:18:in `touch_in'
       	from (irb):20
       	from /Users/lauraweston/.rvm/rubies/ruby-2.3.0/bin/irb:11:in `<main>'
2.3.0 :021 > card.top_up(10)
 => 7
 ```
