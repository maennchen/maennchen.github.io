---
layout: post
title:  A simple Symfony Service to Upload Files to Amazon S3
date:   2015-05-30 11:30:30
categories: php symfony2 amazon s3 service
description: How to implement a simple Syomfony2 Service to upload Files to S3.
---

How to implement a simple Syomfony2 Service to upload Files to S3.

# Install the Amazon SDK
Execute the following Statement:
<script src="https://gist.github.com/maennchen/b075407e1f4f722278f4.js?file=console.sh"></script>

# Create a Service Class
<script src="https://gist.github.com/maennchen/b075407e1f4f722278f4.js?file=AmazonS3Service.php"></script>

# Parameters Config
Add the following lines to your parameters.yml file or set them by settig [environement variables](http://symfony.com/doc/current/cookbook/configuration/external_parameters.html).

<script src="https://gist.github.com/maennchen/b075407e1f4f722278f4.js?file=parameters.yml"></script>

# Create a Service Configuration
For every Bucket you're using, create one Service Config.

<script src="https://gist.github.com/maennchen/b075407e1f4f722278f4.js?file=services.yml"></script>

# Usage
<script src="https://gist.github.com/maennchen/b075407e1f4f722278f4.js?file=usage.php"></script>
