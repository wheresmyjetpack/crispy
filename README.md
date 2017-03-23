# Crispy

Cripsy is a shopping-list builder, pantry logging service, and recipe-finder app all rolled into one. It is built on the Ruby on Rails framework, but leverages design patterns and programming paradigms not typically found in a vanilla RoR application.

## Features

Currently, Crispy is in 0.1.0 pre-release (development). Work is primarily focused on building out a maintainable and de-coupled backend, which will allow for robust and continuous feature development. Contributions are welcome.

Current user-facing features are minimal:
- Create shopping lists, composed of item names and amounts
- Save and track items stored from shopping lists in your pantry

## Planned Features

### Search and Store Recipes
- Leverage an external REST API for querying a large store of recipes
- Save recipes for a user

### Consume Pantry Items When a Recipe is completed
- Subtract the appropriate amounts from a user's pantry based on the ingredients in a recipe
- Allow for ingredient substitutions in a recipe

### Fetch Detailed Ingredient Info
- Provide a way to present things like nutritional info, average costs, and expiration dates to users
- Allow users to search stored ingredients based on the additional info
- Alert users based on impending ingredient expiration

### Recipe Recommendations
- Recommend recipes to users based on the items stored in their pantries
- Allow a "by-ingredient" recipe search

### Ingredient Recommendations
- Recommend items to include in shopping lists to facilitate frequently used recipes

## Contribution Guidelines

Feel free to fork Crispy and open a pull request against the current release branch (v0.1.0-dev).
