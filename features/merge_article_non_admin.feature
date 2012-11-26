Feature: Merge Articles
  As a blog administrator
  In order to not have similar articles
  I want to be able to merge two articles together

  Background:
    Given the blog is set up
    And the following articles exist:
    | title       | author | body   | created_at          | user_id | published |
    | style       | admin  | 1      | 2012-11-22 10:16:00 | 1       | true      |
    | review      | admin  | 2      | 2012-11-22 10:16:00 | 1       | true      |
    | style savvy | poiyo  | 3      | 2012-11-22 10:16:00 | 2       | true      |

  Scenario: Log in as non-administrator
    Given I am logged into the admin panel as a contributor
    Then I should see "Welcome back, poiyo"
    
  Scenario: A non-admin cannot merge two articles
    Given I am logged into the admin panel as a contributor
    And I am on the all articles page
    Then I should see "savvy"
    When I follow "savvy"
    Then I should not see "Merge Articles"
