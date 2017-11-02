PuppetLint.new_check(:template_file_extension) do
  def check

    template_extensions = {
      epp: '.epp',
      template: '.erb',
    }

    resource_indexes.each do |resource|
      if resource[:type].value == 'file'
        resource[:param_tokens].select { |param_token|
          param_token.value == 'content'
        }.each do |content_token|

          value_token = content_token.next_code_token.next_code_token

          if matched = value_token.value.match(/^(template|epp)$/)
            template_function = matched[1]
            extension = template_extensions[template_function.to_sym]

            # Collect all tokens until the closing ')'
            template_param_tokens = []
            current_token = value_token.next_token
            until current_token.type == :RPAREN
              template_param_tokens << current_token
              current_token = current_token.next_code_token
            end

            # EPP functions only accept one filename in the first position:
            tokens_to_check = if template_function == 'epp'
                                template_param_tokens[0..1]
                              else
                                template_param_tokens
                              end

            bad_tokens = tokens_to_check.select { |t| t.type == :SSTRING && !t.value.end_with?(extension) }

            if bad_tokens.size > 0
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
