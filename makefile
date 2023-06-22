WORKDIR=$(shell pwd)
APP_NAME=demo-app
create_helm_package:
	helm create ${APP_NAME}
	cp --force helm-template/values.yaml ${APP_NAME}/
	cp --force helm-template/deployment.yaml ${APP_NAME}/templates
	cp --force helm-template/ingress.yaml ${APP_NAME}/templates
	cp --force helm-template/service.yaml ${APP_NAME}/templates
	cp --force helm-template/cluster-issuer.yaml ${APP_NAME}/templates
	cp --force helm-template/registry-credential.yaml ${APP_NAME}/templates
	rm -rf ${APP_NAME}/templates/tests
	rm ${APP_NAME}/templates/_helpers.tpl ${APP_NAME}/templates/hpa.yaml \
	${APP_NAME}/templates/NOTES.txt ${APP_NAME}/templates/serviceaccount.yaml  
install_helm_package_dr:
	helm upgrade -i -n pacifico --create-namespace --dry-run --kubeconfig ${HOME}/.kube/kind ${APP_NAME} ./${APP_NAME}
install_helm_package:
	helm upgrade -i -n pacifico --create-namespace --kubeconfig ${HOME}/.kube/kind ${APP_NAME} ./${APP_NAME}