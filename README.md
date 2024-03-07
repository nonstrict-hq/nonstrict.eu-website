# The Nonstrict website

This mono-repo contains the Nonstrict website. The website consists of multiple "subwebsites" each in their own directory with their own build systems.

Go into the folders and read their readmes to learn how each part of the site is maintained.

## Setup

Run `./setup.sh` in the root to run setup for all subwebsites. This will install all dependencies. (Note projects will make assumptions for some dependencies, like Swift of Volta to be available.)

## Build

Run `./build.sh` in the root to build all subwebsites and integrate them together. The output in the `./dist` folder will be the website as it can be deployed to GitHub Pages.

## Deployment

A GitHub action will run the `./build.sh` command and publish the `./dist` folder on GitHub Pages automatically on each push to main.
