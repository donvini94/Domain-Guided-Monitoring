# Usage:
# make install			# downloads miniconda and initializes conda environment
# make install_mimic	# downloads required mimic files from physionet (physionet credentialed account required)
# make server	  		# starts mlflow server at port 5000
# make run  			# executes main.py within the conda environment \
				  			example: make run ARGS="--experimentconfig_sequence_type huawei_logs"
# make run_huawei		# executes main.py within the conda environment for all knowledge types on huawei dataset

CONDA_ENV_NAME = lena
CONDA_URL = https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
CONDA_SH = Miniconda3-latest-Linux-x86_64.sh
<<<<<<< HEAD
CONDA_DIR = /home/vincenzo/anaconda3

DATA_DIR = data
KNOWLEDGE_TYPES = simple gram
=======
CONDA_DIR = ~/miniconda3

DATA_DIR = data
KNOWLEDGE_TYPES = simple simple simple simple simple gram simple gram
COLUMN_NAME = fine_log_cluster_template coarse_log_cluster_template medium_log_cluster_template
>>>>>>> ab2c50a (long loop for overnight experiments)

install:
ifneq (,$(wildcard ${CONDA_DIR}))
	@echo "Remove old install files"
	@rm -Rf ${CONDA_DIR}
endif
	@echo "Downloading miniconda..."
	@mkdir ${CONDA_DIR}
	@cd .tmp && wget -nc ${CONDA_URL} > /dev/null
	@chmod +x ./${CONDA_DIR}/${CONDA_SH}
	@./${CONDA_DIR}/${CONDA_SH} -b -u -p ./${CONDA_DIR}/miniconda3/ > /dev/null
	@echo "Initializing conda environment..."
	@./${CONDA_DIR}/miniconda3/bin/conda env create -q --force -f environment.yml > /dev/null
	@echo "Finished!"

server:
	@echo "Starting MLFlow UI at port 5000"
	PATH="${PATH}:$(shell pwd)/${CONDA_DIR}/miniconda3/envs/${CONDA_ENV_NAME}/bin" ; \
	${CONDA_DIR}/envs/${CONDA_ENV_NAME}/bin/mlflow server --gunicorn-opts -t180

notebook:
	@echo "Starting Jupyter Notebook at port 8888"
	PATH="${PATH}:$(shell pwd)/${CONDA_DIR}/miniconda3/envs/${CONDA_ENV_NAME}/bin" ; \
	${CONDA_DIR}/envs/${CONDA_ENV_NAME}/bin/jupyter notebook notebooks/ --no-browser 

run: 
	./${CONDA_DIR}/miniconda3/envs/${CONDA_ENV_NAME}/bin/python main.py ${ARGS}

run_huawei:
	for knowledge_type in ${KNOWLEDGE_TYPES} ; do \
		echo "Starting experiment for huawei_logs with knowledge type " $$knowledge_type "....." ; \
<<<<<<< HEAD
		${CONDA_DIR}/envs/${CONDA_ENV_NAME}/bin/python main.py \
			--experimentconfig_model_type $$knowledge_type \
			--huaweipreprocessorconfig_min_causality 0.01 \
			--huaweipreprocessorconfig_relevant_log_column attention_log_cluster_template \
			--no-modelconfig_base_feature_embeddings_trainable \
			--no-modelconfig_base_hidden_embeddings_trainable \
		  --sequenceconfig_x_sequence_column_name fine_log_cluster_template \
		  --sequenceconfig_y_sequence_column_name attributes \
		  --sequenceconfig_max_window_size 10 \
		  --sequenceconfig_min_window_size 10 \
			--experimentconfig_multilabel_classification \
			--sequenceconfig_flatten_y \
			--sequenceconfig_flatten_x \
			${ARGS} ; \
	done ; \



run_attention:
	for knowledge_type in ${KNOWLEDGE_TYPES} ; do \
		echo "Starting experiment for huawei_logs with knowledge type " $$knowledge_type "....." ; \
		${CONDA_DIR}/envs/${CONDA_ENV_NAME}/bin/python main.py \
			--experimentconfig_model_type $$knowledge_type \
			--huaweipreprocessorconfig_min_causality 0.01 \
			--huaweipreprocessorconfig_relevant_log_column log_cluster_template\
			--no-modelconfig_base_feature_embeddings_trainable \
			--no-modelconfig_base_hidden_embeddings_trainable \
			--sequenceconfig_x_sequence_column_name log_cluster_template\
			--textualpapermodelconfig_num_filters 100 \
			--sequenceconfig_y_sequence_column_name attributes \
			--sequenceconfig_max_window_size 10 \
			--sequenceconfig_min_window_size 10 \
			--experimentconfig_multilabel_classification \
			--sequenceconfig_flatten_y \
			--sequenceconfig_flatten_x \
=======
		for col_name in ${COLUMN_NAME} ; do \
			${CONDA_DIR}/envs/${CONDA_ENV_NAME}/bin/python main.py \
				--experimentconfig_sequence_type huawei_logs \
				--experimentconfig_model_type $$knowledge_type \
				--huaweipreprocessorconfig_min_causality 0.01 \
				--experimentconfig_batch_size 128 \
				--sequenceconfig_y_sequence_column_name attributes \
				--sequenceconfig_x_sequence_column_name $$col_name \
				--huaweipreprocessorconfig_relevant_log_column $$col_name \
				--sequenceconfig_max_window_size 10 \
				--sequenceconfig_min_window_size 10 \
				--experimentconfig_multilabel_classification \
				--sequenceconfig_flatten_y \
				--modelconfig_rnn_type gru \
				--modelconfig_rnn_dim 200 \
				--modelconfig_embedding_dim 300 \
				--modelconfig_attention_dim 100 \
				${ARGS} ; \
		done ; \
	done ; \

run_attention:
	for knowledge_type in ${KNOWLEDGE_TYPES} ; do \
		echo "Starting experiment for huawei_logs with knowledge type " $$knowledge_type "....." ; \
		${CONDA_DIR}/envs/${CONDA_ENV_NAME}/bin/python main.py \
			--experimentconfig_sequence_type huawei_logs \
			--experimentconfig_model_type $$knowledge_type \
			--huaweipreprocessorconfig_min_causality 0.01 \
			--experimentconfig_batch_size 128 \
		        --sequenceconfig_y_sequence_column_name attributes \
		        --sequenceconfig_x_sequence_column_name attention_log_cluster_template_90 \
		        --sequenceconfig_max_window_size 10 \
		        --sequenceconfig_min_window_size 10 \
		        --no-modelconfig_base_hidden_embeddings_trainable \
	                --no-modelconfig_base_feature_embeddings_trainable \
			--experimentconfig_multilabel_classification \
			--sequenceconfig_flatten_y \
			--modelconfig_rnn_type gru \
			--modelconfig_rnn_dim 200 \
			--modelconfig_embedding_dim 300 \
			--modelconfig_attention_dim 100 \
>>>>>>> ab2c50a (long loop for overnight experiments)
			${ARGS} ; \
	done ; \


