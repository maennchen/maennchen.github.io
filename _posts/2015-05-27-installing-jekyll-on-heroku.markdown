---
layout: post
title:  Installing Jekyll 2.5 on Heroku
date:   2015-05-27 20:22:13
categories: jekyll heroku buildpack
description: This Article helps you to set up Jekyll 2.5 on Heroku.
---
Installing Jekyll 2.5 on Heroku isn't very dificult. You just have to find a working manual.

## Setup Jekyll
First follow this tutorial:
[How to deploy jekyll site to heroku](http://blog.bigbinary.com/2014/04/27/deploy-jekyll-to-heroku.html)

## Heroku
After that you can create a normal Heroku Ruby app without even using a custom buildpack.

<script src="https://gist.github.com/maennchen/0ebf128e841678b21a48.js?file=heroku.sh"></script>

## Fix fucked up buildpack
If you allready followed any of the popular tutorials, you'll have a custom buildpack set in Heroku. To reset the buildpack, run this command:

<script src="https://gist.github.com/maennchen/0ebf128e841678b21a48.js?file=fix.sh"></script>
