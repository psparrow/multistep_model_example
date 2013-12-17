class Person < ActiveRecord::Base
  state_machine :state, :initial => :name do

    state :name do
      def form_fields
        [:name]
      end
    end

    state :email do
      validates_presence_of :name

      def form_fields
        [:email]
      end
    end

    state :phone do
      validates_presence_of :email

      def form_fields
        [:phone]
      end
    end

    state :complete do
      validates_presence_of :phone
    end

    event :next_step do
      transition :name => :email
      transition :email => :phone
      transition :phone => :complete
    end
  end
end
