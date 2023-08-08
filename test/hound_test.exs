defmodule HoundTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session()

  test "the truth", _meta do
    navigate_to("http://example.com/guestbook.html")

    # element = find_element(:name, "message")
    # fill_field(element, "Happy Birthday ~!")
    # submit_element(element)

    assert current_url() == "http://example.com"
  end

end
