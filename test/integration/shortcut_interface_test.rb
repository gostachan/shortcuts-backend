require "test_helper"

class ShortcutInterface < ActionDispatch::IntegrationTest
  # fixtures :environments
  # def setup
  #   @user = users(:alice)
  #   log_in_as(@user)
  # end
end

class ShortcutInterfaceTest < ShortcutInterface
  # test "create action should respond with success status on valid request" do
  #   log_in_as(@user)
  #   # assert_difference("Shortcut.count", 1) do
  #   assert_no_difference("Shortcut.count") do
  #     post shortcuts_path, params: { shortcut_info: { command:        "valid command",
  #                                                     keybinding:     "valid keybinding",
  #                                                     when:           "valid when",
  #                                                     environment_id: 5 } }
  #   end
  #   assert_response :success
  # end

  # test "create action should respond with bad_request status on invalid request" do
  #   log_in_as(@user)
  #   assert_no_difference("Shortcut.count", 0) do
  #     post shortcuts_path, params: { shortcut_info: { command:        "",
  #                                                     keybinding:     "",
  #                                                     when:           "",
  #                                                     environment_id: 5 } }
  #   end
  #   assert_response :bad_request
  # end
end
