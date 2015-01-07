module Exceptions
  class NeedBindOrgError < StandardError; end
  class AlreadyBindOrgError < StandardError; end
  class AccessOtherOrgNotAllowedError < StandardError; end
end