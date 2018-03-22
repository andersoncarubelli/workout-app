require "rails_helper"

RSpec.feature "Listing Exercises" do
  before do
    @john = User.create(email: "john@example.com", password: "password")
    login_as(@john)

    @exercise_one = @john.exercises.create(duration_in_min: 20,
                                  workout: "My body building activity",
                                  workout_date: Date.today)

    @exercise_two = @john.exercises.create(duration_in_min: 55,
                                  workout: "Weight lifting",
                                  workout_date: 2.days.ago)
  end

  scenario "shows user's workout for last 7 days" do
    visit '/'

    click_link "My Lounge"

    expect(page).to have_content(@exercise_one.duration_in_min)
    expect(page).to have_content(@exercise_one.workout)
    expect(page).to have_content(@exercise_one.workout_date)

    expect(page).to have_content(@exercise_two.duration_in_min)
    expect(page).to have_content(@exercise_two.workout)
    expect(page).to have_content(@exercise_two.workout_date)

  end
end
