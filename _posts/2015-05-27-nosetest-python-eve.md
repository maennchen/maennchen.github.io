---
layout: post
title:  Do nosetests for pyhon-eve
date:   2015-05-27 22:19:30
categories: nosetest python eve flask
description: This little tutorial explains how to set up nosetests for python-eve.
---

This little tutorial explains how to set up nosetests for python-eve.

## Installation
{% highlight bash %}
echo nose >> dev-requirements.txt
pip install -r dev-requirements.txt
{% endhighlight %}

## Create a test-client
{% highlight python linenos %}
import json
from [yourRunFile] import app

class APIClient(object):
	def __init__(self):
		app.config['TESTING'] = True
		self.app = app.test_client()

	def request(self, url='/', method='GET', data=None, headers={}):
		if data != None:
			headers['Content-Type'] = 'application/json'
		response = self.app.open(url, method=method, data=json.dumps(data), headers=headers)
		response.parsed = json.loads(response.data)
		return response
{% endhighlight %}

## Example Test
tests/test_example.py
{% highlight python linenos %}
from unittest import TestCase
from client import APIClient
from run import app

class ExampleTestCase(TestCase):
	"""
	Test cases for the example endpoints.
	"""

	def setUp(self):
		self.client = APIClient()

	def test_add_example(self):
		"""
		Example => add => valid
		"""
		example = {
			'name': 'test'
		}
		response = self.client.request('/example', 'POST', example, {'Content-Type': 'application/json'})
		self.assertEqual(response.status, '201 CREATED')
		self.assertIn('_status', response.parsed)
		self.assertEqual(response.parsed['_status'], 'OK')

	def test_add_invalid_example(self):
		"""
		Example => add => invalid
		"""
		response = self.client.request('/clients', 'POST', {}, {'Content-Type': 'application/json'})
		self.assertEqual(response.status, '422 UNPROCESSABLE ENTITY')
		self.assertIn('_status', response.parsed)
		self.assertEqual(response.parsed['_status'], 'ERR')
{% endhighlight %}

## Run
{% highlight bash %}
nosetests
{% endhighlight %}
