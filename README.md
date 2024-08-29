# Barkuni Corp Flask Application

## Overview

Welcome to the Barkuni Corp Flask Application! This application is a Flask-based web service designed to showcase
various Kubernetes and AWS EKS features. The application includes the following capabilities:

- **Welcome Page**: Accessible via a custom domain using NGINX Ingress Controller.
- **API Endpoint**: Lists all running pods in the `kube-system` namespace.

## Prerequisites

Before you begin, ensure you have the following:

- **AWS EKS Cluster**: A working EKS cluster where the application will be deployed.
- **Helm**: The package manager for Kubernetes, used for managing the application's Helm chart.
- **kubectl**: The command-line tool for interacting with the Kubernetes cluster.

## Installation

### Step 1: Clone the Repository

First, clone the repository containing the application and Helm chart:

```bash
git clone https://github.com/your-repo/barkuni-corp.git
cd barkuni-corp
```

### Step 2: Install NGINX Ingress Controller

If you don't have an Ingress controller set up in your cluster, install the NGINX Ingress Controller:

```bash
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install nginx-ingress ingress-nginx/ingress-nginx
```

### Step 3: Install KEDA

Install KEDA to enable Horizontal Pod Autoscaling:

```bash
helm repo add kedacore https://kedacore.github.io/charts
helm repo update
helm install keda kedacore/keda
```

### Step 4: Deploy the Barkuni Corp Application

Now, deploy the application using Helm:

```bash
helm install barkuni-corp ./charts/barkuni-corp
```

### Step 5: Access the Application

After deployment, access the application via the custom domain specified in your Ingress configuration. If using a
default setup:

- The welcome page will be available at `http://test.vicarius.xyz`.
- The API endpoint to list pods can be accessed at `http://test.vicarius.xyz/api/pods`.

### Step 6: Verify Horizontal Pod Autoscaling

To verify that HPA is working as expected, you can generate CPU load and observe the scaling behavior:

```bash
kubectl get hpa -n barkuni
```
