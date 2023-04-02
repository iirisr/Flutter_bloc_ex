# products_ex

A Flutter project for products inventory

## Remarks
- This app was checked only on iPhone
- There are no validity checks for the input

## Structure
- The model contains the data structure and logic.
ProductResultItem contains the data recieved from the url
Product contains the data needed by the app
- The Repository contains products_net for fetching data from url. products_source will be used if there will be another way to fetch data, i.e. for testing (using hard coded data). The product_source is determined in the main.

## Instructions

The app has two screens ...
The first screen : 
 Displays a list of the products' categories(only one item per category). every item in the list is a card that consists of the name of the category, the thumbnail of the first item in the category, the total sum of different items in the category, and the total sum of the items in stock in the category.
When the user presses on one of the categories, the app navigates to the second screen.
The second screen is a list of all of the items in this category ... every item should show the products name, thumbnail, price and rating ... in the app bar you should create a sort button... when the sort button is pressed you should show a popup menu to sort items by price, rating, and discount percentage ... the sort is ascending from top to bottom. the default sort is by price.
upon swiping right on the item it should be removed from the list by animation...
If no more items left on the list there should be a centered text on the screen "No Items". All the logic and data fetching should be async... when doing a background work please display a Circular progress bar (in both screens).

Key Points :
The app should use some kind of state management.
It is preferable that:
- Use some kind of abstraction of the data sources.
- Use some kind dependency injection
- The code should be testable 

Bonus points :
 Create unit tests
 Emphasis on UI and UX

