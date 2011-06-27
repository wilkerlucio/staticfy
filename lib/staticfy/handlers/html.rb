# Copyright (c) 2011 Wilker Lúcio
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

module Staticfy
  module Handlers
    class HTML < Base
      def fetch_links
        return [] unless doc

        links = []

        # follow links
        doc.search("//a[@href]").each do |a|
          u = a['href']
          next if u.nil? or u.empty?
          abs = to_absolute(URI(u)) rescue next
          links << abs if in_domain?(abs)
        end

        # fetch scripts
        doc.search("//script[@src]").each do |s|
          src = s["src"]
          next if src.nil? or src.empty?
          abs = to_absolute(URI(src)) rescue next
          links << abs if in_domain?(abs)
        end

        # follow styles
        doc.search("//link[@href]").each do |a|
          u = a['href']
          next if u.nil? or u.empty?
          abs = to_absolute(URI(u)) rescue next
          links << abs if in_domain?(abs)
        end

        links.uniq!
        links
      end

      def local_body
        body
      end
    end
  end
end
