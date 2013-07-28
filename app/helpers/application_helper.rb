module ApplicationHelper
  def link_to_show(model)
    link_to t('.show', default: t('helpers.links.show')), model
  end

  def link_to_edit(path)
    link_to t('.edit', default: t("helpers.links.edit")), path
  end

  def link_to_new(path)
    link_to t('.new', default: t("helpers.links.new")), path
  end

  def link_to_destroy(model)
    link_to t('.destroy', default: t("helpers.links.destroy")), model,
        confirm: t('.confirm', default: t('helpers.messages.confirm',
            default: 'Are you sure?')), method: :delete
  end
end
