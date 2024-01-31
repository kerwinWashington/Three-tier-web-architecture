# ### DynamoDB Table ###
# resource "aws_dynamodb_table" "basic-dynamodb-table" {
#   name           = "Team1-DynamoDB"
#   billing_mode   = "PROVISIONED"
#   read_capacity  = 1
#   write_capacity = 1
#   hash_key       = "title"
#   range_key      = "director"

#   attribute {
#     name = "title"
#     type = "S"
#   }

#   attribute {
#     name = "director"
#     type = "S"
#   }

#   ttl {
#     attribute_name = "TimeToExist"
#     enabled        = false
#   }

# #   global_secondary_index {
# #     name               = "GameTitleIndex"
# #     hash_key           = "GameTitle"
# #     range_key          = "TopScore"
# #     write_capacity     = 10
# #     read_capacity      = 10
# #     projection_type    = "INCLUDE"
# #     non_key_attributes = ["UserId"]
# #   }

#   tags = {
#     Name        = "Team1-dynamodb-table-1"
#   }
# }





