# Task Management Kubernetes Configuration

This repository contains the Kubernetes configurations for the Task Management application system. It follows the GitOps methodology for managing infrastructure as code.

## Repository Structure

```
├── base/                 # Base configurations
│   ├── api/             # Task Management API configurations
│   │   ├── deployment.yml
│   │   ├── service.yml
│   │   └── kustomization.yml
│   └── ui/              # Task Management UI configurations
│       ├── deployment.yml
│       ├── service.yml
│       └── kustomization.yml
├── overlays/            # Environment-specific configurations
│   ├── development/
│   │   ├── kustomization.yml
│   │   └── secrets.yml
│   ├── staging/
│   │   ├── kustomization.yml
│   │   └── secrets.yml
│   └── production/
│       ├── kustomization.yml
│       └── secrets.yml
└── README.md
```

## Related Repositories

- [task-management](https://github.com/jannegpriv/task-management) - Backend API
- [task-management-ui](https://github.com/jannegpriv/task-management-ui) - Frontend UI

## Environment Setup

### Prerequisites
- kubectl
- kustomize
- Access to Linode Kubernetes Engine (LKE)

### Deployment

1. Clone this repository:
   ```bash
   git clone https://github.com/jannegpriv/task-management-k8s.git
   cd task-management-k8s
   ```

2. Create necessary secrets:
   ```bash
   # Create a secret for development
   kubectl create namespace development
   kubectl apply -k overlays/development

   # Create a secret for production
   kubectl create namespace production
   kubectl apply -k overlays/production
   ```

## Secret Management

Secrets are managed separately for each environment. To create a new secret:

1. Encode your secret:
   ```bash
   echo -n "your-secret" | base64
   ```

2. Add to the appropriate environment's `secrets.yml`

Never commit actual secret values to the repository. The `secrets.yml` files should only contain templates or dummy values.

## GitOps

This repository is designed to work with GitOps tools. The recommended setup is:

1. ArgoCD for automated deployments
2. Sealed Secrets for encrypted secret management
3. Automated image updates via CI/CD pipelines

## Contributing

1. Create a feature branch
2. Make your changes
3. Test in development environment
4. Create a pull request

## Security

- All secrets must be base64 encoded
- Use sealed-secrets for production environments
- Regular security audits of configurations
- Principle of least privilege for RBAC
