import logging

from flask import Flask, jsonify
from kubernetes import client, config
from prometheus_flask_exporter import PrometheusMetrics

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

app = Flask(__name__)
metrics = PrometheusMetrics(app)


@app.route('/welcome', methods=["GET"])
def welcome():
    return "Welcome to Barkuni Corp's EKS Cluster!"


@app.route('/pods', methods=['GET'])
def list_pods():
    config.load_incluster_config()
    v1 = client.CoreV1Api()
    logging.info("Listing pods...")
    try:
        pods = v1.list_namespaced_pod(namespace="kube-system")
        pod_names = [pod.metadata.name for pod in pods.items]
        return jsonify({"pods": pod_names})
    except client.rest.ApiException as e:
        logging.error(f"Exception when calling CoreV1Api->list_namespaced_pod: {e}")
        return jsonify({"error": f"Exception when calling CoreV1Api->list_namespaced_pod: {e}"}), 500


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000)
