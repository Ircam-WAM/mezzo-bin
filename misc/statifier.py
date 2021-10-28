#!/usr/bin/python3

import os
from optparse import OptionParser
import shutil

class Statifier:

  def __init__(self, domain, languages):
    self.domain = domain
    self.languages = languages

  def wget(self, language, dir):
    command = 'wget -q --mirror -p --adjust-extension --header="Accept-Language: %s" -e robots=off --base=./ -k -P %s https://%s' % (language, dir, self.domain)
    print(command)
    os.system(command)

  def sed(self, dir, rule):
    command = "find %s -type f -print0 | xargs -0 sed -r -i -e '%s'" % (dir, rule)
    print(command)
    os.system(command)

  def fix_languages(self, dir, language):
    rule = 's,<form action="https://%s/i18n/" method="post" class="c-header__languages">,,g' % self.domain
    self.sed(dir, rule)

    rule = 's,<button class="c-header__language is-active" type="submit" name="language" value="%s">%s</button>,<a href="/%s/"><button class="c-header__language\" type="button" name="language" value="%s">\&nbsp\; %s \&nbsp\;</button></a>,g' \
      % (language, language.upper(), language, language, language.upper())
    self.sed(dir, rule)

    rule = 's,<button class="c-header__language" type="submit" name="language" value="%s">%s</button>,<a href="/%s/"><button class="c-header__language\" type="button" name="language" value="%s">\&nbsp\; %s \&nbsp\;</button></a>,g' \
      % (language, language.upper(), language, language, language.upper())
    self.sed(dir, rule)

    rule = 's,<button class="c-header__language is-active" type="submit" name="language" value="%s">%s</button></form>,<a href="/%s/"><button class="c-header__language\" type="button" name="language" value="%s">\&nbsp\; %s \&nbsp\;</button></a>,g' \
      % (language, language.upper(), language, language, language.upper())
    self.sed(dir, rule)

    rule = 's,<button class="c-header__language" type="submit" name="language" value="%s">%s</button></form>,<a href="/%s/"><button class="c-header__language\" type="button" name="language" value="%s">\&nbsp\; %s \&nbsp\;</button></a>,g' \
      % (language, language.upper(), language, language, language.upper())
    self.sed(dir, rule)

  def main(self):
    for language in self.languages:
      self.wget(language, self.domain)
      shutil.move(self.domain + os.sep + self.domain, self.domain + os.sep + language)

    for language in self.languages:
      self.fix_languages(self.domain, language)


def main():
  parser = OptionParser()
  parser.add_option("-d", "--domain", dest="domain", help="domain")
  parser.add_option("-l", "--languages",
                  dest="languages", nargs=2,
                  help="languages")
  (options, args) = parser.parse_args()

  s = Statifier(options.domain, options.languages)
  s.main()

if __name__ == "__main__":
  main()

