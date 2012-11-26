Feature: Merge Articles
  As a blog administrator
  In order to not have similar articles
  I want to be able to merge two articles together

  Background:
    Given the blog is set up
    And I am logged into the admin panel
    And the following articles exist:
    | title       | author | body   | created_at          | user_id | published |
    | style       | admin  | 1      | 2012-11-22 10:16:00 | 1       | true      |
    | review      | admin  | 2      | 2012-11-22 10:16:00 | 1       | true      |
    | style savvy | poiyo  | 3      | 2012-11-22 10:16:00 | 2       | true      |
    And the following comments exist:
    | title       | author      | body   | created_at          | article_id | published |
    | whoa        | commenter_1 | 1      | 2012-11-22 10:16:00 | 3          | true      |
    | review      | commenter_2 | 2      | 2012-11-22 10:16:00 | 4          | true      |
    | style savvy | commenter_3 | 3      | 2012-11-22 10:16:00 | 5          | true      |
    And I am on the all articles page
    When I follow "style"
    Then I should see "Merge Articles"
    When I fill in "merge_with" with "5"
    And I press "Merge"
    Then I should see "The article was merged successfully"
    And I should not see "style savvy"

  Scenario: When articles are merged, the merged article should contain the text of both previous articles
    Given I am on the all articles page
    When I follow "style"
    Then the "article__body_and_extended_editor" field should contain "13"

  Scenario: When articles are merged, the merged article should have one author (either one of the authors of the two original articles)
    Given I am on the all articles page
    Then the author for "style" should be "admin"

  Scenario: Comments on each of the two original articles need to all carry over and point to the new, merged article
    Given I am on the all articles page
    Then I should see "2"
    When I follow feedback for "style"
    Then I should see "commenter_1"
    And I should not see "commenter_2"
    And I should see "commenter_3"

  Scenario: The title of the new article should be the title from either one of the merged articles
    Given I am on the all articles page
    When I follow "style"
    Then the "article_title" field should contain "style"

  Scenario: The ID of the article to merge does not exist
    Given I am on the all articles page
    When I follow "review"
    And I fill in "merge_with" with "123"
    And I press "Merge"
    Then I should see "The target article does not exist"

  Scenario: The ID of the article to merge is the same as the article's
    Given I am on the all articles page
    When I follow "review"
    And I fill in "merge_with" with "4"
    And I press "Merge"
    Then I should see "Cannot merge article with itself"
