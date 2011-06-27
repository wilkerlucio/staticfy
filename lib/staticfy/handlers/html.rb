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
        attribute_iterator(doc, "a", "href") do |abs, tag|
          links << abs
        end

        # fetch scripts
        attribute_iterator(doc, "script", "src") do |abs, tag|
          links << abs
        end

        # follow styles
        attribute_iterator(doc, "link", "href") do |abs, tag|
          links << abs
        end

        # images
        attribute_iterator(doc, "img", "src") do |abs, tag|
          links << abs
        end

        attribute_iterator(doc, "input", "src") do |abs, tag|
          links << abs
        end

        links.uniq!
        links
      end

      def local_body
        return body unless doc

        html = doc.dup

        update_links(html, "a", "href")
        update_links(html, "script", "src")
        update_links(html, "link", "href")
        update_links(html, "img", "src")
        update_links(html, "input", "src")

        html.to_s
      end

      def attribute_iterator(document, tag, attr)
        document.search("//#{tag}[@#{attr}]").each do |tag|
          a = tag[attr]
          next if a.nil? or a.empty?
          abs = to_absolute(URI(a)) rescue next
          if in_domain?(abs)
            yield abs, tag
          end
        end
      end

      def update_links(document, tag, attr)
        attribute_iterator(document, tag, attr) do |abs, tag|
          tag[attr] = Staticfy::Handlers.local_uri(abs)
        end
      end
    end
  end
end
