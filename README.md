# DockerAPPwithAWS+TF

## Descrição

O objetivo deste projeto e criar a infraestrutura em cloud AWS para rodar uma aplicação com frontend e backend hipotética. No frontend ira rodar uma instância de imagem docker e no backend 2 instâncias de imagem docker.

##### Recursos utilizados AWS

- Route 53
- Application Load Balancer
- Fargate
- ECR
- VPC (Novas Subnets)

##### Build das Aplicações backend e frontend

Para o build das imagens de backend e frontend foi utilizado o Azure DevOps

##### Terraform

Foi desenvolvido o terraform utilizando o conceito de modularização, e para controle de ambientes foi utilizado o conceito de Workspace.

Estrutura da solução:

├── backend.tf
├── environments
│   ├── develop.json
│   └── production.json
├── modules
│   ├── ec2
│   │   ├── alb_tg.tf
│   │   ├── output.tf
│   │   ├── sg-a.tf
│   │   └── vars.tf
│   ├── ecs
│   │   ├── cl_watch_logs.tf
│   │   ├── cluster.tf
│   │   ├── ecs_exec_role.tf
│   │   ├── service.tf
│   │   ├── task_def.tf
│   │   ├── task_def_back.json
│   │   ├── task_def_front.json
│   │   └── vars.tf
│   ├── route53
│   │   ├── route53.tf
│   │   └── vars.tf
│   └── vpc
│       ├── main.tf
│       ├── output.tf
│       └── vars.tf
└── modules.tf

Para deploy da infra utilizando o terraform, foi orquestrado através do Azure DevOps.

## Roadmap

Uma alternativa futura a considerar seria o uso do serviço de CDN Cloudfront da AWS para hospedar a aplicação de frontend, com isso a aplicação terá ganhos como menor latência de acordo com a origem da requisição, conteúdo distrbuído geograficamente com possibilidade de cache gerando respostas mais rápidas para as solicitações entre outras vantagens.

