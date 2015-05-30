---
layout: post
title:  A simple Symfony Service to Upload Files to Amazon S3
date:   2015-05-30 11:30:30
categories: php symfony2 amazon s3 service
description: How to implement a simple Syomfony2 Service to upload Files to S3.
---

How to implement a simple Syomfony2 Service to upload Files to S3.

# Install the Amazon SDK
Execute the folloeing Statement:
{% highlight bash %}
php composer.phar require "aws/aws-sdk-php"
{% endhighlight %}

# Create a Service Class
{% highlight php %}
<?php
namespace Acme\DemoBundle\Services;

use Aws\S3\S3Client;

/**
 * Class AmazonS3Service
 *
 * @package Acme\DemoBundle\Service
 */
class AmazonS3Service
{
    /**
     * @var S3Client
     */
    private $client;

    /**
     * @var string
     */
    private $bucket;

    /**
     * @param string $bucket
     * @param array  $s3arguments
     */
    public function __construct($bucket, array $s3arguments)
    {
        $this->setBucket($bucket);
        $this->setClient(new S3Client($s3arguments));
    }

    /**
     * @param string $fileName
     * @param string $content
     * @param array  $meta
     * @param string $privacy
     * @return string file url
     */
    public function upload( $fileName, $content, array $meta = [], $privacy = 'public-read')
    {
        return $this->getClient()->upload($this->getBucket(), $fileName, $content, $privacy, [
            'Metadata' => $meta
        ])->toArray()['ObjectURL'];
    }

    /**
     * @param string       $fileName
     * @param string|null  $newFilename
     * @param array        $meta
     * @param string       $privacy
     * @return string file url
     */
    public function uploadFile($fileName, $newFilename = null, array $meta = [], $privacy = 'public-read') {
        if(!$newFilename) {
            $newFilename = basename($fileName);
        }

        if(!isset($meta['contentType'])) {
            // Detect Mime Type
            $mimeTypeHandler = finfo_open(FILEINFO_MIME_TYPE);
            $meta['contentType'] = finfo_file($mimeTypeHandler, $fileName);
            finfo_close($mimeTypeHandler);
        }

        return $this->upload($newFilename, file_get_contents($fileName), $meta, $privacy);
    }

    /**
     * Getter of client
     *
     * @return S3Client
     */
    protected function getClient()
    {
        return $this->client;
    }

    /**
     * Setter of client
     *
     * @param S3Client $client
     *
     * @return $this
     */
    private function setClient(S3Client $client)
    {
        $this->client = $client;

        return $this;
    }

    /**
     * Getter of bucket
     *
     * @return string
     */
    protected function getBucket()
    {
        return $this->bucket;
    }

    /**
     * Setter of bucket
     *
     * @param string $bucket
     *
     * @return $this
     */
    private function setBucket($bucket)
    {
        $this->bucket = $bucket;

        return $this;
    }
}
{% endhighlight %}

# Parameters Config
Add the following lines to your parameters.yml file or set them by settig [environement variables](http://symfony.com/doc/current/cookbook/configuration/external_parameters.html).

{% highlight yaml %}
# This file is auto-generated during the composer install
parameters:
    ....
    amazon_key:
    amazon_secret: 
{% endhighlight %}

# Create a Service Configuration
For every Bucket you're using, create one Service Config.

{% highlight yaml %}
services:
    ....
    demo_storage:
      class: Acme\DemoBundle\Service\AmazonS3Service
      arguments:
        - "demo" # Name of Bucket
        - credentials:
            key:     "%amazon_key%"
            secret:  "%amazon_secret%"
            region:  "eu-central-1"    # Region of Bucket
            version: "2006-03-01"      # API Version
{% endhighlight %}

# Usage
{% highlight php %}
<?php
$storage = $this->getContainer()->get('demo_storage');

// Upload a file with the content "content text" and the MIME-Type text/plain
$storage->upload('test.txt', 'content text', ['contentType' => 'text/plain']);

// Upload a local existing File and let the service automatically detect the mime type.
$storage->uploadFile('file path' . 'demo.pdf');
{% endhighlight %}