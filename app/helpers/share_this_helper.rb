module ShareThisHelper

  def share_this_javascript_include
    "<script type='text/javascript' src='http://w.sharethis.com/button/sharethis.js#publisher=81fcfee2-503d-4740-9625-84fea115aec6&amp;type=website&amp;buttonText=Share&amp;post_services=orkut%2Cfacebook%2Ctwitter%2Cdelicious%2Cblogger%2Cdigg%2Cwordpress%2Cwindows_live%2Cmyspace%2Clinkedin%2Cgoogle_bmarks%2Cstumbleupon&amp;headerbg=%234c8542&amp;headerTitle=Share%20Bolongu!'></script>"
  end

  def share_this(title, url)
    "<script type=\"text/javascript\">
      SHARETHIS.addEntry({ 
        title: \"#{title}\",
        url: \"#{url}\"
      });
    </script>"
  end

#  def share_this(title, summary, content ,url)
#    "<script type=\"text/javascript\">
#      SHARETHIS.addEntry({ 
#        title: \"#{title}\",
#        summary: \"#{summary}\",
#        url: \"#{url}\",
#        content: \"#{content}\",
#        icon: \"http://#{SITE_URL}/images/logo_tiny.jpg\"
#      });
#    </script>"
#  end

end
