module "cluster" {
    source = "brikis98/devops/book//modules/eks-cluster"
    version = "1.0.0"

    name = "eks-sample"
    eks_version = "1.36"

    instance_type = "t3.small"
    min_worker_nodes = 3
    max_worker_nodes = 10

    enable_eks_pod_identity_agent = true
}