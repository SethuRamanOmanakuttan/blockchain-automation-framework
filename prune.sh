#!/bin/bash


echo "Clearing minikube data"
kubectl delete --all namespaces
kubectl delete storageclass --all
minikube stop
minikube delete --all --purge
kubectl delete --all namespaces
kubectl delete storageclass --all
rm -rf ~/.kube
rm -rf ~/.minikube

echo "Clearing Docker data"
docker system prune -a
docker builder prune -f
docker volume prune 

echo "Clearing Vault data"
rm -r ./vault/*

echo "Clearing BAF Data"
rm -r ./platforms/hyperledger-fabric/releases/*
cd ./build
shopt -s extglob  
rm -rf !(network.yaml)       
cd ..

echo "Clearing git  Cache"
git rm -r --cached .

echo "Copying git ssh privatekey"
cp ~/.ssh/gitops ./build/

echo "##### Cleared All Data ######"