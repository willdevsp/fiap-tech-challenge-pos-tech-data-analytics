import streamlit as st
import pandas as pd
import numpy as np
import xgboost as xgb
from datetime import datetime, timedelta
import plotly.express as px
import plotly.graph_objects as go

from App import gerar_menu_lateral  # Importar a função do menu lateral


hide_default_sidebar = """
<style>
    /* Oculta o menu lateral padrão do Streamlit */
    div[data-testid="stSidebarNav"] {display: none;}

    /* Ajusta o espaçamento da barra lateral */
    section[data-testid="stSidebar"] {
        top: 0px !important;
        height: 100vh !important;
        display: flex;
        flex-direction: column;
        justify-content: flex-start;
        padding-top: 0px !important;
    }

    /* Remove margens extras e sobe o conteúdo do sidebar */
    div[data-testid="stSidebarContent"] {
        margin-top: 0px !important;
        padding-top: 0px !important;
    }
</style>
"""
st.markdown(hide_default_sidebar, unsafe_allow_html=True)

# Chamar a função do menu lateral
gerar_menu_lateral()



st.title('🤖 Machine Learning')
tab1,tab2 = st.tabs(["Criação do modelo","Prever"])
with tab1:

    st.header('Modelo de previsão do preço do petróleo brent')

    st.subheader('Introdução')

    st.markdown('''Para realizar a previsão do preço do petróleo Brent, utilizamos a combinação de dados históricos do **IPEADATA** e do **Yahoo Finance**. Essa abordagem nos permite gerar previsões mais confiáveis dos preços futuros. ''')

    st.subheader('1. Importação de bibliotecas ')

    st.write('A primeira etapa foi a importação das bibliotecas necessárias para o projeto. Cada uma desempenha um papel específico no tratamento de dados, modelagem e visualização. ')

    st.image(image="images\Captura de tela 2025-02-15 152051.png")

    st.image(image="images\Captura de tela 2025-02-15 152233.png")

    st.subheader('2. Coleta e preparação de dados')

    st.markdown('''Realizamos o carregamento dos dados históricos do **IPEADATA**. A partir da última data registrada, complementamos com os dados mais recentes do **Yahoo Finance**. Isso garante um conjunto de dados atualizado e confiável. Criamos uma classe chamada `ForecastPetroleo()` para agrupar todas as funções necessárias. Ao inicializar essa classe, os dados já são automaticamente carregados e organizados. ''')

    st.image(image="images\Captura de tela 2025-02-15 152341.png")

    st.markdown('''Para baixar os dados do **Yahoo Finance**, utilizamos a função `download_yahoo_finance()`, que retorna um `DataFrame(df_yf)` pronto para uso. ''')

    st.image(image="images\Captura de tela 2025-02-15 152355.png")

    st.markdown(
    """
    Além disso, desenvolvemos a função `create_features()`, responsável por organizar 
    os dados brutos e transformá-los em variáveis úteis, como:

    - Conversão de datas;
    - Normalização de colunas;
    - Criação de variáveis temporais (*ano, mês, dia da semana, etc.*).
    """,
    unsafe_allow_html=True
)
    
    st.image(image="images\Captura de tela 2025-02-15 152441.png")

    st.subheader('3. Treinando o modelo XGBoost')

    st.markdown(
        """
        Agora que os dados estão prontos, criamos uma cópia para garantir que o conjunto original permaneça intacto para futuras análises. Nessa cópia, realizamos as seguintes etapas: 
        - Ordenamos os dados por data;
        - Definimos as colunas que serão usadas como **features**;
        - Escolhemos a coluna **target**;
        - Dividimos os dados em treino e teste.
        """,
        unsafe_allow_html=True)
   
    st.image(image="images\Captura de tela 2025-02-15 152508.png")

    st.markdown(
        """
        Utilizamos o **XGBoost**, um dos algoritmos mais eficientes para previsão de séries temporais. O processo de treinamento segue esta lógica: 
        - **Treino**→ O modelo aprende a partir dos padrões dos dados históricos.
        - **Teste** → O modelo tenta prever novos dados e verificamos sua precisão.
   
        Para treinar, usamos a função `train_model()`, onde instanciamos o modelo **XGBoost** e aplicamos o treinamento com `fit()`. 
        """,
        unsafe_allow_html=True)
    
    st.image(image="images\Captura de tela 2025-02-15 152518.png")

    st.subheader('4. Avaliação do modelo')

    st.markdown('''
    Após o treinamento, precisamos avaliar a precisão do modelo. 
    Utilizamos as seguintes métricas: 
                
    - **MAE (Erro Absoluto Médio)** → Mede a diferença média entre valores reais e previstos. 

    - **RMSE (Raiz do Erro Quadrático Médio)** → Penaliza erros maiores. 

    - **MAPE (Erro Percentual Absoluto Médio)** → Expressa o erro percentual médio em relação ao valor real. 

    Para calcular essas métricas, utilizamos a função `evaluate_model()`, e para exibir os resultados formatados, criamos `print_metrics()`. 

    Os resultados foram: 

    - **MAE**: 4,68 (o modelo erra em média 4,68 dólares na previsão do petróleo); 

    - **MSE**: 5,58 (valores altos podem indicar previsões ruins, mas esse valor está dentro de um nível médio); 

    - **MAPE**: 6,18% (um erro abaixo de 10% pode ser considerado razoável). 
                
''')
    
    st.image(image="images\Captura de tela 2025-02-15 152536.png")

    st.image(image="images\Captura de tela 2025-02-15 152545.png")

    st.image(image="images\Captura de tela 2025-02-15 152558.png")

    st.subheader('5. Fazendo previsões')

    st.markdown(
    """
    Para realizar previsões futuras, utilizamos a função `predict_days()`. 
    Por padrão, a previsão é feita para 10 dias, mas esse valor pode ser ajustado.

    Antes de chamar essa função, fazemos uma preparação das datas (`prepare_dates()`), garantindo que:

    - As datas estejam no formato correto;
    - Apenas datas futuras sejam utilizadas.

    A função `final_predictions()` faz o **merge** das previsões com as datas 
    e garante que todas estejam formatadas corretamente.

    No nosso caso, realizamos a predição para **30 dias**.
    """
)

    st.image(image="images\Captura de tela 2025-02-15 152613.png")
    
    st.subheader('6. Visualização das previsões')

    st.markdown('''Para facilitar a análise dos resultados, geramos gráficos que mostram a comparação entre valores reais e previstos. Criamos funções específicas para essa tarefa, garantindo uma visualização clara dos dados. ''')
    
    st.image(image="images\Captura de tela 2025-02-15 152628.png")

    st.image(image="images\Captura de tela 2025-02-15 152649.png")

    st.image(image="images\Captura de tela 2025-02-15 152715.png")

    st.subheader('Conclusão')

    st.markdown('''O modelo apresentou um desempenho razoável, com um erro médio de **4,68 dólares** por previsão e um erro percentual de **6,18%**. Embora não seja um modelo perfeito, ele fornece boas estimativas do preço futuro do petróleo. 
                **Na próxima aba, você pode testá-lo**:wink:.''')

