---
layout: post
title:  How To communicate with an FTP Server from Symfony2
date:   2015-06-03 11:15:30
categories: php symfony2 ftp service
description: How To communicate with an FTP Server from Symfony2
---
## Composer
Add The following two dependencies to you composer.json:

{% highlight json %}
{
  ...
  "require": {
    ...
    "ext-ftp": "*",
    "ijanki/ftp-bundle": "^1.0"
    ...
  }
  ...
}
{% endhighlight %}

## Enable the Bundle
{% highlight php %}
<?php
// app/AppKernel.php

public function registerBundles()
{
  $bundles = array(
    // ...
    new Ijanki\Bundle\FtpBundle\IjankiFtpBundle(),
  );
}
{% endhighlight %}

## Register your Services
{% highlight yaml %}
# app/config/services.yml
services:
  acme.ftp:
    class: %ijanki_ftp.class%
    calls:
      - [connect, [ "%ftp_host%" ]]
      - [login, [ "%ftp_username%", "%ftp_password%" ]]
      - [pasv, [ 1 ]] # Only if you want passive mode
{% endhighlight %}

## Usage
You can use all ftp_* Methods from PHP like this:
{% highlight php %}
<?php
$ftp = $container->get('acme.ftp');
// Calls ftp_nlist in the background
$files = $ftp->nlist('.');
{% endhighlight %}

## Add Custom Methods
Change the config:

{% highlight yaml %}
# app/config/services.yml
services:
  acme.ftp:
    class: Acme\FtpBundle\Ftp # Change to your Class
    calls:
      - [connect, [ "%ftp_host%" ]]
      - [login, [ "%ftp_username%", "%ftp_password%" ]]
      - [pasv, [ 1 ]] # Only if you want passive mode
{% endhighlight %}

Extend the Class like this, add whatever you want.
{% highlight php %}
<?php
namespace Acme\FtpBundle;

use DateTime;
use Ijanki\Bundle\FtpBundle\Ftp as BaseFtp;

/**
 * Class Ftp
 *
 * @package Acme\FtpBundle
 */
class Ftp extends BaseFtp
{
  /**
   * @param string $file
   * @return string
   */
  public function getContent($file)
  {
    $tempFile = $this->getStream($file);
    $content = stream_get_contents($tempFile);
    fclose($tempFile);

    return $content;
  }

  /**
   * @param $file
   *
   * @return resource
   */
  public function getStream($file)
  {
    $tempFile = tmpfile();
    $this->fget($tempFile, $file, FTP_BINARY);
    rewind($tempFile);

    return $tempFile;
  }

  /**
   * @param string $file
   * @return DateTime
   */
  public function getModifiedTime($file)
  {
    $time = new DateTime();
    $timeStamp = $this->mdtm($file);
    if($timeStamp !== -1) {
      $time->setTimestamp($timeStamp);
    }
    return $time;
  }
}
{% endhighlight %}