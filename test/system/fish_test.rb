require "application_system_test_case"

class FishTest < ApplicationSystemTestCase
  setup do
    @fish = fish(:one)
  end

  test "visiting the index" do
    visit fish_url
    assert_selector "h1", text: "Fish"
  end

  test "creating a Fish" do
    visit fish_url
    click_on "New Fish"

    fill_in "Description", with: @fish.description
    fill_in "Name", with: @fish.name
    fill_in "Price", with: @fish.price
    fill_in "User", with: @fish.user_id
    click_on "Create Fish"

    assert_text "Fish was successfully created"
    click_on "Back"
  end

  test "updating a Fish" do
    visit fish_url
    click_on "Edit", match: :first

    fill_in "Description", with: @fish.description
    fill_in "Name", with: @fish.name
    fill_in "Price", with: @fish.price
    fill_in "User", with: @fish.user_id
    click_on "Update Fish"

    assert_text "Fish was successfully updated"
    click_on "Back"
  end

  test "destroying a Fish" do
    visit fish_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Fish was successfully destroyed"
  end
end
