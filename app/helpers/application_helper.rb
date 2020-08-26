# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def submit_tag_or_cancel(name, options={})
    options = raw('javascript:history.go(-1);') if options.empty? 
    raw("#{link_to t(name), '#', :onclick => 'submit()'} #{'|'} #{link_to t('Cancel'), options, :class => 'cancel'}")
  end
  
  def link_to_with_selected(name, url_options={}, html_options={},  remote_option={}, action_option={}, &block)
    css_class = (!!block.call)? 'selected' :nil
    link_to name, url_options, html_options.merge(:class => css_class)
  end
  
end
