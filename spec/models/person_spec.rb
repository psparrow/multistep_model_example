require "spec_helper"

describe Person  do

  context "a new Person" do
    it "starts with entering a name" do
      subject.state.should == "name"
    end

    it "transitions to entering an email address" do
      subject.next_step_transition.to.should == "email"
    end

    it "accepts the name field via form" do
      subject.form_fields.should == [:name]
    end
  end

  context "entering email" do
    subject { Person.new(state: "email") }

    it { should validate_presence_of :name }

    it "transitions to entering phone number" do
      subject.next_step_transition.to.should == "phone"
    end

    it "accepts the email field via form" do
      subject.form_fields.should == [:email]
    end
  end

  context "entering phone" do
    subject { Person.new(state: "phone") }

    it { should validate_presence_of :email }

    it "transitions to complete" do
      subject.next_step_transition.to.should == "complete"
    end

    it "accepts the phone field via form" do
      subject.form_fields.should == [:phone]
    end
  end

  context "complete" do
    subject { Person.new(state: "complete") }

    it { should validate_presence_of :phone }
  end

end
