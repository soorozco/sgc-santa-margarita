#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Lote 3 — PR-UV-13, 14, 15, 16, 17
Genera uv_pr_b3.sql
"""
import json, pathlib

def esc(s):
    return str(s).replace("'", "''") if s else ''

def j(obj):
    return json.dumps(obj, ensure_ascii=False)

# ── PR-UV-13 ──────────────────────────────────────────────────────────────────
PR_UV_13 = {
    "codigo": "PR-UV-13",
    "objetivo": (
        "Asegurar que se cuenten con los recursos adecuados para desarrollar en forma efectiva "
        "el sistema de prevención y control de infecciones, como lo son insumos, personal "
        "competente y sistemas de información."
    ),
    "alcance": (
        "Inicia cuando el departamento de epidemiología asegura que su personal esté capacitado "
        "para realizar cada una las actividades necesarias en el departamento y termina cuando el "
        "'Comité para la Detección y Control de Infecciones Asociadas a la Atención de la Salud "
        "(CODECIAAS)' gestiona los recursos necesarios."
    ),
    "definiciones": [
        {"termino":"IAAS","definicion":"Las Infecciones Asociadas a la Atención de la Salud (IAAS), se definen de acuerdo con la Organización Mundial de la Salud (OMS), como aquellas infecciones que afectan a un paciente durante el proceso de asistencia en un hospital o Centro Sanitario, que no estaba presente, ni en período de incubación al momento de su ingreso y que pueden inclusive llegar a manifestarse después del alta del paciente."},
        {"termino":"CODECIAAS","definicion":"Son las siglas del Comité para la Detección y Control de Infecciones Asociadas a la Atención de la Salud."},
    ],
    "responsabilidades": [
        {"tipo":"Actualización","descripcion":"Unidad de vigilancia epidemiológica hospitalaria (UVEH)."},
        {"tipo":"Ejecución","descripcion":"Recursos Humanos, Unidad de Vigilancia Epidemiológica Hospitalaria (UVEH) y Dirección Médica."},
        {"tipo":"Supervisión","descripcion":"Unidad de vigilancia epidemiológica hospitalaria (UVEH)."},
    ],
    "desarrollo": [
        {"num":"5.1","responsable":"Recursos Humanos","actividad":"El departamento de recursos humanos será encargado de reclutar personal capacitado y con experiencia para realizar actividades de vigilancia epidemiológica hospitalaria, establecido en la descripción de puesto. EM1"},
        {"num":"5.2","responsable":"Dirección Médica","actividad":"Evalúa que el personal médico reclutado para jefe de epidemiología cuente con estudios en epidemiología y/o Infectología. EM2"},
        {"num":"5.3","responsable":"Epidemiología","actividad":"Evalúa que el personal auxiliar reclutado tenga capacidades y habilidades, así como conocimientos indispensables en el área de epidemiología hospitalaria. EM2"},
        {"num":"5.4","responsable":"Dirección Médica y Epidemiología","actividad":"El departamento de epidemiología respaldado por dirección médica será el responsable de gestionar los recursos físicos y financieros para la adquisición de material e insumos necesarios para garantizar la seguridad en cuanto a infecciones asociadas a la atención de salud corresponda. EM3 y EM4"},
        {"num":"5.5","responsable":"CODECIAAS","actividad":"Cuando el departamento de epidemiología detecta los riesgos y problemas para la prevención y control de infecciones y no ha tenido éxito los recursos físicos y financieros, se recurre al Comité para la Detección y Control de Infecciones Asociadas a la Atención de la Salud (CODECIAAS) donde los integrantes del comité ayudarán a gestionar los recursos necesarios para la aplicación de acciones de mejora de los riesgos y/o problemas identificados. EM5."},
    ],
    "gestion_riesgos": [
        {"riesgo":"Incidencia de infecciones asociadas a la atención de salud (IAAS) recurrentes.","barrera":"Identificación oportuna de las infecciones asociadas a la atención de salud (IAAS) para la aplicación de medidas preventivas."},
        {"riesgo":"Riesgos laborales por falta de insumos para la protección de nuestros colaboradores.","barrera":"Monitoreo frecuentemente sobre los insumos necesarios para la atención sanitaria."},
        {"riesgo":"Omisión de los procesos internos en la atención sanitaria.","barrera":"Supervisión de los procesos internos y cumplimiento con lo requerido con las autoridades sanitarias."},
    ],
    "referencias": [
        {"nombre":"Norma Oficial Mexicana Nom-045-Ssa2-2015, Para La Vigilancia Epidemiológica, Prevención Y Control De Las Infecciones Nosocomiales.","codigo":"NA"},
    ],
    "control_cambios": [
        {"version":"01","fecha":"05/07/2021","descripcion":"Alta de documento","realizado":"Dr. Manuel Cortes Gutierrez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},
        {"version":"02","fecha":"08/11/2023","descripcion":"Alta de documento","realizado":"Dr. Estebán González Díaz","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},
        {"version":"03","fecha":"26/09/2025","descripcion":"Actualización de procedimiento","realizado":"Lic. Viridiana López Fajardo","aprobado":"Dr. Estebán González Díaz"},
    ],
}

# ── PR-UV-14 ──────────────────────────────────────────────────────────────────
PR_UV_14 = {
    "codigo": "PR-UV-14",
    "objetivo": (
        "Identificar infecciones desde el punto de vista epidemiológico, los sitios de infección, "
        "los dispositivos y procedimientos; con el fin de prevenir la incidencia de infecciones."
    ),
    "alcance": (
        "Inicia cuando el auxiliar de epidemiológica identifica factores de riesgo de los pacientes "
        "desde el momento que ingresa y termina cuando a través del 'Comité para la Detección y "
        "Control de Infecciones Asociadas a la Atención de la Salud, (CODECIAAS)', se analiza en "
        "conjunto las incidencias y se comprometen los integrantes a realizar acciones de prevención."
    ),
    "definiciones": [
        {"termino":"IAAS","definicion":"Las Infecciones Asociadas a la Atención de la Salud (IAAS), se definen de acuerdo con la Organización Mundial de la Salud (OMS), como aquellas infecciones que afectan a un paciente durante el proceso de asistencia en un hospital o Centro Sanitario, que no estaba presente, ni en período de incubación al momento de su ingreso y que pueden inclusive llegar a manifestarse después del alta del paciente."},
        {"termino":"CODECIAAS","definicion":"Son las siglas del Comité para la Detección y Control de Infecciones Asociadas a la Atención de la Salud."},
    ],
    "responsabilidades": [
        {"tipo":"Actualización","descripcion":"Unidad de vigilancia epidemiológica hospitalaria (UVEH)."},
        {"tipo":"Ejecución","descripcion":"Auxiliar de Epidemiología, Dirección Médica y CODECIAAS."},
        {"tipo":"Supervisión","descripcion":"Dirección Médica."},
    ],
    "desarrollo": [
        {"num":"5.1","responsable":"Auxiliar de Epidemiología","actividad":"Para la prevención e identificación temprana de infecciones relacionadas con la atención sanitaria realiza las siguientes actividades: Seguimiento de pacientes hospitalizados diariamente a través del censo diario electrónico; en el cual se monitorea al paciente desde el momento que ingresa y se identifica los factores de riesgo que inciden en las Infecciones Asociadas a la Atención de Salud (IAAS). Las Infecciones con prioridad en el departamento se destacan: Infección de vías respiratorias, Infección de vías urinarias, Infección por dispositivos intravasculares invasivos, Infección en los sitios quirúrgicos, Enfermedades y organismos más frecuentes desde el punto de vista epidemiológico, Organismos resistentes a múltiples fármacos, Infecciones emergentes o recurrentes dentro de la comunidad."},
        {"num":"5.2","responsable":"Auxiliar de Epidemiología","actividad":"Supervisa que el personal de enfermería clasifique de manera correcta la medida precautoria correspondiente (IT-UV-18 / FT-UV-05) y vigila que el personal clínico, no clínico y familiares, respeten el tipo de aislamiento para seguridad del paciente."},
        {"num":"5.3","responsable":"Auxiliar de Epidemiología","actividad":"Supervisa diariamente que el personal clínico realice la técnica de higiene de manos apegados a los 5 momentos como lo establece la Organización Mundial de la Salud (OMS) (IT-UV-01 / IT-UV-04) y supervisa que el hospital cuente con los insumos suficientes (PR-UV-01)."},
        {"num":"5.4","responsable":"Auxiliar de Epidemiología","actividad":"Monitorea diariamente a través de la bitácora de registro de resultados de análisis Bacteriología (FT-LA-21), los cultivos realizados de los pacientes hospitalizados y ambulatorios, con el fin de identificar de manera temprana el crecimiento de microorganismos e iniciar con las medidas precautorias correspondientes con el fin de proteger al personal clínico como no clínico, pacientes y familiares."},
        {"num":"5.5","responsable":"Auxiliar de Epidemiología","actividad":"Revisa de manera diaria notas de evolución de pacientes con el fin de identificar de manera temprana las Infección Asociada a la Atención de Salud (IAAS) y en caso de identificarse, se hace llenado de estudio epidemiológico y se notifica a secretaría de salud. Una vez que egresa el paciente, se analiza el tipo de infección presentada al inicio o al final de su estancia hospitalaria, y si requiere cultivo de superficie en el entorno del paciente es tomada por laboratorio, con el fin de asegurar calidad y desinfección de la habitación para el siguiente paciente."},
        {"num":"5.6","responsable":"Jefe de Epidemiología","actividad":"El jefe del departamento a través del Comité para la Detección y Control de Infecciones Asociadas a la Atención de la Salud presenta las tasas y tendencias de las infecciones detectadas por mes tomando en cuenta los siguientes factores: área, tipo de servicio y tipo de infección, con el fin de analizar donde es la causa raíz y así prevenir infecciones."},
        {"num":"5.7","responsable":"CODECIAAS","actividad":"Los integrantes del comité en conjunto analizan los factores que inciden en las infecciones y se comprometen a realizar acciones que beneficien a la prevención y control de infecciones."},
    ],
    "gestion_riesgos": [
        {"riesgo":"Incidencia de infecciones asociadas a la atención de salud (IAAS) recurrentes.","barrera":"Capacitación continua al personal clínico de las acciones prioritarias para la prevención y control de infecciones."},
        {"riesgo":"Identificación tardía de las infecciones asociadas a la atención de salud (IAAS).","barrera":"Adiestramiento del personal de epidemiología para la identificación oportuna de los casos."},
        {"riesgo":"Sanciones por parte Comisión para la Protección contra Riesgos Sanitarios del Estado de Jalisco (COPRISJAL), por incumplimiento a los compromisos establecidos en el CODECIAAS.","barrera":"Compromiso por parte de los jefes de departamento para realizar acciones preventivas."},
    ],
    "referencias": [
        {"nombre":"Supervisión de medidas precautorias","codigo":"IT-UV-18"},
        {"nombre":"Medidas precautorias","codigo":"FT-UV-05"},
        {"nombre":"Higiene de manos con agua y jabón","codigo":"IT-UV-01"},
        {"nombre":"Higiene de manos con gel alcoholado","codigo":"IT-UV-04"},
        {"nombre":"Abastecimiento de insumos para la higiene de manos","codigo":"PR-UV-01"},
        {"nombre":"Bitácora de bacteriología","codigo":"FT-LA-21"},
    ],
    "control_cambios": [
        {"version":"01","fecha":"07/2021","descripcion":"Alta de documento","realizado":"Dr. Manuel Cortes Gutiérrez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},
        {"version":"02","fecha":"20/09/2022","descripcion":"Modificación de documento","realizado":"Dr. Manuel Cortes","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},
        {"version":"03","fecha":"08/11/2023","descripcion":"Modificación de documento","realizado":"Dr. Manuel Cortes","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},
        {"version":"04","fecha":"26/09/2025","descripcion":"Actualización de procedimiento","realizado":"Lic. Viridiana López Fajardo","aprobado":"Dr. Estebán González Díaz"},
    ],
}

# ── PR-UV-15 ──────────────────────────────────────────────────────────────────
PR_UV_15 = {
    "codigo": "PR-UV-15",
    "objetivo": (
        "Prevenir y controlar enfermedades infectocontagiosas y buen manejo de pacientes inmunodeprimidos."
    ),
    "alcance": (
        "Inicia cuando el departamento de UVEH realiza la identificación de los pacientes con "
        "enfermedades infectocontagiosas o con inmunodepresión y termina cuando los integrantes "
        "del Comité para la Detección y Control de Infecciones Asociadas a la Atención de la "
        "Salud (CODECIAAS) analizan el apego a los procesos."
    ),
    "definiciones": [
        {"termino":"IAAS","definicion":"Las Infecciones Asociadas a la Atención de la Salud (IAAS), se definen de acuerdo con la Organización Mundial de la Salud (OMS), como aquellas infecciones que afectan a un paciente durante el proceso de asistencia en un hospital o Centro Sanitario, que no estaba presente, ni en período de incubación al momento de su ingreso y que pueden inclusive llegar a manifestarse después del alta del paciente."},
        {"termino":"CODECIAAS","definicion":"Son las siglas del Comité para la Detección y Control de Infecciones Asociadas a la Atención de la Salud."},
    ],
    "responsabilidades": [
        {"tipo":"Actualización","descripcion":"Unidad de vigilancia epidemiológica hospitalaria (UVEH)."},
        {"tipo":"Ejecución","descripcion":"Unidad de vigilancia epidemiológica hospitalaria (UVEH), Personal clínico, farmacia y CODECIAAS."},
        {"tipo":"Supervisión","descripcion":"Unidad de vigilancia epidemiológica hospitalaria (UVEH)."},
    ],
    "desarrollo": [
        {"num":"5.1","responsable":"UVEH","actividad":"Para la identificación de pacientes con enfermedades infectocontagiosas o inmunodepresión, el departamento está apegado a los lineamientos establecidos por la secretaría de Salud Jalisco y cuenta con procesos internos para el aislamiento de estos. EM1"},
        {"num":"5.2","responsable":"Auxiliar de Epidemiología","actividad":"Para la identificación de estos pacientes realizan las siguientes actividades: Seguimiento de Pacientes Hospitalizados diariamente por parte de UVEH (IT-UV-01) y Enfermería (FT-JE-29). Si se detecta paciente con enfermedad infectocontagiosa se inicia proceso de aislamiento para pacientes infecciosos (PR-UV-11). Si se detecta paciente con inmunodepresión se inicia proceso de aislamiento para pacientes inmunodeprimidos (PR-UV-12)."},
        {"num":"5.3","responsable":"Personal Clínico","actividad":"El personal de salud está capacitado para identificar qué tipo de medida precautoria requiere cada paciente dependiendo de su patología. Se cuenta con 6 medidas precautorias definidas a través de tarjetones y colores: Precauciones por contacto - Amarillo (IT-UV-08), Precauciones por vía Aérea - Azul (IT-UV-09), Precauciones por Gota - Verde (IT-UV-11), Precauciones Estándar - Rojo (IT-UV-12), Precauciones Vector - Rosa (IT-UV-13), Precauciones Inversa - Lila (IT-UV-14), Precauciones MDRO - tarjeta naranja (IT-UV-24). Nota: El personal de enfermería es quien identifica qué medida precautoria corresponde a cada paciente (FT-UV-05) y epidemiología supervisa que sea correcta."},
        {"num":"5.4","responsable":"Farmacia","actividad":"El departamento de farmacia asegura que todo el personal que requiera equipo de protección para situaciones de riesgo tendrá disponibilidad las 24 horas. EM5"},
        {"num":"5.5","responsable":"Auxiliar de Epidemiología","actividad":"Supervisa que el paciente que tiene aislamiento infectocontagioso o con inmunodepresión, tenga la medida precautoria correspondiente y el equipo de protección lo esté usando adecuadamente. EM6"},
        {"num":"5.6","responsable":"Auxiliar de Epidemiología","actividad":"Diariamente se supervisa que el personal clínico realice la técnica de higiene de manos apegados a los 5 momentos como lo establece la OMS (FT-UV-12 / IT-UV-01 / IT-UV-04) y supervisa que el hospital cuente con los insumos suficientes (FT-UV-01). Esto está apegado al Programa Integral de Higiene de manos que tiene el hospital (PG-UV-01). EM7"},
        {"num":"5.7","responsable":"CODECIAAS","actividad":"Durante las sesiones ordinarias del CODECIAAS, se analiza el apego que se tiene hacia los procesos mediante la supervisión que realiza el personal auxiliar de epidemiología y los integrantes del comité se comprometen a mejorar tales procesos."},
    ],
    "gestion_riesgos": [
        {"riesgo":"Brote de infecciones en el hospital por no apegarse al protocolo.","barrera":"Supervisión continúa de los procesos de pacientes con enfermedades infectocontagiosas o con inmunodepresión."},
        {"riesgo":"Renuencia del personal al no usar equipo de protección adecuado.","barrera":"Capacitación continua al personal clínico de la importancia del uso de equipo de protección."},
        {"riesgo":"Falta de insumos y equipo de protección para el desarrollo de los procesos.","barrera":"Inventario constante por parte del departamento de farmacia de los insumos y equipo de protección, necesario para el desarrollo de los procesos de aislamiento para pacientes infecciosos e inmunodepresión."},
    ],
    "referencias": [
        {"nombre":"Norma Oficial Mexicana NOM-045-SSA2-2005, para la Vigilancia Epidemiológica, Prevención y Control de las Infecciones Nosocomiales.","codigo":"NA"},
        {"nombre":"Supervisión de Medidas Precautorias","codigo":"IT-UV-18"},
        {"nombre":"Medidas Precautorias","codigo":"FT-UV-05"},
        {"nombre":"Higiene de Manos con Agua y Jabón","codigo":"IT-UV-01"},
        {"nombre":"Higiene de Manos con Gel Alcoholado","codigo":"IT-UV-04"},
        {"nombre":"Abastecimiento de Insumos para la Higiene de Manos","codigo":"PR-UV-01"},
        {"nombre":"Precauciones por Contacto","codigo":"IT-UV-08"},
        {"nombre":"Precauciones Aéreas por Micro-Gotas","codigo":"IT-UV-09"},
        {"nombre":"Precauciones por Gota","codigo":"IT-UV-11"},
        {"nombre":"Precauciones Estándar","codigo":"IT-UV-12"},
        {"nombre":"Precauciones por Vector","codigo":"IT-UV-13"},
        {"nombre":"Precauciones Inversa","codigo":"IT-UV-14"},
        {"nombre":"Precauciones MDRO","codigo":"IT-UV-24"},
        {"nombre":"Aislamiento para Pacientes Infecciosos","codigo":"PR-UV-11"},
        {"nombre":"Aislamiento para Pacientes Inmunodeprimidos","codigo":"PR-UV-12"},
    ],
    "control_cambios": [
        {"version":"01","fecha":"05/07/2021","descripcion":"Alta de documento","realizado":"Dr. Manuel Cortes Gutiérrez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},
        {"version":"02","fecha":"21/09/2022","descripcion":"Modificación del documento","realizado":"Dr. Manuel Cortes Gutiérrez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},
        {"version":"03","fecha":"26/09/2025","descripcion":"Actualización de procedimiento","realizado":"Lic. Viridiana López Fajardo","aprobado":"Dr. Estebán González Díaz"},
    ],
}

# ── PR-UV-16 ──────────────────────────────────────────────────────────────────
PR_UV_16 = {
    "codigo": "PR-UV-16",
    "objetivo": (
        "Prevenir el riesgo de infección por el manejo inadecuado de Residuos Peligrosos "
        "Biológico-Infecciosos de acuerdo con la legislación aplicable."
    ),
    "alcance": (
        "Inicia cuando el departamento de Seguridad de Higiene y Medio Ambiente aplica el manual "
        "para el manejo de Residuos Peligrosos Biológico-Infecciosos y termina cuando a través "
        "del CODECIAAS presentan las incidencias y acuerdan mejorar los procesos."
    ),
    "definiciones": [
        {"termino":"RPBI","definicion":"Son las siglas de Residuos Peligrosos Biológico-Infecciosos. Se refiere a materiales generados en la atención médica que contienen agentes biológico-infecciosos, como sangre, tejidos o cultivos, que pueden causar daños a la salud humana y al medio ambiente."},
        {"termino":"CODECIAAS","definicion":"Son las siglas del Comité para la Detección y Control de Infecciones Asociadas a la Atención de la Salud."},
    ],
    "responsabilidades": [
        {"tipo":"Actualización","descripcion":"Unidad de vigilancia epidemiológica hospitalaria (UVEH)."},
        {"tipo":"Ejecución","descripcion":"Seguridad e Higiene y Medio Ambiente, enfermería, UVEH y CODECIAAS."},
        {"tipo":"Supervisión","descripcion":"Dirección Médica."},
    ],
    "desarrollo": [
        {"num":"5.1","responsable":"Seguridad e Higiene y Medio Ambiente","actividad":"Aplica manual de procedimientos para el manejo inadecuado de Residuos Peligrosos Biológico-Infecciosos (MA-SG-01) en el cual se describen su debido manejo (identificación, envasado, almacenamiento temporal, recolección, transporte externo y destino final). EM1 y EM3"},
        {"num":"5.2","responsable":"Seguridad e Higiene y Medio Ambiente","actividad":"Realiza capacitación de manera periódica y calendarizada a todo el personal, en los procesos de dispensación, manejo, recolección y almacenamiento del RPBI. EM2"},
        {"num":"5.3","responsable":"Seguridad e Higiene y Medio Ambiente","actividad":"Se cuenta con trato vigente para presentación de servicios de recolección, trasporte y envío a tratamiento y/o disposición final de residuos peligros y apegado a las especificaciones de calidad. EM5 y EM7"},
        {"num":"5.4","responsable":"Enfermería","actividad":"Cuenta con proceso para el manejo de adecuado RPBI del personal de enfermería (PR-JE-08)."},
        {"num":"5.5","responsable":"UVEH","actividad":"El departamento de epidemiología realiza supervisión constante apegado siempre a la norma oficial mexicana NOM-087-ECOL-SSA1-2002, Protección ambiental - Salud Ambiental - Residuos Peligrosos Biológico-Infecciosos - Clasificación y Especificaciones de manejo. Nota: Si se identifica alguna incidencia se notifica al departamento de seguridad e higiene y se presenta en el CODECIAAS."},
        {"num":"5.6","responsable":"UVEH","actividad":"Realiza supervisión continua del manejo adecuado de RPBI, generada por el personal clínico."},
        {"num":"5.7","responsable":"UVEH","actividad":"Realiza supervisión de manera aleatoria, con el fin de asegurar el proceso de recolección de RPBI se realice de manera adecuada (FT-UV-02)."},
        {"num":"5.8","responsable":"UVEH","actividad":"Supervisión continua de punzocortantes."},
        {"num":"5.9","responsable":"UVEH","actividad":"Realiza seguimiento del personal clínico o no clínico expuesto a accidentes por punzocortantes (PR-UV-09). EM6"},
        {"num":"5.10","responsable":"CODECIAAS","actividad":"Se presentan las incidencias del manejo de RPBI con el fin de mejorar los procesos y comprometer a los integrantes involucrados."},
    ],
    "gestion_riesgos": [
        {"riesgo":"Infección por exposición accidental por un mal manejo de RPBI.","barrera":"Capacitación continua al personal clínico y no clínico del manejo adecuado de RPBI y punzocortantes."},
        {"riesgo":"Sanciones por parte Secretaría de Medio Ambiente y Recursos Naturales (SEMARNAT) por incumplimiento a los procesos de manejo de RPBI.","barrera":"Supervisión del manejo adecuado de RPBI y el externo por parte de la empresa subrogada."},
    ],
    "referencias": [
        {"nombre":"Manual de procedimientos para el manejo de residuos peligrosos biológico-infecciosos","codigo":"MA-SG-01"},
        {"nombre":"Procesos de trabajo para el manejo de residuos peligrosos biológico-infecciosos","codigo":"PR-JE-08"},
        {"nombre":"Supervisión de RPBI","codigo":"FT-UV-02"},
        {"nombre":"Encuesta por Accidentes laborales con riesgos Biológicos","codigo":"FT-UV-09"},
        {"nombre":"Supervisión del uso y desecho de punzocortantes","codigo":"IT-UV-19"},
        {"nombre":"Accidentes laborales con riesgos biológicos","codigo":"PR-UV-09"},
        {"nombre":"Supervisión de centrales y áreas","codigo":"FT-UV-22"},
    ],
    "control_cambios": [
        {"version":"01","fecha":"05/07/2021","descripcion":"Alta de documento","realizado":"Dr. Manuel Cortes Gutiérrez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},
        {"version":"02","fecha":"10/11/2023","descripcion":"Modificación de documento","realizado":"Dr. Manuel Cortes Gutiérrez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},
        {"version":"03","fecha":"26/09/2025","descripcion":"Actualización de procedimiento","realizado":"Lic. Viridiana López Fajardo","aprobado":"Dr. Estebán González Díaz"},
    ],
}

# ── PR-UV-17 ──────────────────────────────────────────────────────────────────
PR_UV_17 = {
    "codigo": "PR-UV-17",
    "objetivo": (
        "Garantizar la seguridad y se llevan a cabo acorde a la legislación aplicable vigente "
        "sobre el manejo de alimentos con el fin de prevenir infecciones a pacientes, trabajadores "
        "y visitantes."
    ),
    "alcance": (
        "Inicia cuando el departamento de Dietas y cocina realiza la preparación de alimento "
        "seguro y termina cuando epidemiología supervisa el área apegada a la Norma Oficial "
        "Mexicana NOM-251-SSA1-2009, Prácticas de Higiene para el proceso de alimentos, bebidas "
        "o suplementos alimenticios."
    ),
    "definiciones": [],
    "responsabilidades": [
        {"tipo":"Actualización","descripcion":"Unidad de vigilancia epidemiológica hospitalaria (UVEH)."},
        {"tipo":"Ejecución","descripcion":"Cocina Hospitalaria y UVEH."},
        {"tipo":"Supervisión","descripcion":"Dirección Médica."},
    ],
    "desarrollo": [
        {"num":"5.1","responsable":"Cocina Hospitalaria","actividad":"Realizan la preparación de alimentos seguro, de tal modo que se reduce el riesgo de contaminación o putrefacción."},
        {"num":"5.2","responsable":"Cocina Hospitalaria","actividad":"En la cocina del hospital Santa Margarita se tienen políticas donde se estipula un adecuado manejo higiénico de alimentos (políticas de cocina y dietas) (PL-NU-01). EM 1"},
        {"num":"5.3","responsable":"Cocina Hospitalaria","actividad":"Se ha establecido que la transportación de los alimentos deberá estar tapados y en carros limpios y desinfectados, debiendo utilizar cubiertos y cucharas desechables. (IT-NU-10) EM 1"},
        {"num":"5.4","responsable":"Cocina Hospitalaria","actividad":"El personal anualmente recibe capacitación por parte de la Comisión para la protección contra riesgos sanitarios del estado de Jalisco (COPRISJAL), sobre las buenas prácticas de manejo higiénico de alimentos y es capacitado internamente en este nosocomio al momento de su ingreso. EM 2"},
        {"num":"5.5","responsable":"Cocina Hospitalaria","actividad":"El departamento es el responsable de calendarizar de manera anual los estudios correspondientes a los manejadores de alimentos de: exudado faríngeo, coproparasitoscópico, y cultivo de uñas y manos. EM3"},
        {"num":"5.6","responsable":"Cocina Hospitalaria","actividad":"Da seguimiento a los colaboradores que obtengan un resultado positivo en los estudios anuales, hasta que sea dado de alta por su médico familiar en su seguridad social."},
        {"num":"5.7","responsable":"UVEH","actividad":"Para cuidar la inocuidad de la elaboración de alimentos se realizarán por medio de toma de muestras a superficies inertes PR-NU-10, en especial las mesas de trabajo, de esta manera se puede observar si se desinfectan las áreas antes de iniciar sus actividades y si se mantienen limpias."},
        {"num":"5.8","responsable":"UVEH","actividad":"Solicita análisis bacteriológico de alimentos al menos 1 vez por año a empresa subrogada. EM 5. Nota: en dado caso que se detecte algún microorganismo, el departamento de epidemiología dará las pautas de mejora y se hará monitoreo cada mes, con el fin de verificar si se realizaron las recomendaciones."},
        {"num":"5.9","responsable":"UVEH","actividad":"Se realiza supervisión al área de cafetería y cocina (FT-UV-14), de acuerdo con la Norma Oficial Mexicana NOM-251-SSA1-2009, Prácticas de Higiene para el proceso de alimentos, bebidas o suplementos alimenticios; en el cual se evalúa lo siguiente: Higiene Personal, Iluminación, Cloración de Agua, Instalaciones y áreas, Mantenimiento y Limpieza, Almacenamiento, Equipo, Control de Plagas, Bitácoras de temperaturas de congeladores y refrigeradores."},
    ],
    "gestion_riesgos": [
        {"riesgo":"Brotes por intoxicación alimentaria en pacientes, colaboradores y visitantes.","barrera":"Monitoreo continuo de los procesos del manejo de alimentos."},
        {"riesgo":"Sanciones por parte Comisión para la protección contra riesgos sanitarios del estado de Jalisco (COPRISJAL), por incumplimiento a norma oficial mexicana NOM-251-SSA1-2009.","barrera":"Supervisión continua por parte de UVEH apegado a la Norma Oficial."},
    ],
    "referencias": [
        {"nombre":"Norma oficial mexicana NOM-251-SSA1-2009, Prácticas de higiene para el proceso de alimentos, bebidas o suplementos alimenticios.","codigo":"NA"},
        {"nombre":"Manejo higiénico de alimentos","codigo":"PL-NU-01"},
        {"nombre":"Manejo higiénico de alimentos de pacientes","codigo":"IT-NU-10"},
        {"nombre":"Proceso de toma de muestras al personal de dietas","codigo":"PR-NU-09"},
        {"nombre":"Proceso de toma de muestras a superficies inertes","codigo":"PR-NU-10"},
        {"nombre":"Supervisión al área de cafetería y cocina","codigo":"FT-UV-14"},
    ],
    "control_cambios": [
        {"version":"01","fecha":"05/07/2021","descripcion":"Alta de documento","realizado":"Dr. Manuel Cortes Gutiérrez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},
        {"version":"02","fecha":"06/10/2022","descripcion":"Modificación de documento","realizado":"Dr. Manuel Cortes Gutiérrez","aprobado":"Mtra. Ana Cecilia Zarate Bautista"},
        {"version":"03","fecha":"26/09/2025","descripcion":"Actualización de procedimiento","realizado":"Lic. Viridiana López Fajardo","aprobado":"Dr. Estebán González Díaz"},
    ],
}

# ── Generador ─────────────────────────────────────────────────────────────────
DOCS = [PR_UV_13, PR_UV_14, PR_UV_15, PR_UV_16, PR_UV_17]

HEADER = """\
-- ============================================================
--  UV PR Lote 3 — PR-UV-13, 14, 15, 16, 17
--  Hospital Santa Margarita · SGC ISO 9001:2015
-- ============================================================
"""

def build(doc):
    code  = doc['codigo']
    alc   = esc(doc['alcance'])
    obj   = esc(doc['objetivo'])
    des   = esc(j(doc['desarrollo']))
    gr    = esc(j(doc['gestion_riesgos']))
    refs  = esc(j(doc['referencias']))
    cc    = esc(j(doc['control_cambios']))
    defs  = esc(j(doc['definiciones']))
    resps = esc(j(doc['responsabilidades']))
    return f"""
