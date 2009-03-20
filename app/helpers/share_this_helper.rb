module ShareThisHelper

  def share_this_javascript_include
    javascript_include_tag "http://w.sharethis.com/button/sharethis.js#tabs=web%2Cpost%2Cemail&amp;charset=utf-8&amp;style=default&amp;publisher=81fcfee2-503d-4740-9625-84fea115aec6&amp;headerbg=%234c8542"
  end

  def share_this(title, url)
    "<script type=\"text/javascript\">
      SHARETHIS.addEntry({ title: \"#{title}\", url: \"#{url}\" });
    </script>"
  end

end
