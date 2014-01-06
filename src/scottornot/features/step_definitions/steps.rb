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

  #need to find a way to add cookies 
end

When(/^I vote$/) do
  #get old picture id  <input id="picture_id">
  click_on('Scott!')
end

Then(/^I should not see a prior vote$/) do
  page.should have_no_selector("img#prior-hero")
end

Then(/^I should see a picture to vote on$/) do
  #image with an id of 'hero'
  find("img#hero")
end

Then(/^I should see a voting fom$/) do
  find("#voting-form")
end

Then(/^I should see my previous vote in the side bar$/) do
  #image with an id of 'last-hero'
  find('img#prior-hero')
  #also make sure that it is the last one voted on...
end