with tab2:
# Função para carregar os dados históricos
    def load_historical_data():
        url = "https://raw.githubusercontent.com/willdevsp/fiap-tech-challenge-pos-tech-data-analytics/refs/heads/will-fase4/Fase4/ipeadata%5B09-02-2025-09-30%5D.csv"
        df = pd.read_csv(url)
        df.columns = ['data', 'valor_fechamento', 'Unnamed: 2']  # Renomear colunas
        df['data'] = pd.to_datetime(df['data'], format='%d/%m/%Y')  # Converter para datetime
        df.drop(columns=['Unnamed: 2'], inplace=True)  # Remover coluna não utilizada
        df.set_index('data', inplace=True)  # Definir a coluna 'data' como índice
        return df

    # Função para preparar as datas
    def prepare_dates(dates):
        df_feature = pd.to_datetime(dates)
        df_feature = df_feature.to_frame()
        df_feature['ano'] = df_feature.index.year
        df_feature['mes'] = df_feature.index.month
        df_feature['dia'] = df_feature.index.day
        df_feature['dia_da_semana'] = df_feature.index.dayofweek
        df_feature.reset_index(drop=True, inplace=True)
        df_feature.drop(columns=[0], inplace=True)
        return df_feature

    # Função para fazer previsões
    def predict_days(model, start_date, days):
        future_dates = pd.date_range(start=start_date, periods=days)
        dates_for_predict = prepare_dates(future_dates)
        y_pred_final = model.predict(dates_for_predict)
        df_final_predict = pd.DataFrame(y_pred_final, index=future_dates, columns=['valor_fechamento'])
        return df_final_predict

    # Interface do Streamlit
    st.title(' :fuelpump: Previsão de preços do petróleo brent')

    st.subheader('Sobre o modelo')

    st.markdown('''
    - Abaixo podemos prever o resultado de um modelo de Machine learning (**XGBoost Regressor de erro quadrado**) que aprendeu com dados históricos para projetar os preços futuros.
    - A previsão abrange até próximos 90 dias.
    - O modelo tem um erro médio de 6,18%, o que significa que as previsões podem variar um pouco para cima ou para baixo.
    - Essa variação é normal e aceitável, considerando a complexidade do mercado de petróleo.
''')
    
    st.write('                                                                   ')

    st.markdown('''
    **Importante**
    - Os preços são apenas projeções e não garantem rentabilidade.
    - O mercado de petróleo é volátil e pode mudar rapidamente.
    - Use as previsões com cautela ao investir.''')
    st.write('                                                                   ')
    st.write('                                                                   ')
    # Carregar dados históricos
    df_historical = load_historical_data()

    # Exibir dados históricos
    #st.write("Dados Históricos:")
    #st.write(df_historical)

    # Carregar modelo treinado
    model = xgb.XGBRegressor()
    model.load_model('modelo_petroleo.json')

    # Última data disponível no dataset
    last_date = df_historical.index[-1]

    st.subheader('Quantos dias deseja prever?')

    # Número de dias para prever no futuro
    days_to_predict = st.selectbox(
        '',
        (15,30,45,60,75,90),
        index=None,
        placeholder="Selecione a quantidade de dias...",
    )

    # Gerar previsões desde 2005
    start_date_past = datetime(2024, 8, 1)
    days_past = (last_date - start_date_past).days  # Quantidade de dias entre 2005 e a última data do dataset
    predictions_past = predict_days(model, start_date_past, days_past)

    # Botão para fazer a previsão
    if st.button('Prever'):
        # Fazer previsões para os dias futuros
        predictions_future = predict_days(model, last_date + timedelta(days=1), days_to_predict)

        # Adicionar coluna 'tipo' para cada conjunto de dados
        df_historical['tipo'] = 'Histórico'
        predictions_past['tipo'] = 'Previsão Passada'
        predictions_future['tipo'] = 'Previsão Futura'

        # Combinar dados históricos, previsões passadas e previsões futuras
        df_combined = pd.concat([df_historical, predictions_past, predictions_future])

        # Filtrar apenas os dados a partir de 2005
        df_combined = df_combined[df_combined.index >= '2024-08-01']

        # Criar gráfico com pontos para dados históricos e linhas para previsões
        fig = go.Figure()

        # Adicionar pontos para os dados históricos
        fig.add_trace(go.Scatter(
            x=df_combined[df_combined['tipo'] == 'Histórico'].index,
            y=df_combined[df_combined['tipo'] == 'Histórico']['valor_fechamento'],
            mode='markers',  # Apenas pontos
            name='Dados Históricos',
            marker=dict(color='blue', size=5)  # Azul para os pontos
        ))

        # Adicionar linha para previsões passadas
        fig.add_trace(go.Scatter(
            x=df_combined[df_combined['tipo'] == 'Previsão Passada'].index,
            y=df_combined[df_combined['tipo'] == 'Previsão Passada']['valor_fechamento'],
            mode='lines',
            name='Previsão Passada',
            line=dict(color='orange', dash='dash')  # Linha laranja pontilhada
        ))

        # Adicionar linha para previsões futuras
        fig.add_trace(go.Scatter(
            x=df_combined[df_combined['tipo'] == 'Previsão Futura'].index,
            y=df_combined[df_combined['tipo'] == 'Previsão Futura']['valor_fechamento'],
            mode='lines',
            name='Previsão Futura',
            line=dict(color='red', dash='solid')  # Linha vermelha contínua
        ))

        # Ajustes do layout do gráfico
        fig.update_layout(
            title="Preços do Petróleo: Histórico e Previsão",
            xaxis_title="Data",
            yaxis_title="Preço de Fechamento",
            template="plotly_white"
        )

        # Exibir gráfico no Streamlit
        st.plotly_chart(fig)

        # Exibir dados combinados
        st.write("Dados Combinados (Histórico + Previsões desde outubro de 2024 + Futuro):")
        st.write(df_combined)

        csv = df_combined.to_csv(index=False)
        st.download_button(label='Baixar tabela como csv',data=csv,file_name='previsao_petroleo.csv',mime='text/csv')