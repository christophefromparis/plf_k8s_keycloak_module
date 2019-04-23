# --- We create the secret with the realm configuration ---
resource "kubernetes_secret" "k8s-realm" {
  "metadata" {
    name      = "k8s-realm"
    namespace = "${var.global_ns}"
  }
  data {
    k8s-realm.json = "${file("${path.module}/files/k8s-realm.json")}"
  }
  type = "Generic"
}

# ---  We prepare the keycloak-values.yaml ---
data "template_file" "keycloak-values" {
  template = "${file("${path.module}/files/keycloak-values.yaml")}"

  vars {
    keycloak_host = "keycloak.${var.fqdn_suffix}"
  }
}

# --- We install Keycloak ---
resource "helm_release" "keycloak" {
  name      = "keycloak"
  chart     = "stable/keycloak"
  version   = "${lookup(var.helm_version, "keycloak")}"
  namespace = "${var.global_ns}"
  timeout   = 600

  values = [
    "${data.template_file.keycloak-values.rendered}"
  ]

  set {
    name  = "keycloak.username"
    value = "${var.keycloak_username}"
  }

  set {
    name  = "keycloak.password"
    value = "${var.keycloak_password}"
  }
}