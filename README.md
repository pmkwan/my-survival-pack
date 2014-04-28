You are a survior of zombie apocalypse. You are moving from town-to-town collecting the most valuable items necessary for survival. You have backpack that can only hold a certain amount of weight and it is your job is to choose the best set of items based on their weight and value.

**Write a API in [Grape](https://github.com/intridea/grape) with an API endpoint called** <code>/v1/survival-pack</code>.

That API endpoint will be given the following data via a <code>POST</code> request:

* a set of survival items with a name and unique weight and value combination
* an overall weight restriction
* The endpoint can accept either a text file _OR_ a JSON data structure

It will produce an optimal set of survival items which:

* are within the total weight restriction
* maximize your chance of survival
* The response will always be in JSON

Requirements:

* use bundler - https://github.com/bundler/bundler
* include multiple high-level test cases to validate your solution (like the one included below)
* provide instructions in a README for submitting a survival pack to the API
* deploy it to [Heroku](https://id.heroku.com/login) or similar service
* The code must be readily available on GitHub or similar service

Input:

    max weight: 400

    available survival items:

    name    weight value
    ammo        9   150
    tuna       13    35
    water     153   200
    spam       50   160
    knife      15    60
    hammer     68    45
    rope       27    60
    saw        39    40
    towel      23    30
    rock       52    10
    seed       11    70
    blanket    32    30
    skewer     24    15
    dull-sword 48    10
    oil        73    40
    peanuts    42    70
    almonds    43    75
    wire       22    80
    popcorn     7    20
    rabbit     18    12
    beans       4    50
    laptop     30    10

Result:

    best value:

    name    weight value
    beans       4    50
    popcorn     7    20
    wire       22    80
    almonds    43    75
    peanuts    42    70
    seed       11    70
    rope       27    60
    knife      15    60
    spam       50   160
    water     153   200
    tuna       13    35
    ammo        9   150

Hint:

* read this - http://en.wikipedia.org/wiki/Knapsack_problem


Instructions to use the API:

You can use the API with a REST client such as the Chrome Advanced REST Client or run the curl command.

The service end point is <code>http://workr-test.herokuapp.com/v1/survival_pack</code>.  It's a POST request.

If you choose to use an input file, please use the form field 'fileUpload' to specify your input file.

To test the API with the curl command, please do either the following:

1) for JSON input, please make sure you have the keys "max_weight" and the "survival_items".  The survival_items values are specified within an array.

<code>curl -H  "Content-Type: application/json" http://workr-test.herokuapp.com/v1/survival_pack -d '{"survival_items":[{"name":"beans","weight":4,"value":10},{"name":"popcorn","weight":2,"value":4},{"name":"wire","weight":3,"value":7}], "max_weight":5}'</code>

or

2) for file input, please follow the files in the test_cases directory.  In the curl command, be sure to specify the file name using form field 'fileUpload'.

<code>curl -F fileUpload=@knapsack_input.txt http://workr-test.herokuapp.com/v1/survival_pack</code>

