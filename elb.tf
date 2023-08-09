resource "aws_lb" "test" {
  name               = "rke-k3s-nlb"
  internal           = false
  load_balancer_type = "network"
  subnets = [
    aws_subnet.subnet1-public.id,
    aws_subnet.subnet2-public.id,
    aws_subnet.subnet3-public.id
  ]
  enable_deletion_protection = false
}

resource "aws_lb_target_group" "test" {
  name     = "rke-k3s-tg"
  port     = 6443
  protocol = "TCP"
  vpc_id   = aws_vpc.default.id
}


resource "aws_lb_target_group_attachment" "server1" {
  target_group_arn = aws_lb_target_group.test.arn
  target_id        = aws_instance.master01.id
  port             = 6443
}

resource "aws_lb_target_group_attachment" "server2" {
  target_group_arn = aws_lb_target_group.test.arn
  target_id        = aws_instance.master02.id
  port             = 6443
}

resource "aws_lb_target_group_attachment" "server3" {
  target_group_arn = aws_lb_target_group.test.arn
  target_id        = aws_instance.master03.id
  port             = 6443
}

resource "aws_lb_listener" "front_end_http" {
  load_balancer_arn = aws_lb.test.arn
  port              = "6443"
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test.arn
  }
}