-- {code}
INSERT INTO document_content (
  document_id, alcance, objetivo,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios,
  definiciones, responsabilidades)
SELECT
  (SELECT id FROM documents WHERE code = '{code}'),
  '{alc}',
  '{obj}',
  '[]'::jsonb,
  '{des}'::jsonb,
  '{gr}'::jsonb,
  '{refs}'::jsonb,
  '{cc}'::jsonb,
  '{defs}'::jsonb,
  '{resps}'::jsonb
ON CONFLICT (document_id) DO UPDATE SET
  alcance              = EXCLUDED.alcance,
  objetivo             = EXCLUDED.objetivo,
  material_equipo      = EXCLUDED.material_equipo,
  desarrollo           = EXCLUDED.desarrollo,
  gestion_riesgos      = EXCLUDED.gestion_riesgos,
  referencias          = EXCLUDED.referencias,
  control_cambios      = EXCLUDED.control_cambios,
  definiciones         = EXCLUDED.definiciones,
  responsabilidades    = EXCLUDED.responsabilidades;
"""

out = HEADER + '\n'.join(build(d) for d in DOCS)
pathlib.Path('uv_pr_b3.sql').write_text(out, encoding='utf-8')
print(f'PR docs lote 3: {len(DOCS)}')
for d in DOCS:
    print(f"  {d['codigo']} — {len(d['desarrollo'])} pasos")
