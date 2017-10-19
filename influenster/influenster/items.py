# -*- coding: utf-8 -*-

# Define here the models for your scraped items
#
# See documentation in:
# http://doc.scrapy.org/en/latest/topics/items.html

import scrapy
from scrapy import Item, Field


class InfluensterItem(Item):
	product_link = Field()
	rank = Field()
	product_name = Field()
	company = Field()
	overall_rating = Field()
	reviews_count = Field()
	highlights = Field()

class ReviewItem(Item):
	product_name = Field()
	author_name = Field()
	author_location = Field()
	profile = Field()
	star = Field()
	content = Field()
	date = Field()