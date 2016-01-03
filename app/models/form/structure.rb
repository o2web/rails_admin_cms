module Form
  class Structure < ActiveRecord::Base
    include Admin::Form::Structure

    self.table_name_prefix = 'form_'

    has_one :viewable, class_name: 'Viewable::Form'
    has_many :fields, -> { order(:position) }, dependent: :destroy
    has_many :rows, -> { order(:id) }, dependent: :destroy
    belongs_to :email, dependent: :destroy

    validates :fields, length: { maximum: RailsAdminCMS::Config.custom_form_max_size }

    after_create :create_header
    after_create :add_to_scopes
    before_destroy :remove_from_scopes
    after_update :expire_cache
    after_touch  :expire_cache

    accepts_nested_attributes_for :fields, allow_destroy: true
    accepts_nested_attributes_for :email

    delegate :form_name, to: :viewable
    delegate :with_email?, :send_to, :subject, :body, to: :email

    def name
      @_name ||= "#{form_name}_#{id}".to_sym
    end

    def email_column_key
      @email_column_key ||= fields.where(type: 'email').first.try(:column_key)
    end

    def header
      rows.first
    end

    private

    def create_header
      rows.create!
    end

    def expire_cache
      viewable.touch
    end

    module Splitter
      extend ActiveSupport::Concern

      included do
        class << self
          attr_accessor :scopes, :form_name
        end
        self.scopes = []
        self.includes(:viewable).each do |structure|
          current_id = structure.id
          current_name = "#{structure.viewable.form_name}_#{current_id}".to_sym
          ::Form::Row.define_singleton_method(current_name) do
            where(structure_id: current_id)
          end
          self.scopes << current_name
        end
      end

      private

      def add_to_scopes
        current_id = self.id
        ::Form::Row.define_singleton_method(name) do
          where(structure_id: current_id)
        end
        self.class.scopes << name
      end

      def remove_from_scopes
        current_name = "#{self.class.form_name}_#{id}".to_sym
        self.class.scopes.delete(current_name)
      end
    end

    include Splitter
  end
end
