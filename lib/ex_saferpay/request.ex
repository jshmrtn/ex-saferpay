defmodule ExSaferpay.Request do
  @moduledoc """
  Request Model
  """

  @typedoc """
  * de - German
  * en - English
  * fr - French
  * da - Danish
  * cs - Czech
  * es - Spanish
  * hr - Croatian
  * it - Italian
  * hu - Hungarian
  * nl - Dutch
  * no - Norwegian
  * pl - Polish
  * pt - Portuguese
  * ru - Russian
  * ro - Romanian
  * sk - Slovak
  * sl - Slovenian
  * fi - Finnish
  * sv - Swedish
  * tr - Turkish
  * el - Greek
  * ja - Japanese
  * zh - Chinese
  """
  @type language :: :de |
    :en |
    :fr |
    :da |
    :cs |
    :es |
    :hr |
    :it |
    :hu |
    :nl |
    :no |
    :pl |
    :pt |
    :ru |
    :ro |
    :sk |
    :sl |
    :fi |
    :sv |
    :tr |
    :el |
    :ja |
    :zh
end
