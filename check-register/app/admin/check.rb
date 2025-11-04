ActiveAdmin.register Check do
  menu priority: 2, label: proc { t('active_admin.checks') }

  config.sort_order = 'created_at_desc'

  actions :index

  config.filters = false

  index do
    column :attachment_id
    column :price
    column :created_at
    actions
  end
end
