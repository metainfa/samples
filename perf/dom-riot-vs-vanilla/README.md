# Riot perf test

This is a test to see how execution time changes as the number of DOM elements increases. It uses the Flickr API to populate an ever-growing list.

Based on the **React** perf test as described bellow:
![The perf test](https://aerotwist.com/static/blog/react-plus-performance-equals-what/demo-site.jpg)

There are two versions of the test:

1. Riot-based
2. Vanilla / no-framework

## Build

In order to build the `app.js` file you will need the Riot pre-compiler to compile your `.tag` files into JavaScript.

After compiling your `app.tag` to `app.js`, just update it at the `build` folder and re-run the test.

**This was originally a React test. This port was made to check how Riot would perform over the same task.**
