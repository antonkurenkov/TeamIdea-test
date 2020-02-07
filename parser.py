"""
Задание можно выполнить на любом языке программирования.
Задача: Написать программу, которая на основании запроса данных с сайта 
http://www.cbr.ru/scripts/XML_daily.asp определит курс гонконского доллара 
к российскому рублю
"""

import requests
from bs4 import BeautifulSoup as bs

MAIN_LINK = 'http://www.cbr.ru/scripts/XML_daily.asp'
CURRENCY_CODE = 'R01200'
CURRENCY_NAME = 'HKD'


class Parser(object):

    def __init__(self, link):
        respose = requests.get(link).text
        self.tree = bs(respose, 'lxml')

    def collection(self, currency_code):
        return self.tree.find('valute', {'id': currency_code})

    def get_course(self, currency):
        divider = int(currency.find('nominal').text)
        course = float(currency.find('value').text.replace(',', '.'))
        return round(course/divider, 5)


def main():
    parser = Parser(MAIN_LINK)
    course = parser.get_course(parser.collection(CURRENCY_CODE))
    print(f'1 {CURRENCY_NAME} = {course} RUR')


if __name__ == '__main__':
    main()
