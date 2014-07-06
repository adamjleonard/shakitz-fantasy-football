# -*- encoding : utf-8 -*-
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  season_length = 17

  test "user responds to won_up_to_game_week" do
    user = User.find(1)
    assert_respond_to user, :won_up_to_game_week
  end

  test "won up to game_week gives the correct number of wins, with 1 gw" do
    user = User.find(1)
    assert_equal 0, user.won_up_to_game_week(1)
  end

  test "won up to game_week givesw the correct number of wins, with 2 gw" do
    user = User.find(1)
    assert_equal 1, user.won_up_to_game_week(2)
  end

  test "user responds to drawn_up_to_game_week" do
    user = User.find(1)
    assert_respond_to user, :drawn_up_to_game_week
  end

  test "drawn_up_to_game_week gives the correct number of draws, with 1 gw" do
    user = User.find(1)
    assert_equal 1, user.drawn_up_to_game_week(1)
  end

  test "drawn_up_to_game_week gives the correct number of draws, with 2 gw" do
    user = User.find(1)
    assert_equal 1, user.drawn_up_to_game_week(2)
  end

  test "user responds to lost_up_to_game_week" do
    user = User.find(1)
    assert_respond_to user, :lost_up_to_game_week
  end

  test "lost_up_to_game_week returns the correct number of losses, with 1 gw" do
    user = User.find(2)
    assert_equal 0, user.lost_up_to_game_week(1)
  end

  test "lost_up_to_game_week returns the correct number of losses, with 2 gw" do
    user = User.find(2)
    assert_equal 1, user.lost_up_to_game_week(2)
  end

  test "user responds to   teams_up_to_game_week" do
    user = User.find(1)
    assert_respond_to user, :teams_up_to_game_week
  end

  test "list returned by teams_up_to_game_week is GameWeekTeam" do
    user = User.find(1)
    gwts = user.teams_up_to_game_week(1)
    assert_kind_of GameWeekTeam, gwts[0]
  end

  test "get ArgumentError if game_week is too high" do
    user = User.find(1)
    assert_raise ArgumentError do
      user.teams_up_to_game_week(18)
    end
  end

  test "get ArgumentError if game_week is too low" do
    user = User.find(1)
    assert_raise ArgumentError do
      user.teams_up_to_game_week(0)
    end
  end

  test "we get as many game_week_teams as weeks asked for" do
    user = User.find(1)
    assert_equal 5, user.teams_up_to_game_week(5).size
  end

  test "all teams are in the specified range" do
    user = User.find(1)
    gwts = user.teams_up_to_game_week(9)
    one_to_nine = 1 .. 9
    gwts.each do |game_week_team|
      assert one_to_nine.include?(game_week_team.game_week.number), "Team with number #{game_week_team.game_week.number} not expected"
    end
  end

  test "user responds to team_for_game_week" do
    user = User.find(1)
    assert_respond_to user, :team_for_game_week
  end

  test 'user has a set of opponents' do
    user = User.find(1)
    assert_respond_to user, :opponents
  end

  test "team_for_game_week gives game_week_team with correct user" do
    user = User.find(1)
    assert_equal user.id, user.team_for_game_week(1).user.id
  end

  test "team_for_game_week gives game_week_team with correct game_week" do
    user = User.find(1)
    assert_equal 1, user.team_for_game_week(1).game_week.number
  end

  test "can't give team_for_game_week zero" do
    user = User.find(1)
    assert_raise ArgumentError do
      user.team_for_game_week(0)
    end
  end

  test "can't give team_for_game_week 18" do
    user = User.find(1)
    assert_raise ArgumentError do
      user.team_for_game_week(18)
    end
  end

  test "team_for_game_week accepts convertible strings" do
    user = User.find(1)
    assert_equal 1, user.team_for_game_week("1").game_week.number
  end

  test 'opponents contains some game_week_teams' do
    user = User.find(1)
    assert_kind_of GameWeekTeam, user.opponents[0]
  end

  test "opponents doesn't contain any nil" do
    user = User.find(1)
    opponents = user.opponents
    nils = opponents.select do |game_week_team|
      game_week_team.nil?
    end
    assert nils.empty?
  end

  test 'can request user name' do
    user = User.find(1)
    assert_respond_to(user, :name)
  end

  test 'can request team name' do
    user = User.find(1)
    assert_respond_to(user, :team_name)
  end

  test 'can add user' do
    User.create!(name: 'Test User', team_name: 'Test Team Name', password: 'lollercats')
    last_entry = User.last
    assert_equal 'Test User', last_entry.name
  end

  test 'can find user' do
    user = User.where(name: 'Imran Wright').first
    assert_equal 'Imran Wright', user.name
  end

  test "can find user's team name" do
    user = User.where(name: 'Imran Wright').first
    assert_equal user.team_name, 'Destroyers'
  end

  test 'can not save without a team name' do
    user = User.new
    user.name = 'Andy Neilson'
    assert !user.save
  end

  test 'can not save without name' do
    user = User.new
    assert !user.save
  end

  test 'can not add user with empty name' do
    user = User.new
    user.name = ''
    assert !user.save
  end

  test 'can update user name' do
    new_name = 'Mike Spitz'
    user = User.find(1) # Mike Sharwood
    user.update!(name: new_name)
    assert_equal new_name, user.name
  end

  test 'can delete entry' do
    User.find(2).destroy # Imran
    assert_raise ActiveRecord::RecordNotFound do
      User.find(2)
    end
  end

  test 'User one has the correct number of gameweek teams' do
    user = User.find(1)
    assert_equal user.game_week_teams.length, 17, 'Incorrect number of gameweek teams for user one'
  end

  test 'User two has the correct number of gameweek teams' do
    user = User.find(2)
    assert_equal user.game_week_teams.length, USER_TWO_NO_GWTS, 'Incorrect number of gameweek teams for user two'
  end

  test 'We delete a user and all his gameweek teams are deleted' do
    user = User.find(1)
    user.destroy

    assertion = true
    season_length.times do |n|
      begin
        GameWeekTeam.find(n)
        assertion &&= false
      rescue ActiveRecord::RecordNotFound
        assertion &&= true
      end
    end

    assert assertion, 'ERROR: Found some of the gameweek teams, even when we deleted their user'
  end

  test 'Can get users total points' do
    skip("Revisit when we've chatted about points again")
    user = User.find(1)
    assert_equal USER_ONE_POINTS, user.points, 'Failed to get total team points'
  end

  test 'username must be unique' do
    user = User.new
    user.name = 'Imran Wright'
    assert !user.save
  end
end
