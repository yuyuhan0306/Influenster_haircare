# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: http://doc.scrapy.org/en/latest/topics/item-pipeline.html

from scrapy.exporters import CsvItemExporter
from influenster.items import InfluensterItem, ReviewItem

class WriteItemPipeline(object):

	def __init__(self, filename):
		self.filename = filename

	def open_spider(self, spider):
		self.csvfile = open(self.filename, 'wb')
		self.exporter = CsvItemExporter(self.csvfile)
		self.exporter.start_exporting()

	def close_spider(self, spider):
		self.exporter.finish_exporting()
		self.csvfile.close()

	def process_item(self, item, spider):
		self.exporter.export_item(item)
		return item


class WriteProduct(WriteItemPipeline):

	def __init__(self):
		super(self.__class__, self).__init__('influenster.csv')

	def process_item(self, item, spider):
		if isinstance(item, InfluensterItem):
			super(self.__class__, self).process_item(item, spider)
		else:
			return item


class WriteReviews(WriteItemPipeline):

	def __init__(self):
		super(self.__class__, self).__init__('reviews.csv')

	def process_item(self, item, spider):
		if isinstance(item, ReviewItem):
			super(self.__class__, self).process_item(item, spider)
		else:
			return item