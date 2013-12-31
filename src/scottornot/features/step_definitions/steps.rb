Given(/^I am a normal user$/) do
  #pending # express the regexp above with the code you wish you had
  true
end

When(/^I visit the voting page$/) do
  visit '/vote/'
end

When(/^I have not voted before$/) do
  #check that there is no cookie with name scottornotvotes

  #this only works with poltergeist and phantom...
  #if page.driver.cookies.size == 0
  #else
  #end


  #or that scottornotvotes size is 0
  #find cookies with name scottornotvotes []
  #stores ids of last few images voted on.  pushed onto array

end

When(/^I have voted before$/) do
  #this only works with poltergeist and phantom...

  #if page.driver.cookies.size == 0
  #  raise 'Has no cookies set'
  #else
  #end
end

Then(/^I should see a picture$/) do
  #image with an id of 'hero'
  find("img#hero")
end

Then(/^I should see a voting fom$/) do
  find("#votingForm")
end

Then(/^I should see my previous vote in the side bar$/) do
  #image with an id of 'last-hero'
  find('#last-hero')
end