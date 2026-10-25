# # frozen_string_literal: true

# # Use this setup block to configure all options available in SimpleForm.
# SimpleForm.setup do |config|
#   # Default class for buttons
#   config.button_class = 'button'

#   # Define the default class of the input wrapper of the boolean input.
#   config.boolean_label_class = 'checkbox'

#   # How the label text should be generated altogether with the required text.
#   config.label_text = ->(label, required, _explicit_label) { "#{label} #{required}" }

#   # Define the way to render check boxes / radio buttons with labels.
#   config.boolean_style = :inline

#   # You can wrap each item in a collection of radio/check boxes with a tag
#   config.item_wrapper_tag = :div

#   # Defines if the default input wrapper class should be included in radio
#   # collection wrappers.
#   config.include_default_input_wrapper_class = false

#   # CSS class to add for error notification helper.
#   config.error_notification_class = 'notification is-danger'

#   # Method used to tidy up errors. Specify any Rails Array method.
#   # :first lists the first message for each field.
#   # :to_sentence to list all errors for each field.
#   config.error_method = :to_sentence

#   # add validation classes to `input_field`
#   config.input_field_error_class = 'is-danger'
#   config.input_field_valid_class = 'is-success'

#   # vertical forms
#   #
#   # bulma vertical default_wrapper
#   config.wrappers :vertical_form, tag: 'div', class: 'field' do |b|
#     b.use :html5
#     b.use :placeholder
#     b.optional :maxlength
#     b.optional :minlength
#     b.optional :pattern
#     b.optional :min_max
#     b.optional :readonly
#     b.use :label, class: 'label'
#     b.use :input, class: 'input', wrap_with: { tag: 'div', class: 'control py-3' }, error_class: 'is-danger', valid_class: 'is-success'
#     b.use :full_error, wrap_with: { tag: 'div', class: 'help is-danger' }
#     b.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
#   end

#   config.wrappers :select_form, tag: 'div', class: 'field' do |b|
#     b.use :html5
#     b.use :placeholder
#     b.optional :pattern
#     b.optional :readonly
#     b.use :label, class: 'label'
#     b.wrapper tag: 'div', class: 'control' do |ba|
#       ba.use :input, wrap_with: { tag: 'div', class: 'select' }, error_class: 'is-danger', valid_class: 'is-success'
#     end
#     b.use :full_error, wrap_with: { tag: 'div', class: 'help is-danger' }
#     b.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
#   end

#   # The default wrapper to be used by the FormBuilder.
#   config.default_wrapper = :vertical_form

#    config.wrapper_mappings = {
#     select: :select_form
#   }
#   # Custom wrappers for input types. This should be a hash containing an input
#   # type as key and the wrapper that will be used for all inputs with specified type.
# end
