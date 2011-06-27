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
    autoload :Base, "staticfy/handlers/base"
    autoload :HTML, "staticfy/handlers/html"
    autoload :CSS,  "staticfy/handlers/css"
    autoload :Raw,  "staticfy/handlers/raw"

    class << self
      KNOW_EXTENSIONS = [".htm", ".js", ".css", ".gif", ".jpg", ".jpeg", ".png", ".swf"]

      def factory(ext)
        ext_table = {
          ".css" => CSS
        }

        unless klass = ext_table[ext.to_s.downcase]
          klass = HTML
        end

        klass
      end

      def local_uri(uri)
        invalid_chars = /[*?\\\/=&]/

        current_ext = File.extname(uri.path)
        ext = KNOW_EXTENSIONS.include?(current_ext) ? current_ext : ".html"

        local = uri.path[1..-1]
        local = "index" unless local.length > 0

        if uri.query
          local += "?" + uri.query.to_s
          local += ext
        else
          local += ext unless current_ext == ext
        end

        local.gsub(invalid_chars, "_")
      end
    end
  end
end
