module ShareThisHelper

  def share_this_javascript_include
    javascript_include_tag "http://w.sharethis.com/button/sharethis.js#publisher=81fcfee2-503d-4740-9625-84fea115aec6&amp;type=website&amp;buttonText=share&amp;send_services=email%2Csms%2Caim%2Cmyspace&amp;post_services=orkut%2Cfacebook%2Ctwitter%2Cblogger%2Cwordpress%2Cdigg%2Cgoogle_bmarks%2Cwindows_live%2Cdelicious%2Clinkedin%2Cybuzz%2Cstumbleupon%2Creddit%2Ctechnorati%2Cmixx%2Ctypepad%2Cmyspace%2Cfark%2Cbus_exchange%2Cpropeller%2Cnewsvine&amp;headerbg=%234D7B41&amp;linkfg=%23707070&amp;headerTitle=Bolongu!"
  end

  def share_this(title, url)
    "<script type=\"text/javascript\">
      SHARETHIS.addEntry({ title: \"#{title}\", url: \"#{url}\" });
    </script>"
  end

end
