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

require "test_helper"

class StaticfyHandlersTest < Test::Unit::TestCase
  def test_factory_handler_html
    assert_equal Staticfy::Handlers::HTML, Staticfy::Handlers.factory(".html")
  end

  def test_factory_handler_css
    assert_equal Staticfy::Handlers::CSS, Staticfy::Handlers.factory(".css")
  end

  def test_factory_handler_other
    assert_equal Staticfy::Handlers::Raw, Staticfy::Handlers.factory(".other")
  end

  def test_local_uri_replace_invalid_chars
    uri = URI.parse("http://example.com/some/place/here.html")

    assert_equal "some_place_here.html", Staticfy::Handlers.local_uri(uri)
  end

  def test_local_uri_append_querystring_and_extension
    uri = URI.parse("http://example.com/some/place/here?with=query&and=data")

    assert_equal "some_place_here_with_query_and_data.html", Staticfy::Handlers.local_uri(uri)
  end

  def test_local_uri_use_index_if_root
    uri = URI.parse("http://example.com/")

    assert_equal "index.html", Staticfy::Handlers.local_uri(uri)
  end

  def test_local_uri_add_html_for_unknow_extensions
    uri = URI.parse("http://example.com/page.php")

    assert_equal "page.php.html", Staticfy::Handlers.local_uri(uri)
  end

  def test_local_uri_preserve_know_extension_in_with_query_data
    uri = URI.parse("http://example.com/some/place/here.png?with=query&and=data")

    assert_equal "some_place_here.png_with_query_and_data.png", Staticfy::Handlers.local_uri(uri)
  end
end
