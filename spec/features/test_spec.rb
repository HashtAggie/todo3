require 'rails_helper'

feature 'Manage tasks', :js => true do
    def create_todo(title)
      visit root_path
      fill_in 'todo_title', with: title
      page.execute_script("$('form#new_todo').submit();")
      sleep 2
    end


  scenario 'The counter updates when creating new tasks' do
    title = 'Catch a few Capybaras'
    visit root_path
    fill_in 'todo_title', with: title
    page.execute_script("$('form#new_todo').submit();")
    expect( page.find(:css, 'span#todo-count').text ).to eq "1"
    sleep 2
  end

  scenario 'The completed counter updates when completing tasks' do
    title = 'Catch a few Capybaras'
    visit root_path
    fill_in 'todo_title', with: title
    page.execute_script("$('form#new_todo').submit();")
    expect( page.find(:css, 'span#completed-count').text ).to eq "0"
    check('todo-1')
    sleep 2
    expect( page.find(:css, 'span#todo-count').text ).to eq "0"
    expect( page.find(:css, 'span#completed-count').text ).to eq "1"
    sleep 2
  end

  scenario 'The whole shabang' do
    title = 'Catch a few Capybaras'
    create_todo(title)
    title = 'Drink beers'
    create_todo(title)
    title = 'Stay awake'
    create_todo(title)
    expect( page.find(:css, 'span#completed-count').text ).to eq "0"
    check('todo-1')
    sleep 2
    expect( page.find(:css, 'span#todo-count').text ).to eq "2"
    expect( page.find(:css, 'span#total-count').text ).to eq "3"
    expect( page.find(:css, 'span#completed-count').text ).to eq "1"
click_link('Clean up')
  end
end
