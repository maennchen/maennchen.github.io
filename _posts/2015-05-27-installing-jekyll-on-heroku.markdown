---
layout: post
title:  Installing Jekyll 2.5 on Heroku
date:   2015-05-27 20:22:13
categories: jekyll heroku buildpack
---
Installing Jekyll 2.5 on Heroku isn't very dificult. You just have to find a working manual.

## Setup Jekyll
First follow this tutorial:
[How to deploy jekyll site to heroku](http://blog.bigbinary.com/2014/04/27/deploy-jekyll-to-heroku.html)

## Heroku
After that you can create a normal Heroku Ruby app without even using a custom buildpack.

{% highlight bash %}
heroku create
git push heroku master
{% endhighlight %}

## Fix fucked up buildpack
If you allready followed any of the popular tutorials, you'll have a custom buildpack set in Heroku. To reset the buildpack run this command:

{% highlight bash %}
heroku buildpacks:set https://github.com/heroku/heroku-buildpack-ruby.git
{% endhighlight %}