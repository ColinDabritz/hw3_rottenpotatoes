Feature: display list of movies filtered by MPAA rating
 
  As a concerned parent
  So that I can quickly browse movies appropriate for my family
  I want to see movies matching only certain MPAA ratings

Background: movies have been added to database

  Given the following movies exist:
  | title                   | rating | release_date |
  | Aladdin                 | G      | 25-Nov-1992  |
  | The Terminator          | R      | 26-Oct-1984  |
  | When Harry Met Sally    | R      | 21-Jul-1989  |
  | The Help                | PG-13  | 10-Aug-2011  |
  | Chocolat                | PG-13  | 5-Jan-2001   |
  | Amelie                  | R      | 25-Apr-2001  |
  | 2001: A Space Odyssey   | G      | 6-Apr-1968   |
  | The Incredibles         | PG     | 5-Nov-2004   |
  | Raiders of the Lost Ark | PG     | 12-Jun-1981  |
  | Chicken Run             | G      | 21-Jun-2000  |

  And I am on the RottenPotatoes home page
  And I uncheck all ratings
  
Scenario: restrict to movies with 'PG' or 'R' ratings
  When I check the following ratings: PG, R
  Then I press "Refresh"
  Then I should not see "Aladdin"
   And I should not see "Chocolat"
   And I should see "The Incredibles"
   And I should see "The Terminator"
   And I should see "Amelie"

# TODO: Is each scenario a session?
Scenario: no ratings uses defaults
  When I am on the RottenPotatoes home page
  Then the "G" checkbox should be checked
   And the "PG" checkbox should be checked
   And the "PG-13" checkbox should be checked
   And the "R" checkbox should be checked
   And the "NC-17" checkbox should be checked
  Then I should see the following in order: "Aladdin, The Terminator, When Harry Met Sally, The Help, Chocolat, Amelie, 2001: A Space Odyssey, The Incredibles, Raiders of the Lost Ark, Chicken Run"

Scenario: no ratings selected uses previous ratings
  When I check the following ratings: PG, R
   And I press "Refresh"
  Then I uncheck the following ratings: PG, R
   And I press "Refresh"
  Then the "ratings_G" checkbox should not be checked
   And the "ratings_PG" checkbox should be checked
   And the "ratings_R" checkbox should be checked
   And the "ratings_PG-13" checkbox should not be checked
   And the "ratings_NC-17" checkbox should not be checked
  Then I should not see "Aladdin"
   And I should not see "Chocolat"
   And I should see "The Incredibles"
   And I should see "The Terminator"
   And I should see "Amelie"

Scenario: all ratings selected
  When I check all ratings
  Then I press "Refresh"
  Then the "ratings_G" checkbox should be checked
   And the "ratings_PG" checkbox should be checked
   And the "ratings_R" checkbox should be checked
   And the "ratings_PG-13" checkbox should be checked
  Then the "ratings_NC-17" checkbox should be checked
   And I should see "Aladdin"
   And I should see "Chocolat"
   And I should see "The Incredibles"
   And I should see "The Terminator"
   And I should see "Amelie"
