import streamlit as st


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




st.title('🔍 Análise exploratória de dados')

# Criando múltiplas abas
tab1, tab2 = st.tabs(["Análise exploratória de dados", "Dashboard Interativo"])

with tab1:
    st.header("Análise da cotação do petróleo baseada nos dashboards do Power BI ")

    st.subheader("1. Visão geral da cotação do petróleo ")

    st.markdown("""
    - Cotação Atual: :blue[**77,11**]
                
    - Média da Cotação: :blue[**73,12**] 

    - Cotação Máxima: :green[**143,95**] 

    - Cotação Mínima: :red[**9,12**] 

    - Máx. Variação (%): :green[**50,99%**] 

    - Mín. Variação (%): :red[**-47,47%**] 

 

    **Insight**: A cotação do petróleo teve uma ampla variação ao longo do tempo, atingindo um pico de **143,95** e uma mínima de apenas **9,12**. **A variabilidade extrema indica um mercado altamente influenciado por eventos globais e crises econômicas.** """)

    st.subheader("2. Análise histórica da cotação do petróleo ")

    st.image(image='images\Captura de tela 2025-02-16 064638.png')

    st.markdown('''
    - O gráfico apresenta a evolução da cotação do petróleo ao longo dos anos. 
    - As linhas pontilhadas representam valores de referência, como **cotação mínima, média e máxima**. 

    **Insight**: A cotação do petróleo experimentou grandes oscilações, com momentos de alta volatilidade, principalmente em períodos de crise financeira e choques na oferta e demanda global. ''')

    st.subheader('3. Impacto de eventos históricos')

    st.markdown('''
    **Demanda por Energia** 

    **Definição**: A demanda por energia está relacionada ao consumo de combustíveis fósseis por indústrias, transportes e residências. Um aumento na demanda pode pressionar os preços do petróleo para cima, enquanto uma redução pode gerar quedas. ''')

    st.image(image='images\Captura de tela 2025-02-16 065645.png')

    st.markdown('''
    Eventos Relacionados:  

    - 2005: Crescente demanda por energia na China. 

    - 2010: Exploração intensa de petróleo nos EUA. 

    - 2015: Transição para energias renováveis. 

    - 2020: Impacto da COVID-19. 

    **Impacto**: Picos e quedas na cotação.

''')
    
    st.write('                                                                   ')

    st.markdown('''              
    **Crises Econômicas** 

    **Definição**: Crises financeiras impactam a demanda por petróleo devido à redução do consumo industrial e à retração do crescimento econômico global. Essas crises geralmente levam à queda nos preços do petróleo. ''')

    st.image(image='images\Captura de tela 2025-02-16 070438.png')

    st.markdown('''
    Eventos Relacionados:  

    - 2008: Crise financeira global. 

    - 2011: Rebaixamento do crédito dos EUA pela S&P. 

    - 2015: Crise da dívida da zona do euro. 

    **Impacto**: Quedas acentuadas na cotação do petróleo devido à retração da economia global.''' )

    st.write('                                                                   ')

    st.markdown('''
    **Eventos Históricos** 

    **Definição**: Eventos históricos, como guerras, conflitos e mudanças estratégicas na produção de petróleo, impactam a oferta global e influenciam diretamente os preços. ''')

    st.image(image='images\Captura de tela 2025-02-16 070929.png')

    st.markdown('''
    Eventos Relacionados:  

    - 2014: Aumento da produção dos EUA, queda dos preços do petróleo. 

    - 2022: Invasão da Ucrânia pela Rússia. 

    **Impacto**: Redução e posterior aumento acentuado no preço do petróleo. ''')

    st.write('                                                                   ')

    st.markdown('''
    **Situações Geopolíticas** 

    **Definição**: Situações geopolíticas, como tensões diplomáticas e instabilidade em regiões produtoras de petróleo, podem afetar o suprimento e elevar os preços devido à incerteza dos mercados. ''')

    st.image(image='images\Captura de tela 2025-02-16 071354.png')

    st.markdown('''
    Eventos Relacionados:  

    - 2011: Primavera Árabe. 

    - 2017: Crise diplomática do Catar. 

    **Impacto**: Influência na produção e distribuição de petróleo, impactando os preços. ''')

    st.write('                                                                   ')

    st.subheader('4. Conclusão')

    st.markdown(''' 

    - A análise demonstra a forte correlação entre eventos globais e a cotação do petróleo. 

    - Os principais fatores de impacto incluem crises econômicas, crescimento da demanda e situações geopolíticas. 

    - O histórico do preço do petróleo pode ser usado como indicador para prever padrões futuros e ajustar estratégias de investimento e gestão de risco. 

    **Recomendação**: Monitorar eventos econômicos e políticos globais para antever oscilações de preço e tomar decisões mais informadas no mercado de commodities. 
            
    **Na próxima aba você pode interagir com o dashboard**:wink:.''')

with tab2:
    st.header("Dashboard interativo")
    st.write("Interaja com o dashboard do Power BI abaixo:")

    # Código iframe gerado pelo Power BI
    iframe_code = """
    <iframe width="800" height="600" src="https://app.powerbi.com/view?r=eyJrIjoiODVlY2FhYTAtZDUwYy00ZDI3LWI1MjEtYjA3ODRiNGQ0Y2UyIiwidCI6IjExZGJiZmUyLTg5YjgtNDU0OS1iZTEwLWNlYzM2NGU1OTU1MSIsImMiOjR9" frameborder="0" allowFullScreen="true"></iframe>
    """

    # Exibir o iframe do Power BI
    st.write(iframe_code, unsafe_allow_html=True)