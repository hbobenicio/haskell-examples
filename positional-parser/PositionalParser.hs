module PositionalParser
( prepare
, consume
, finish
) where


type Field = String
type FieldList = [Field]
type ConsumeStream = (FieldList, String)

-- Just prepares the datastructure for line processing
prepare :: String -> ConsumeStream
prepare linha = ([], linha)

-- Consuming Logic:
--   1. Splits the line on determined position N
--   2. Appends it to the resulting list (at the head, yielding in a reversed list of fields!)
--   3. Returns the same datastructure for future processings through function composition
consume :: Int -> ConsumeStream -> ConsumeStream
consume n (fields, line) =
  let
    (field, consumedLine) = splitAt n line
  in
    (field : fields, consumedLine)

-- Finishes the parsing by reversing the reversed list got from consumption
-- Returns the fields list in the right order
finish :: ConsumeStream -> FieldList
finish (reversedFields, _) = reverse reversedFields
