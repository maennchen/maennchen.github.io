---
layout: post
title:  How To communicate with an FTP Server from Symfony2
date:   2015-06-03 11:15:30
categories: php symfony2 ftp service
description: How To communicate with an FTP Server from Symfony2
---
## Composer
Add The following two dependencies to you composer.json:

<script src="https://gist.github.com/maennchen/6f92fd5bc80156f15e0c.js?file=composer.json"></script>

## Enable the Bundle

<script src="https://gist.github.com/maennchen/6f92fd5bc80156f15e0c.js?file=AppKernel.php"></script>

## Register your Services

<script src="https://gist.github.com/maennchen/6f92fd5bc80156f15e0c.js?file=services.yml"></script>

## Usage
You can use all ftp_* Methods from PHP like this:

<script src="https://gist.github.com/maennchen/6f92fd5bc80156f15e0c.js?file=usage.php"></script>

## Add Custom Methods
Change the config:

<script src="https://gist.github.com/maennchen/6f92fd5bc80156f15e0c.js?file=services2.yml"></script>

Extend the Class like this, add whatever you want.

<script src="https://gist.github.com/maennchen/6f92fd5bc80156f15e0c.js?file=Ftp.php"></script>
