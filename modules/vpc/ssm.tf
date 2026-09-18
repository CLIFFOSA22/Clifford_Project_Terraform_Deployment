# =========================
# SSM PARAMETERS
# =========================

locals {
  ssm_parameters = {

    vpc_id = {
      name  = "/metroCliff/vpc/id"
      value = aws_vpc.customer_vpc_Cliff.id
    }

    subnet1_id = {
      name  = "/metroCliff/subnet-1/id"
      value = aws_subnet.subnet_1.id
    }

    subnet2_id = {
      name  = "/metroCliff/subnet-2/id"
      value = aws_subnet.subnet_2.id
    }

    subnet3_id = {
      name  = "/metroCliff/subnet-3/id"
      value = aws_subnet.subnet_3.id
    }

    subnet4_id = {
      name  = "/metroCliff/subnet-4/id"
      value = aws_subnet.subnet_4.id
    }

    alb_sg_id = {
      name  = "/metroCliff/alb/sg/id"
      value = aws_security_group.albSG.id
    }

    ec2_sg_id = {
      name  = "/metroCliff/ec2/sg/id"
      value = aws_security_group.ec2SG.id
    }
  }
}

# =========================
# CREATE SSM PARAMETERS
# =========================

resource "aws_ssm_parameter" "customVPCSsm" {
  for_each = local.ssm_parameters

  name  = each.value.name
  type  = "String"
  value = each.value.value

  tags = {
    Name = each.key
  }
}