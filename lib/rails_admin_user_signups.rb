require "rails_admin_user_signups/engine"

module RailsAdminUserSignups
end

require 'rails_admin/config/actions'

module RailsAdmin
  module Config
    module Actions
      class UserSignups < Base
        RailsAdmin::Config::Actions.register(self)
        
        register_instance_option :object_level do
          true
        end

        register_instance_option :link_icon do
          'icon-user'
        end

        register_instance_option :visible? do
          authorized?
        end

        register_instance_option :collection? do
          true
        end

        register_instance_option :member? do
          false
        end

        register_instance_option :pjax? do
          true
        end

        register_instance_option :http_methods do
          [:get, :post]
        end

        register_instance_option :route_fragment do
          'signups'
        end

        register_instance_option :breadcrumb_parent do
          parent_model = bindings[:abstract_model].try(:config).try(:parent)
          if am = parent_model && RailsAdmin.config(parent_model).try(:abstract_model)
            [:index, am]
          else
            [:dashboard]
          end
        end

        register_instance_option :controller do
          proc do
            @objects ||= list_entries

            unless @model_config.list.scopes.empty?
              if params[:scope].blank?
                unless @model_config.list.scopes.first.nil?
                  @objects = @objects.send(@model_config.list.scopes.first)
                end
              elsif @model_config.list.scopes.collect(&:to_s).include?(params[:scope])
                @objects = @objects.send(params[:scope].to_sym)
              end
            end

            respond_to do |format|

              format.html do
                render @action.template_name, status: (flash[:error].present? ? :not_found : 200)
              end

              # format.csv do
              #   header, encoding, output = CSVConverter.new(@objects, @schema).to_csv(params[:csv_options])
              #   if params[:send_data]
              #     send_data output,
              #               type: "text/csv; charset=#{encoding}; #{'header=present' if header}",
              #               disposition: "attachment; filename=#{params[:model_name]}_#{DateTime.now.strftime('%Y-%m-%d_%Hh%Mm%S')}.csv"
              #   else
              #     render text: output
              #   end
              # end

            end

          end
        end
      end
    end
  end
end

