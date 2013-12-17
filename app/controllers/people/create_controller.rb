class People::CreateController < ApplicationController
  before_filter :load_person, only: [:edit, :update]

  def new
    @person = Person.new
  end

  def create
    @person = Person.new

    @person.assign_attributes(person_params)

    if @person.next_step
      redirect_to edit_person_create_path(@person)
    else
      render :new
    end
  end

  def edit; end

  def update
    @person.assign_attributes(person_params)

    if @person.next_step
      if @person.state == "complete"
        redirect_to person_path(@person)
      else
        redirect_to edit_person_create_path(@person)
      end
    else
      render :edit
    end
  end

  private

  def load_person
    @person = Person.find(params[:id])
  end

  def person_params
    params.require(:person).permit(@person.form_fields)
  end
end
