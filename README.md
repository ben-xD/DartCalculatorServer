# Calculation code

The calculation code is written in `calculator_service.dart`, mainly `prefixCalculate` and `infixCalculate`.

# Running locally

I used Dart, you have probably never used it.

- Install dart: https://dart.dev/get-dart
- To run the examples provided in the `README.md`, run `dart run bin/examples.dart`
    - I avoided using recursion because the usage of stacks will prevent the solution from being `O(1)` space.
- To run the rest API server locally, run `dart run bin/server.dart`
- To test the HTTP/ Rest API, read below

# Trying the Rest API

Visit https://kheiron-calculator-5i6gsvkjla-nw.a.run.app or run it locally and visit `localhost:8080`

## Prefix Maths

- Pass `equation` query param, containing URL encoded string:
    - e.g. for `- / 10 + 1 1 * 1 2`, you can URL encode it into `-%20%2F%2010%20%2B%201%201%20%2A%201%202` using https://www.urlencoder.org/
    - **Visit:** https://kheiron-calculator-5i6gsvkjla-nw.a.run.app/calculator/prefix?equation=-%20%2F%2010%20%2B%201%201%20%2A%201%202

## Infix Maths

Same as prefix maths, just use `/infix` route instead.

- e.g. `( ( ( 1 + 1 ) / 10 ) - ( 1 * 2 ) )` encoded is `%28%20%28%20%28%201%20%2B%201%20%29%20%2F%2010%20%29%20-%20%28%201%20%2A%202%20%29%20%29`
- **Visit:** https://kheiron-calculator-5i6gsvkjla-nw.a.run.app/calculator/infix?equation=%28%20%28%20%28%201%20%2B%201%20%29%20%2F%2010%20%29%20-%20%28%201%20%2A%202%20%29%20%29

# Deployment

This is mainly for me.

## Deploying the container

- Set up `gcloud` cli
- `gcloud builds submit --tag gcr.io/carbon-footprint-2020/kheiron-calculator`(yes i used an old gcloud project I had to save time 😅)

- Redeploy cloud run container [here](https://console.cloud.google.com/run/detail/europe-west2/kheiron-calculator/revisions?project=carbon-footprint-2020).