ActiveAdmin.register Check do
  menu priority: 2, label: proc { t('active_admin.checks') }

  config.sort_order = 'created_at_desc'

  actions :index, :approve

  config.filters = false

  index do
    column :attachment_id
    column :approved
    column :price
    column :created_at

    actions defaults: true do |check|
      item 'Одобрить', approve_admin_check_path(check), method: :post
    end
  end

  member_action :approve, method: :post do
    Checks::ApproveService.call(params[:id])

    redirect_to admin_checks_path, notice: 'Успешно одобрено'
  end
end
