resource "aws_kms_key" "ph-kmscmk-s3" {
  description              = "Key for ph s3"
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  enable_key_rotation      = "true"
  tags = {
    Name = "ph-kmscmk-s3"
  }
  policy = <<EOF
{
  "Id": "ph-kmskeypolicy-s3",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Enable IAM User Permissions",
      "Effect": "Allow",
      "Principal": {
        "AWS": "${data.aws_iam_user.ph-kmsmanager.arn}"
      },
      "Action": "kms:*",
      "Resource": "*"
    },
    {
      "Sid": "Allow Lightsail Encrypt",
      "Effect": "Allow",
      "Principal": {
        "AWS": "${aws_iam_role.ph-instance-iam-role.arn}"
      },
      "Action": [
        "kms:Encrypt",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:DescribeKey"
      ],
      "Resource": "*",
      "Condition": {
        "StringEquals": {
          "kms:CallerAccount": "${data.aws_caller_identity.ph-aws-account.account_id}",
          "kms:ViaService": "ssm.${var.aws_region}.amazonaws.com"
        }
      }
    },
    {
      "Sid": "Allow access through S3",
      "Effect": "Allow",
      "Principal": {
        "AWS": "${aws_iam_role.ph-instance-iam-role.arn}"
      },
      "Action": [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:DescribeKey"
      ],
      "Resource": "*",
      "Condition": {
        "StringEquals": {
          "kms:CallerAccount": "${data.aws_caller_identity.ph-aws-account.account_id}",
          "kms:ViaService": "s3.${var.aws_region}.amazonaws.com"
        }
      }
    }
  ]
}
EOF
}

resource "aws_kms_alias" "ph-kmscmk-s3-alias" {
  name          = "alias/${var.name_prefix}-ph-ksmcmk-s3"
  target_key_id = aws_kms_key.ph-kmscmk-s3.key_id
}

resource "aws_kms_key" "ph-kmscmk-ssm" {
  description              = "Key for ph ssm"
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  enable_key_rotation      = "true"
  tags = {
    Name = "ph-kmscmk-ssm"
  }
  policy = <<EOF
{
  "Id": "ph-kmskeypolicy-ssm",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Enable IAM User Permissions",
      "Effect": "Allow",
      "Principal": {
        "AWS": "${data.aws_iam_user.ph-kmsmanager.arn}"
      },
      "Action": "kms:*",
      "Resource": "*"
    },
    {
      "Sid": "Allow access through Lightsail",
      "Effect": "Allow",
      "Principal": {
        "AWS": "${aws_iam_role.ph-instance-iam-role.arn}"
      },
      "Action": "kms:Decrypt",
      "Resource": "*",
      "Condition": {
        "StringEquals": {
          "kms:CallerAccount": "${data.aws_caller_identity.ph-aws-account.account_id}",
          "kms:ViaService": "ssm.${var.aws_region}.amazonaws.com"
        }
      }
    }
  ]
}
EOF
}

resource "aws_kms_alias" "ph-kmscmk-ssm-alias" {
  name          = "alias/${var.name_prefix}-ph-ksmcmk-ssm"
  target_key_id = aws_kms_key.ph-kmscmk-ssm.key_id
}
