require "rails_helper"

RSpec.feature "Listing Exercises" do
  before do
    @john = User.create(first_name: 'John', last_name: 'Doe', email: "john@example.com", password: "password")
    login_as(@john)

    @exercise_one = @john.exercises.create(duration_in_min: 20,
                                  workout: "My body building activity",
                                  workout_date: Date.today)

    @exercise_two = @john.exercises.create(duration_in_min: 55,
                                  workout: "Weight lifting",
                                  workout_date: 2.days.ago)

    @exercise_three = @john.exercises.create(duration_in_min: 35,
                                  workout: "On treadmill",
                                  workout_date: 8.days.ago)
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

    expect(page).not_to have_content(@exercise_three.duration_in_min)
    expect(page).not_to have_content(@exercise_three.workout)
    expect(page).not_to have_content(@exercise_three.workout_date)
  end

  scenario 'Shows no exercises if none created' do
    @john.exercises.delete_all

    visit '/'
    click_link 'My Lounge'

    expect(page).to have_content('No Workouts Yet')
  end
end
