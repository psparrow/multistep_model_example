require "spec_helper"

feature "people" do
  scenario "creating a new person" do
    visit new_person_create_path

    fill_in "Name", with: "Patrick J. Sparrow"
    click_button "Next"

    person = Person.last
    person.name.should  == "Patrick J. Sparrow"
    person.state.should == "email"

    page.current_path.should == edit_person_create_path(person)

    fill_in "Email", with: "pat@sparrow.com"
    click_button "Next"

    person.reload
    person.email.should == "pat@sparrow.com"

    page.current_path.should == edit_person_create_path(person)

    fill_in "Phone", with: "555-1212"
    click_button "Next"

    person.reload
    person.phone.should == "555-1212"
    person.state.should == "complete"

    page.current_path.should == person_path(person)

    page.should have_content(person.name)
    page.should have_content(person.email)
    page.should have_content(person.phone)
  end
end
