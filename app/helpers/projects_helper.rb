module ProjectsHelper

  def pledging_duration(project)
    if project.expired?
      content_tag(:strong, 'All Done!')
    else
      distance_of_time_in_words(Date.today, project.pledging_ends_on)
    end
  end

  def image_for(project)
    if project.image_file_name.blank?
      image_tag('placeholder.png')
    else
      image_tag(project.image_file_name)
    end
  end

  def pledge_link_for(project)
    if project.funded?
      content_tag(:strong, 'Funded!')
    else
      hint = content_tag(:span, "Only #{number_to_currency(project.amount_outstanding)} left!")
      link_to "Pledge! #{hint}".html_safe, new_project_pledge_path(project)
    end
  end
end
