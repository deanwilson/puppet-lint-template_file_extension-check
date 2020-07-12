PuppetLint.new_check(:template_file_extension) do
  def check
    template_extensions = {
      epp:      '.epp',
      template: '.erb',
    }

    resource_indexes.each do |resource|
      next unless resource[:type].value == 'file'

      param_tokens = resource[:param_tokens].select { |pt| pt.value == 'content' }

      param_tokens.each do |content_token|
        value_token = content_token.next_code_token.next_code_token

        if (matched = value_token.value.match(/^(template|epp)$/))
          template_function = matched[1]
          extension = template_extensions[template_function.to_sym]

          current_token = value_token.next_token
          current_token = current_token.next_token while current_token.type == :WHITESPACE

          # iterate over all the code tokens until we hit the closing ')'
          until current_token.type == :RPAREN || current_token.type == :LBRACE
            current_token = current_token.next_code_token

            if current_token.type == :SSTRING && !current_token.value.end_with?(extension)

              warning = "all #{template_function} file names should end with #{extension}"

              notify :warning, {
                message:     warning,
                line:        value_token.line,
                column:      value_token.column,
                param_token: content_token,
                value_token: value_token,
              }
            end
          end
        end
      end
    end
  end
end
