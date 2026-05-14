import json, os

def esc(s): return str(s).replace("'","''") if s else ''
def j(obj): return json.dumps(obj, ensure_ascii=False)

CC_ELAB = 'Lic. Viridiana López Fajardo'
CC_APR1 = 'Mtra. Ana Cecilia Zarate Bautista'
CC_APR2 = 'Dr. Esteban González Díaz'

def cc3(f1, f2, f3='30/09/2025', d1='Alta de documento', d2='Modificación de documento', d3='Actualización de instrucción'):
    return [
        {'version':'01','fecha':f1,'descripcion':d1,'realizado':CC_ELAB,'aprobado':CC_APR1},
        {'version':'02','fecha':f2,'descripcion':d2,'realizado':CC_ELAB,'aprobado':CC_APR1},
        {'version':'03','fecha':f3,'descripcion':d3,'realizado':CC_ELAB,'aprobado':CC_APR2},
    ]

def cc2(f1, f2='30/09/2025', d1='Alta de documento', d2='Actualización de instrucción', realizado2=None, aprobado1=None):
    r2 = realizado2 or CC_ELAB
    a1 = aprobado1 or CC_APR1
    return [
        {'version':'01','fecha':f1,'descripcion':d1,'realizado':CC_ELAB,'aprobado':a1},
        {'version':'02','fecha':f2,'descripcion':d2,'realizado':r2,'aprobado':CC_APR2},
    ]

docs = []

# ── IT-UV-02 ──────────────────────────────────────────────────────────────
docs.append({
    'code': 'IT-UV-02',
    'alcance': 'Esta instrucción de trabajo aplica al cumplimiento en las funciones del personal asistencial del Hospital, en áreas quirúrgicas durante el lavado de manos quirúrgico cero cepillos.',
    'material': ['Agua','Jabón','Sanitas'],
    'desarrollo': [
        {'num':'5.1','responsable':'Personal clínico','actividad':'Realice higiene de manos con agua y jabón. Ver IT-UV-01 Higiene de Manos con agua y jabón.'},
        {'num':'5.2','responsable':'Personal clínico','actividad':'Seca perfectamente tus manos, con papel desechable.'},
        {'num':'5.3','responsable':'Personal clínico','actividad':'Presiona el dispositivo automatizado para colocar una porción (5ml) de solución base el alcohol en la palma de la mano izquierda. (si el dispositivo no es automatizado presione con el codo).'},
        {'num':'5.4','responsable':'Personal clínico','actividad':'Sumerge la punta de los dedos de la mano derecha en la porción de solución, realizando movimientos circulares (5 segundos).'},
        {'num':'5.5','responsable':'Personal clínico','actividad':'Con la solución restante realice movimientos circulares desde la muñeca, brazo, antebrazo llegando hasta el codo.'},
        {'num':'5.6','responsable':'Personal clínico','actividad':'Asegúrese de brotar en movimientos circulares todas las áreas del brazo.'},
        {'num':'5.7','responsable':'Personal clínico','actividad':'Coloca una porción de solución con base alcohol, en la palma de la mano derecha.'},
        {'num':'5.8','responsable':'Personal clínico','actividad':'No debe tocar el dispositivo con las manos, este se despachará automáticamente o con el codo.'},
        {'num':'5.9','responsable':'Personal clínico','actividad':'Sumerge la punta de los dedos de la mano izquierda en la porción de solución, realizando movimientos circulares (5 segundos).'},
        {'num':'5.10','responsable':'Personal clínico','actividad':'Con la solución restante realice movimientos circulares desde la muñeca, brazo, antebrazo llegando hasta el codo.'},
        {'num':'5.11','responsable':'Personal clínico','actividad':'Asegúrese de brotar en movimientos circulares todas las áreas del brazo.'},
        {'num':'5.12','responsable':'Personal clínico','actividad':'Vuelva a tomar una porción de solución base alcohol.'},
        {'num':'5.13','responsable':'Personal clínico','actividad':'Friccione sus palmas.'},
        {'num':'5.14','responsable':'Personal clínico','actividad':'Frota dorso de la mano con espacios interdigitales.'},
        {'num':'5.15','responsable':'Personal clínico','actividad':'Frota espacios interdigitales con palmas.'},
        {'num':'5.16','responsable':'Personal clínico','actividad':'Friccione nudillos.'},
        {'num':'5.17','responsable':'Personal clínico','actividad':'Frota pulgar.'},
        {'num':'5.18','responsable':'Personal clínico','actividad':'Por último, si aún tiene solución en sus manos frote hasta que se seque la solución.'},
    ],
    'riesgos': [
        {'riesgo':'Omisión de la técnica de higiene de manos.','barrera':'Realizar capacitación sobre el proceso de higiene de manos.'},
        {'riesgo':'Carencia de insumos de higiene de manos.','barrera':'Solicitar el apoyo a la administración para el abastecimiento de insumos.'},
    ],
    'referencias': [
        {'nombre':'Acciones esenciales para la seguridad del paciente.','codigo':'NA'},
        {'nombre':'Estándares para la certificación de hospitales del Consejo de Salubridad General.','codigo':'NA'},
        {'nombre':'NOM-045-SSA3-2015, Para la Vigilancia Epidemiológica, Prevención y Control de las Infecciones Nosocomiales.','codigo':'NA'},
    ],
    'control_cambios': cc3('27/05/2021','08/09/2023'),
})

# ── IT-UV-05 ──────────────────────────────────────────────────────────────
docs.append({
    'code': 'IT-UV-05',
    'alcance': 'Este instructivo de trabajo aplica al cumplimiento de las funciones asistenciales del personal de salud del Hospital Santa Margarita, en la colocación de bata como método de barrera.',
    'material': ['Agua','Jabón','Sanitas','Batas','Guantes'],
    'desarrollo': [
        {'num':'5.1','responsable':'Personal clínico','actividad':'Colocación de bata: Realice higiene de manos IT-UV-01.'},
        {'num':'5.2','responsable':'Personal clínico','actividad':'Toma la bata por la parte interior del cuello o cintas del cuello.'},
        {'num':'5.3','responsable':'Personal clínico','actividad':'Al desdoblarla se debe evitar que toque el suelo o cualquier objeto.'},
        {'num':'5.4','responsable':'Personal clínico','actividad':'Introduce los brazos en las mangas y dejarla resbalar hacia los hombros; se puede ayudar con las manos, pero sin que éstas toquen el exterior de la bata.'},
        {'num':'5.5','responsable':'Personal clínico','actividad':'Se atan las cintas empezando por las del cuello y después cintura.'},
        {'num':'5.6','responsable':'Personal clínico','actividad':'Cálzate guantes si es necesario.'},
        {'num':'5.7','responsable':'Personal clínico','actividad':'Retiro de bata: Quita los guantes si procede.'},
        {'num':'5.8','responsable':'Personal clínico','actividad':'Desata las cintas de la bata.'},
        {'num':'5.9','responsable':'Personal clínico','actividad':'Deja que la bata resbale por sus brazos. Si es desechable júntala con la parte interna de la bata y deséchala según la normatividad vigente.'},
        {'num':'5.10','responsable':'Personal clínico','actividad':'En el caso que se vuelva a utilizar cuélgala con la parte exterior.'},
    ],
    'riesgos': [
        {'riesgo':'Omisión del proceso por parte del personal.','barrera':'Realizar capacitación y supervisión del proceso.'},
        {'riesgo':'Carencia de insumos.','barrera':'Solicitar el apoyo a la administración para el abastecimiento de insumos (batas) y ropería.'},
    ],
    'referencias': [
        {'nombre':'Instrucción de trabajo para la higiene de manos con agua y jabón.','codigo':'IT-UV-01'},
        {'nombre':'Instrucción de trabajo para la higiene de manos con gel alcoholado.','codigo':'IT-UV-04'},
    ],
    'control_cambios': cc3('27/05/2021','08/09/2023'),
})

# ── IT-UV-06 ──────────────────────────────────────────────────────────────
docs.append({
    'code': 'IT-UV-06',
    'alcance': 'Este instructivo de trabajo aplica al cumplimiento de las funciones asistenciales del personal de salud del Hospital Santa Margarita, en la colocación de cubre bocas como método de barrera.',
    'material': ['Agua','Jabón','Sanitas','Mascarilla facial'],
    'desarrollo': [
        {'num':'5.1','responsable':'Personal clínico','actividad':'Realice higiene de manos IT-UV-01.'},
        {'num':'5.2','responsable':'Personal clínico','actividad':'Revisa cuál es el lado correcto del cubrebocas (las costuras gruesas corresponden a la parte interna del cubre bocas), ten mucho cuidado de no usarlo por el reverso.'},
        {'num':'5.3','responsable':'Personal clínico','actividad':'No dejes que entre en contacto con superficies que puedan estar contaminadas como son los muebles.'},
        {'num':'5.4','responsable':'Personal clínico','actividad':'Pasa por tu cabeza las cintas elásticas y colócalo.'},
        {'num':'5.5','responsable':'Personal clínico','actividad':'Es muy importante que tus manos no toquen la parte interna.'},
        {'num':'5.6','responsable':'Personal clínico','actividad':'Mientras lo tengas puesto no lo toques. Si por cualquier razón lo llegaras a tocar, lávate las manos o realiza higiene de manos con gel que tenga base alcohol.'},
        {'num':'5.7','responsable':'Personal clínico','actividad':'Ajústalo a tu cara, cubre completamente boca y nariz.'},
        {'num':'5.8','responsable':'Personal clínico','actividad':'El cubrebocas no se comparte con nadie, es de uso personal.'},
        {'num':'5.9','responsable':'Personal clínico','actividad':'Aun cuando utilices el cubrebocas, debes de estornudar o toser tapándote la boca y nariz con un pañuelo o con el ángulo interno del codo.'},
        {'num':'5.10','responsable':'Personal clínico','actividad':'Una vez que lo termine de usar deséchalo según corresponda la normatividad vigente.'},
        {'num':'5.11','responsable':'Personal clínico','actividad':'Realice higiene de manos.'},
    ],
    'riesgos': [
        {'riesgo':'Omisión del proceso por parte del personal clínico.','barrera':'Realizar capacitación y supervisión del proceso.'},
        {'riesgo':'Carencia de insumos.','barrera':'Solicitar el apoyo a la administración para el abastecimiento de cubrebocas.'},
    ],
    'referencias': [
        {'nombre':'Instrucción de trabajo para la higiene de manos con agua y jabón.','codigo':'IT-UV-01'},
        {'nombre':'Instrucción de trabajo para la higiene de manos con gel alcoholado.','codigo':'IT-UV-04'},
        {'nombre':'Norma Oficial Mexicana NOM-045-SSA2-2015, Para La Vigilancia Epidemiológica, Prevención Y Control De Las Infecciones Nosocomiales.','codigo':'NA'},
    ],
    'control_cambios': cc3('27/05/2021','08/09/2023'),
})

# ── IT-UV-07 ──────────────────────────────────────────────────────────────
docs.append({
    'code': 'IT-UV-07',
    'alcance': 'Este instructivo de trabajo aplica al cumplimiento de las funciones asistenciales del personal de salud del Hospital Santa Margarita, en la colocación de lentes de protección como método de barrera.',
    'material': ['Lentes protectores','Agua','Jabón','Sanitas'],
    'desarrollo': [
        {'num':'5.1','responsable':'Personal clínico','actividad':'Realice higiene de manos (Ver IT-UV-01).'},
        {'num':'5.2','responsable':'Personal clínico','actividad':'Cerciórate que los lentes estén limpios.'},
        {'num':'5.3','responsable':'Personal clínico','actividad':'Con las manos limpias y secas, retire la protección ocular de su envase.'},
        {'num':'5.4','responsable':'Personal clínico','actividad':'Colócatelos y ajústalos si es necesario, por la parte de la cintilla.'},
        {'num':'5.5','responsable':'Personal clínico','actividad':'Póngase las gafas de seguridad sobre los ojos y asegúrelas con las cintas o correa para la cabeza.'},
        {'num':'5.6','responsable':'Personal clínico','actividad':'Ajuste y apriete las gafas para garantizar un ajuste seguro (no apretado).'},
        {'num':'5.7','responsable':'Personal clínico','actividad':'Retiro de lentes: Realice higiene de manos.'},
        {'num':'5.8','responsable':'Personal clínico','actividad':'Sujete las cintas o la correa y levante las gafas de seguridad o el protector facial alejándolo del rostro.'},
        {'num':'5.9','responsable':'Personal clínico','actividad':'Déjelo en el recipiente destinado a su eliminación.'},
    ],
    'riesgos': [
        {'riesgo':'Omisión del proceso por parte del personal clínico durante procedimiento de riesgo.','barrera':'Realizar capacitación y supervisión del proceso.'},
        {'riesgo':'Carencia de insumos.','barrera':'Solicitar el apoyo a la administración para el abastecimiento de lentes de protección.'},
    ],
    'referencias': [
        {'nombre':'Instrucción de trabajo para la higiene de manos con agua y jabón.','codigo':'IT-UV-01'},
        {'nombre':'Instrucción de trabajo para la higiene de manos con gel alcoholado.','codigo':'IT-UV-04'},
        {'nombre':'Norma Oficial Mexicana NOM-045-SSA2-2015, Para La Vigilancia Epidemiológica, Prevención Y Control De Las Infecciones Nosocomiales.','codigo':'NA'},
    ],
    'control_cambios': cc3('01/06/2021','08/09/2023'),
})

# ── IT-UV-08 ──────────────────────────────────────────────────────────────
docs.append({
    'code': 'IT-UV-08',
    'alcance': 'Esta instrucción de trabajo es aplicable a las funciones asistenciales del personal de salud del Hospital Santa Margarita en las precauciones por contacto.',
    'material': ['Tarjeta de medida precautoria por contacto','Guantes','Bata','Gel alcoholado','Agua','Jabón','Sanitas','Cubrebocas'],
    'desarrollo': [
        {'num':'5.1','responsable':'Personal clínico','actividad':'Coloque tarjeta amarilla visible.'},
        {'num':'5.2','responsable':'Personal clínico','actividad':'Explique al usuario verbalmente los motivos del aislamiento y a sus familiares.'},
        {'num':'5.3','responsable':'Personal clínico','actividad':'Asigna un cuarto individual (en medida de lo posible) o coloca al paciente con otros pacientes con el mismo agente etiológico.'},
        {'num':'5.4','responsable':'Personal clínico','actividad':'En caso de no ser posible lo anterior se deberá mantener al menos 1m de distancia entre un paciente y otro reforzando todas las medidas descritas.'},
        {'num':'5.5','responsable':'Personal clínico','actividad':'Uso de Guantes: Realizar higiene de manos (IT-UV-01).'},
        {'num':'5.6','responsable':'Personal clínico','actividad':'Usar guantes estériles durante el contacto directo con el paciente.'},
        {'num':'5.7','responsable':'Personal clínico','actividad':'Cambia estos posteriormente al tener contacto con secreciones o superficies contaminadas.'},
        {'num':'5.8','responsable':'Personal clínico','actividad':'Tira los guantes según corresponda RPBI (bolsa Roja) dentro de la habitación.'},
        {'num':'5.9','responsable':'Personal clínico','actividad':'Lávate las manos en los cinco momentos de atención al paciente.'},
        {'num':'5.10','responsable':'Personal clínico','actividad':'No reutilizar guantes en ningún momento.'},
        {'num':'5.11','responsable':'Personal clínico','actividad':'Bata (tela/desechable): Usa bata limpia, no estéril, de tela o desechable antes de tener cualquier contacto directo con el paciente o ante el riesgo de salpicaduras.'},
        {'num':'5.12','responsable':'Personal clínico','actividad':'No deseches la bata si no tuvo contacto con secreciones o superficies contaminadas.'},
        {'num':'5.13','responsable':'Personal clínico','actividad':'Coloca la bata en el perchero doblada hacia afuera.'},
        {'num':'5.14','responsable':'Personal clínico','actividad':'Desechar la bata si se tuvo contacto con secreciones o superficies contaminadas, mediante una bolsa transparente etiquetada para lavado especial.'},
        {'num':'5.15','responsable':'Personal clínico','actividad':'En el caso de batas desechables serán de un solo uso solo con agentes Multidrogorresistentes (MDRO) y/o altamente patógenos, se deberá desechar dentro de la habitación según corresponda RPBI.'},
        {'num':'5.16','responsable':'Personal clínico','actividad':'Cubre bocas (mascarilla Facial): Colócate cubrebocas ante riesgo de salpicaduras.'},
        {'num':'5.17','responsable':'Personal clínico','actividad':'Lávate las manos en los cinco momentos de atención al paciente.'},
        {'num':'5.18','responsable':'Personal clínico','actividad':'Deséchalo según corresponda RPBI.'},
        {'num':'5.19','responsable':'Personal clínico','actividad':'Realizar higiene de manos en sus cinco momentos de higiene de manos en la atención al paciente.'},
        {'num':'5.20','responsable':'Personal clínico','actividad':'Equipo médico: Dentro de lo posible limitar a un solo paciente.'},
        {'num':'5.21','responsable':'Personal clínico','actividad':'Desinfecte todo material previo a su uso y posterior a su uso con soluciones desinfectantes autorizados, antes de ser utilizados en otro paciente.'},
        {'num':'5.22','responsable':'Personal clínico','actividad':'Transporte del paciente: Únicamente si es indispensable. Respeta en todo momento la medida de contacto.'},
        {'num':'5.23','responsable':'Personal clínico','actividad':'Utiliza bata y guantes si se tiene contacto directo o en riesgo de salpicadura.'},
        {'num':'5.24','responsable':'Personal clínico','actividad':'Visitas: Permitidas, pero con restricción únicamente podrá permanecer un familiar en la habitación.'},
        {'num':'5.25','responsable':'Personal clínico','actividad':'Eduque al familiar sobre la higiene de manos, colocación de bata y cubrebocas. Informe sobre no compartir objetos personales.'},
    ],
    'riesgos': [
        {'riesgo':'Omisión por parte del personal clínico de aplicar medidas precautorias.','barrera':'Realizar capacitación y supervisión de la medida de precaución por contacto.'},
        {'riesgo':'Carencia de insumos para aplicar medidas.','barrera':'Solicitar el apoyo a la administración para el abastecimiento de insumos.'},
    ],
    'referencias': [
        {'nombre':'Instrucción de trabajo para la higiene de manos con agua y jabón.','codigo':'IT-UV-01'},
        {'nombre':'Instrucción de trabajo para la higiene de manos con gel alcoholado.','codigo':'IT-UV-04'},
        {'nombre':'Norma Oficial Mexicana NOM-045-SSA2-2015, Para La Vigilancia Epidemiológica, Prevención Y Control De Las Infecciones Nosocomiales.','codigo':'NA'},
        {'nombre':'Norma Oficial Mexicana NOM-087-ECOL-SSA1-2002, Protección ambiental - Salud ambiental - Residuos peligrosos biológico-infecciosos - Clasificación y especificaciones de manejo.','codigo':'NA'},
    ],
    'control_cambios': cc3('01/06/2021','08/09/2023'),
})

# ── IT-UV-09 ──────────────────────────────────────────────────────────────
docs.append({
    'code': 'IT-UV-09',
    'alcance': 'Esta instrucción de trabajo es aplicable a las funciones asistenciales del personal de salud del Hospital Santa Margarita en las precauciones aéreas por microgotas.',
    'material': ['Tarjeta de medida precautoria aérea','Guantes','Bata','Gel alcoholado','Agua','Jabón','Sanitas','Cubrebocas N95'],
    'desarrollo': [
        {'num':'5.1','responsable':'Personal clínico','actividad':'Realice Higiene de manos IT-UV-01.'},
        {'num':'5.2','responsable':'Personal clínico','actividad':'Coloca tarjeta azul en un lugar visible.'},
        {'num':'5.3','responsable':'Personal clínico','actividad':'Habitación: Asigne un cuarto aislado.'},
        {'num':'5.4','responsable':'Personal clínico','actividad':'Mantenga la puerta cerrada en todo momento.'},
        {'num':'5.5','responsable':'Personal clínico','actividad':'Abra las ventanas en medida de lo posible.'},
        {'num':'5.6','responsable':'Personal clínico','actividad':'Cubrebocas: Utilice cubrebocas modelo N95 (categoría N, Eficiencia 95%).'},
        {'num':'5.7','responsable':'Personal clínico','actividad':'Colócate antes de entrar a la habitación el cubrebocas.'},
        {'num':'5.8','responsable':'Personal clínico','actividad':'Se puede reusar el cubrebocas, pero deberá ser reutilizada por la misma persona, siempre y cuando se mantengan en bolsa de plástico, con nombre y sin doblar.'},
        {'num':'5.9','responsable':'Personal clínico','actividad':'No compartir cubrebocas.'},
        {'num':'5.10','responsable':'Personal clínico','actividad':'El cubrebocas se debe cambiar cada que se requiera.'},
        {'num':'5.11','responsable':'Personal clínico','actividad':'Bata (tela/desechable): Usa bata limpia, no estéril, de tela o desechable antes de tener cualquier contacto directo con el paciente o ante el riesgo de salpicaduras.'},
        {'num':'5.12','responsable':'Personal clínico','actividad':'No deseches la bata si no tuvo contacto con secreciones o superficies contaminadas.'},
        {'num':'5.13','responsable':'Personal clínico','actividad':'Coloca la bata en el perchero doblada hacia afuera.'},
        {'num':'5.14','responsable':'Personal clínico','actividad':'Desechar la bata si se tuvo contacto con secreciones o superficies contaminadas, mediante una bolsa transparente etiquetada para lavado especial.'},
        {'num':'5.15','responsable':'Personal clínico','actividad':'En el caso de batas desechables serán de un solo uso solo con agentes MDRO y/o altamente patógenos, se deberá desechar dentro de la habitación según corresponda RPBI.'},
        {'num':'5.16','responsable':'Personal clínico','actividad':'Uso de Guantes: Realizar higiene de manos (IT-UV-01).'},
        {'num':'5.17','responsable':'Personal clínico','actividad':'Usar guantes estériles durante el contacto directo con el paciente.'},
        {'num':'5.18','responsable':'Personal clínico','actividad':'Cambia estos posteriormente al tener contacto con secreciones o superficies contaminadas.'},
        {'num':'5.19','responsable':'Personal clínico','actividad':'Tira los guantes según corresponda RPBI (bolsa Roja) dentro de la habitación.'},
        {'num':'5.20','responsable':'Personal clínico','actividad':'Lávate las manos en los cinco momentos de atención al paciente.'},
        {'num':'5.21','responsable':'Personal clínico','actividad':'No reutilizar guantes en ningún momento.'},
        {'num':'5.22','responsable':'Personal clínico','actividad':'Equipo médico: Dentro de lo posible limitar a un solo paciente.'},
        {'num':'5.23','responsable':'Personal clínico','actividad':'Desinfecte todo material previo a su uso y posterior a su uso con soluciones desinfectantes autorizados, antes de ser utilizados en otro paciente.'},
        {'num':'5.24','responsable':'Personal clínico','actividad':'Transporte del paciente: Únicamente si es indispensable. El paciente deberá portar N95.'},
        {'num':'5.25','responsable':'Personal clínico','actividad':'Utiliza bata y guantes si se tiene contacto directo o en riesgo de salpicadura.'},
        {'num':'5.26','responsable':'Personal clínico','actividad':'Visitas: Permitidas, pero con restricción únicamente podrá permanecer un familiar en la habitación.'},
        {'num':'5.27','responsable':'Personal clínico','actividad':'Eduque al familiar sobre la higiene de manos, colocación de bata y cubrebocas N95. Informe sobre no compartir objetos personales.'},
    ],
    'riesgos': [
        {'riesgo':'Omisión por parte del personal clínico de aplicar medida precautoria vía aérea.','barrera':'Realizar capacitación y supervisión de la medida de precaución vía aérea.'},
        {'riesgo':'Carencia de insumos para aplicar medidas.','barrera':'Solicitar el apoyo a la administración para el abastecimiento de insumos.'},
    ],
    'referencias': [
        {'nombre':'Instrucción de trabajo para la higiene de manos con agua y jabón.','codigo':'IT-UV-01'},
        {'nombre':'Instrucción de trabajo para la higiene de manos con gel alcoholado.','codigo':'IT-UV-04'},
        {'nombre':'Norma Oficial Mexicana NOM-045-SSA2-2015, Para La Vigilancia Epidemiológica, Prevención Y Control De Las Infecciones Nosocomiales.','codigo':'NA'},
        {'nombre':'Norma Oficial Mexicana NOM-087-ECOL-SSA1-2002, Protección ambiental - Salud ambiental - Residuos peligrosos biológico-infecciosos - Clasificación y especificaciones de manejo.','codigo':'NA'},
    ],
    'control_cambios': cc3('01/06/2021','08/09/2023'),
})

# ── IT-UV-10 ──────────────────────────────────────────────────────────────
docs.append({
    'code': 'IT-UV-10',
    'alcance': 'Esta instrucción de trabajo es aplicable a las funciones asistenciales del personal de salud del Hospital Santa Margarita en el calzado de guantes técnica abierta.',
    'material': ['Guantes','Gel alcoholado','Agua','Jabón','Sanitas'],
    'desarrollo': [
        {'num':'5.1','responsable':'Personal clínico','actividad':'Realice Higiene de manos IT-UV-01.'},
        {'num':'5.2','responsable':'Personal clínico','actividad':'Abra el paquete e identificará los guantes.'},
        {'num':'5.3','responsable':'Personal clínico','actividad':'Toma con la mano derecha el doblez del puño del guante izquierdo, levántalo del paquete y deslícelo sobre la mano izquierda.'},
        {'num':'5.4','responsable':'Personal clínico','actividad':'Con la mano enguantada desliza los dedos debajo del puño doblado del guante derecho y levántalo de la envoltura.'},
        {'num':'5.5','responsable':'Personal clínico','actividad':'Desliza la mano derecha en el guante y tira el puño para que quede sobre la muñeca.'},
        {'num':'5.6','responsable':'Personal clínico','actividad':'Una vez colocados los guantes ajústese de los dedos.'},
    ],
    'riesgos': [
        {'riesgo':'Desconocimiento del personal clínico al no realizar la técnica.','barrera':'Realizar capacitación y supervisión.'},
        {'riesgo':'Carencia de insumos para aplicar medidas.','barrera':'Solicitar el apoyo a la administración para el abastecimiento de insumos.'},
    ],
    'referencias': [
        {'nombre':'Instrucción de trabajo para la higiene de manos con agua y jabón.','codigo':'IT-UV-01'},
        {'nombre':'Instrucción de trabajo para la higiene de manos con gel alcoholado.','codigo':'IT-UV-04'},
        {'nombre':'Norma Oficial Mexicana NOM-045-SSA2-2015, Para La Vigilancia Epidemiológica, Prevención Y Control De Las Infecciones Nosocomiales.','codigo':'NA'},
    ],
    'control_cambios': cc3('01/06/2021','08/09/2023'),
})

# ── IT-UV-11 ──────────────────────────────────────────────────────────────
docs.append({
    'code': 'IT-UV-11',
    'alcance': 'Esta instrucción de trabajo es aplicable a las funciones asistenciales del personal de salud del Hospital Santa Margarita en las precauciones por gotas.',
    'material': ['Tarjeta de medida precautoria por gota','Guantes','Bata','Gel alcoholado','Agua','Jabón','Sanitas','Cubrebocas Quirúrgico'],
    'desarrollo': [
        {'num':'5.1','responsable':'Personal clínico','actividad':'Realice Higiene de manos IT-UV-01.'},
        {'num':'5.2','responsable':'Personal clínico','actividad':'Coloca una tarjeta verde en un lugar visible.'},
        {'num':'5.3','responsable':'Personal clínico','actividad':'Habitación: Asigne un cuarto aislado. Si esto no fuera posible deberá mantener al menos 1.5m de distancia entre un paciente y otro, y reforzar todas las medidas estándar.'},
        {'num':'5.4','responsable':'Personal clínico','actividad':'Mantenga la puerta cerrada en todo momento.'},
        {'num':'5.5','responsable':'Personal clínico','actividad':'Abra las ventanas en medida de lo posible.'},
        {'num':'5.6','responsable':'Personal clínico','actividad':'Cubrebocas: Utilice cubrebocas quirúrgico.'},
        {'num':'5.7','responsable':'Personal clínico','actividad':'Colócate antes de entrar a la habitación.'},
        {'num':'5.8','responsable':'Personal clínico','actividad':'Se deberá utilizar si se va a estar a menos de un metro y medio del paciente.'},
        {'num':'5.9','responsable':'Personal clínico','actividad':'El cubrebocas se debe cambiar cada que se requiera.'},
        {'num':'5.10','responsable':'Personal clínico','actividad':'Bata (tela/desechable): Usa bata limpia, no estéril, de tela o desechable antes de tener cualquier contacto directo con el paciente o ante el riesgo de salpicaduras.'},
        {'num':'5.11','responsable':'Personal clínico','actividad':'No deseches la bata si no tuvo contacto con secreciones o superficies contaminadas.'},
        {'num':'5.12','responsable':'Personal clínico','actividad':'Coloca la bata en el perchero doblada hacia afuera.'},
        {'num':'5.13','responsable':'Personal clínico','actividad':'Desechar la bata si se tuvo contacto con secreciones o superficies contaminadas, mediante una bolsa transparente etiquetada para lavado especial.'},
        {'num':'5.14','responsable':'Personal clínico','actividad':'En el caso de batas desechables serán de un solo uso solo con agentes MDRO y/o altamente patógenos, se deberá desechar dentro de la habitación según corresponda RPBI.'},
        {'num':'5.15','responsable':'Personal clínico','actividad':'Uso de Guantes: Realizar higiene de manos (IT-UV-01).'},
        {'num':'5.16','responsable':'Personal clínico','actividad':'Usar guantes estériles durante el contacto directo con el paciente.'},
        {'num':'5.17','responsable':'Personal clínico','actividad':'Cambia estos posteriormente al tener contacto con secreciones o superficies contaminadas.'},
        {'num':'5.18','responsable':'Personal clínico','actividad':'Tira los guantes según corresponda RPBI (bolsa Roja) dentro de la habitación.'},
        {'num':'5.19','responsable':'Personal clínico','actividad':'Lávate las manos en los cinco momentos de atención al paciente.'},
        {'num':'5.20','responsable':'Personal clínico','actividad':'No reutilizar guantes en ningún momento.'},
        {'num':'5.21','responsable':'Personal clínico','actividad':'Equipo médico: Dentro de lo posible limitar a un solo paciente.'},
        {'num':'5.22','responsable':'Personal clínico','actividad':'Desinfecte todo material previo a su uso y posterior a su uso con soluciones desinfectantes autorizados, antes de ser utilizados en otro paciente.'},
        {'num':'5.23','responsable':'Personal clínico','actividad':'Transporte del paciente: Únicamente si es indispensable. El paciente deberá portar cubrebocas.'},
        {'num':'5.24','responsable':'Personal clínico','actividad':'Utiliza bata y guantes si se tiene contacto directo o en riesgo de salpicadura.'},
        {'num':'5.25','responsable':'Personal clínico','actividad':'Visitas: Permitidas, pero con restricción únicamente podrá permanecer un familiar en la habitación.'},
        {'num':'5.26','responsable':'Personal clínico','actividad':'Eduque al familiar sobre la higiene de manos, colocación de bata y cubrebocas quirúrgico. Informe sobre no compartir objetos personales.'},
    ],
    'riesgos': [
        {'riesgo':'Brotes de infecciones y autoinfección por no respetar medida precautoria.','barrera':'Realizar capacitación y supervisión.'},
        {'riesgo':'Carencia de insumos para aplicar medida.','barrera':'Solicitar el apoyo a la administración para el abastecimiento de insumos.'},
    ],
    'referencias': [
        {'nombre':'Instrucción de trabajo para la higiene de manos con agua y jabón.','codigo':'IT-UV-01'},
        {'nombre':'Instrucción de trabajo para la higiene de manos con gel alcoholado.','codigo':'IT-UV-04'},
        {'nombre':'Norma Oficial Mexicana NOM-045-SSA2-2015, Para La Vigilancia Epidemiológica, Prevención Y Control De Las Infecciones Nosocomiales.','codigo':'NA'},
    ],
    'control_cambios': [
        {'version':'01','fecha':'01/06/2021','descripcion':'Alta de documento','realizado':CC_ELAB,'aprobado':CC_APR1},
        {'version':'02','fecha':'09/02/2024','descripcion':'Modificación de documento','realizado':CC_ELAB,'aprobado':CC_APR1},
        {'version':'03','fecha':'30/09/2025','descripcion':'Actualización de instrucción','realizado':CC_ELAB,'aprobado':CC_APR2},
    ],
})

# ── IT-UV-12 ──────────────────────────────────────────────────────────────
docs.append({
    'code': 'IT-UV-12',
    'alcance': 'Esta instrucción de trabajo es aplicable a las funciones asistenciales del personal de salud del Hospital Santa Margarita en todo paciente hospitalizado.',
    'material': ['Tarjeta de medida precautoria estándar','Guantes','Bata','Gel alcoholado','Agua','Jabón','Sanitas','Cubrebocas'],
    'desarrollo': [
        {'num':'5.1','responsable':'Personal clínico','actividad':'Realice Higiene de manos IT-UV-01.'},
        {'num':'5.2','responsable':'Personal clínico','actividad':'Coloca tarjeta roja en un lugar visible.'},
        {'num':'5.3','responsable':'Personal clínico','actividad':'Habitación: Toda habitación deberá mantenerse al menos 1m de distancia entre un paciente y otro.'},
        {'num':'5.4','responsable':'Personal clínico','actividad':'Cubrebocas y gorro: Utilice cubrebocas y gorro en caso de heridas expuestas y/o realización de curaciones.'},
        {'num':'5.5','responsable':'Personal clínico','actividad':'Colócate antes de entrar a la habitación.'},
        {'num':'5.6','responsable':'Personal clínico','actividad':'Deséchelos según corresponda RPBI.'},
        {'num':'5.7','responsable':'Personal clínico','actividad':'Bata (tela/desechable): Usa bata limpia, no estéril, de tela o desechable antes de tener cualquier contacto directo con el paciente o ante el riesgo de salpicaduras.'},
        {'num':'5.8','responsable':'Personal clínico','actividad':'No deseches la bata si no tuvo contacto con secreciones o superficies contaminadas.'},
        {'num':'5.9','responsable':'Personal clínico','actividad':'Coloca la bata en el perchero doblada hacia afuera.'},
        {'num':'5.10','responsable':'Personal clínico','actividad':'Desechar la bata si se tuvo contacto con secreciones o superficies contaminadas, mediante una bolsa transparente etiquetada para lavado especial.'},
        {'num':'5.11','responsable':'Personal clínico','actividad':'En el caso de batas desechables serán de un solo uso solo con agentes MDRO y/o altamente patógenos, se deberá desechar dentro de la habitación según corresponda RPBI.'},
        {'num':'5.12','responsable':'Personal clínico','actividad':'Equipo médico: Dentro de lo posible limitar a un solo paciente.'},
        {'num':'5.13','responsable':'Personal clínico','actividad':'Desinfecte todo material previo a su uso y posterior a su uso con soluciones desinfectantes autorizados, antes de ser utilizados en otro paciente.'},
        {'num':'5.14','responsable':'Personal clínico','actividad':'Transporte del paciente: Únicamente si es indispensable.'},
        {'num':'5.15','responsable':'Personal clínico','actividad':'Visitas: Permitidas, pero con restricción únicamente podrá permanecer un familiar en la habitación.'},
        {'num':'5.16','responsable':'Personal clínico','actividad':'Enseñe al paciente a realizar higiene de manos al entrar y al salir de la habitación.'},
    ],
    'riesgos': [
        {'riesgo':'Brotes de infecciones y autoinfección por no respetar medida precautoria.','barrera':'Realizar capacitación y supervisión.'},
        {'riesgo':'Carencia de insumos para aplicar medidas.','barrera':'Solicitar el apoyo a la administración para el abastecimiento de insumos.'},
    ],
    'referencias': [
        {'nombre':'Instrucción de trabajo para la higiene de manos con agua y jabón.','codigo':'IT-UV-01'},
        {'nombre':'Instrucción de trabajo para la higiene de manos con gel alcoholado.','codigo':'IT-UV-04'},
        {'nombre':'Norma Oficial Mexicana NOM-045-SSA2-2015, Para La Vigilancia Epidemiológica, Prevención Y Control De Las Infecciones Nosocomiales.','codigo':'NA'},
    ],
    'control_cambios': [
        {'version':'01','fecha':'01/06/2021','descripcion':'Alta de documento','realizado':CC_ELAB,'aprobado':CC_APR1},
        {'version':'02','fecha':'07/11/2023','descripcion':'Modificación de documento','realizado':CC_ELAB,'aprobado':CC_APR1},
        {'version':'03','fecha':'30/09/2025','descripcion':'Actualización de instrucción','realizado':CC_ELAB,'aprobado':CC_APR2},
    ],
})

# ── IT-UV-13 ──────────────────────────────────────────────────────────────
docs.append({
    'code': 'IT-UV-13',
    'alcance': 'Esta instrucción de trabajo es aplicable a las funciones asistenciales del personal de salud del Hospital Santa Margarita en todo paciente con precauciones por vector.',
    'material': ['Tarjeta de medida precautoria por vector','Gel alcoholado','Agua','Jabón','Sanitas','Cubrebocas','Pabellón'],
    'desarrollo': [
        {'num':'5.1','responsable':'Personal clínico','actividad':'Realice Higiene de manos IT-UV-01.'},
        {'num':'5.2','responsable':'Personal clínico','actividad':'Coloca tarjeta rosa en un lugar visible.'},
        {'num':'5.3','responsable':'Personal clínico','actividad':'Habitación: Toda habitación deberá mantenerse al menos 1m de distancia entre un paciente y otro.'},
        {'num':'5.4','responsable':'Personal clínico','actividad':'Debe mantenerse la puerta y ventana cerrada.'},
        {'num':'5.5','responsable':'Personal clínico','actividad':'Se coloca pabellón.'},
        {'num':'5.6','responsable':'Personal clínico','actividad':'Explique verbalmente los motivos de aislamiento al paciente y a sus familiares.'},
        {'num':'5.7','responsable':'Personal clínico','actividad':'No hay acceso de flores.'},
        {'num':'5.8','responsable':'Personal clínico','actividad':'Cubrebocas: Colócate antes de entrar a la habitación.'},
        {'num':'5.9','responsable':'Personal clínico','actividad':'Transporte del paciente: Únicamente si es indispensable.'},
        {'num':'5.10','responsable':'Personal clínico','actividad':'Visitas: Permitidas, pero con restricción únicamente podrá permanecer un familiar en la habitación.'},
        {'num':'5.11','responsable':'Personal clínico','actividad':'Enseñe al paciente a realizar higiene de manos al entrar y al salir de la habitación.'},
        {'num':'5.12','responsable':'Personal clínico','actividad':'El acceso es permitido y se le recomienda utilizar repelente contra mosquitos.'},
        {'num':'5.13','responsable':'Personal clínico','actividad':'Enseñar al familiar que no quitar el pabellón al paciente es de manera obligatoria.'},
        {'num':'5.14','responsable':'Personal clínico','actividad':'Instruya al familiar que le informe cada que salga de la habitación.'},
    ],
    'riesgos': [
        {'riesgo':'Brotes de infecciones y autoinfección por no respetar medida precautoria.','barrera':'Realizar capacitación y supervisión.'},
        {'riesgo':'Carencia de insumos para aplicar medidas.','barrera':'Solicitar el apoyo a la administración para el abastecimiento de insumos.'},
    ],
    'referencias': [
        {'nombre':'Instrucción de trabajo para la higiene de manos con agua y jabón.','codigo':'IT-UV-01'},
        {'nombre':'Instrucción de trabajo para la higiene de manos con gel alcoholado.','codigo':'IT-UV-04'},
        {'nombre':'Norma Oficial Mexicana NOM-045-SSA2-2015, Para La Vigilancia Epidemiológica, Prevención Y Control De Las Infecciones Nosocomiales.','codigo':'NA'},
    ],
    'control_cambios': [
        {'version':'01','fecha':'01/06/2021','descripcion':'Alta de documento','realizado':CC_ELAB,'aprobado':CC_APR1},
        {'version':'02','fecha':'07/11/2023','descripcion':'Modificación de documento','realizado':CC_ELAB,'aprobado':CC_APR1},
        {'version':'03','fecha':'30/09/2025','descripcion':'Actualización de instrucción','realizado':CC_ELAB,'aprobado':CC_APR2},
    ],
})

# ── IT-UV-14 ──────────────────────────────────────────────────────────────
docs.append({
    'code': 'IT-UV-14',
    'alcance': 'Esta instrucción de trabajo es aplicable a las funciones asistenciales del personal de salud del Hospital Santa Margarita en todo paciente con precaución inversa.',
    'material': ['Tarjeta de medida precautoria por inversa','Gel alcoholado','Agua','Jabón','Sanitas','Cubrebocas','Bata'],
    'desarrollo': [
        {'num':'5.1','responsable':'Personal clínico','actividad':'Realice Higiene de manos IT-UV-01.'},
        {'num':'5.2','responsable':'Personal clínico','actividad':'Coloca tarjeta lila en un lugar visible.'},
        {'num':'5.3','responsable':'Personal clínico','actividad':'Habitación: Asignar un cuarto aislado o colocar al paciente en área exclusiva para pacientes inmunodeprimidos; si esto no fuera posible deberá mantener al menos 1.5m de distancia entre un paciente y otro, y reforzar todas las medidas estándar.'},
        {'num':'5.4','responsable':'Personal clínico','actividad':'Debe mantenerse la puerta cerrada.'},
        {'num':'5.5','responsable':'Personal clínico','actividad':'Explique verbalmente los motivos de aislamiento al paciente y a sus familiares.'},
        {'num':'5.6','responsable':'Personal clínico','actividad':'Cubrebocas: Colócate antes de entrar a la habitación.'},
        {'num':'5.7','responsable':'Personal clínico','actividad':'Guantes: Usa guantes de exploración.'},
        {'num':'5.8','responsable':'Personal clínico','actividad':'Cambia los guantes después de tener contacto con secreciones o superficies.'},
        {'num':'5.9','responsable':'Personal clínico','actividad':'Bata: Usa bata limpia, no estéril, de tela antes de ingresar a la habitación.'},
        {'num':'5.10','responsable':'Personal clínico','actividad':'Equipo médico: Dentro de lo posible limitar a un solo paciente.'},
        {'num':'5.11','responsable':'Personal clínico','actividad':'Desinfecte todo material previo a su uso y posterior a su uso con soluciones desinfectantes autorizados, antes de ser utilizados en otro paciente.'},
        {'num':'5.12','responsable':'Personal clínico','actividad':'Visitas: Permitidas, pero con restricción únicamente podrá permanecer un familiar en la habitación.'},
        {'num':'5.13','responsable':'Personal clínico','actividad':'Enseñe al paciente a realizar higiene de manos al entrar y al salir de la habitación.'},
        {'num':'5.14','responsable':'Personal clínico','actividad':'Instruya al familiar que le informe cada que salga de la habitación.'},
    ],
    'riesgos': [
        {'riesgo':'Brotes de infecciones y autoinfección por no respetar medida precautoria.','barrera':'Realizar capacitación y supervisión.'},
        {'riesgo':'Carencia de insumos para aplicar medidas.','barrera':'Solicitar el apoyo a la administración para el abastecimiento de insumos.'},
    ],
    'referencias': [
        {'nombre':'Instrucción de trabajo para la higiene de manos con agua y jabón.','codigo':'IT-UV-01'},
        {'nombre':'Instrucción de trabajo para la higiene de manos con gel alcoholado.','codigo':'IT-UV-04'},
        {'nombre':'Norma Oficial Mexicana NOM-045-SSA2-2015, Para La Vigilancia Epidemiológica, Prevención Y Control De Las Infecciones Nosocomiales.','codigo':'NA'},
    ],
    'control_cambios': cc3('01/06/2021','08/09/2023'),
})

# ── IT-UV-15 ──────────────────────────────────────────────────────────────
docs.append({
    'code': 'IT-UV-15',
    'alcance': 'Esta supervisión inicia cuando el personal de epidemiología solicita al personal de enfermería, que realice la técnica de higiene de manos y termina, cuando se hace el llenado de la encuesta.',
    'material': ['Encuesta','Celular','Computadora'],
    'desarrollo': [
        {'num':'5.1','responsable':'Auxiliar de epidemiología','actividad':'Acudir a cada uno de los servicios del hospital.'},
        {'num':'5.2','responsable':'Auxiliar de epidemiología','actividad':'Realizar estudio de sombra sobre el adecuado de higiene manos, al personal: clínico, no clínico, en formación, subrogado, voluntariado y visitantes.'},
        {'num':'5.3','responsable':'Auxiliar de epidemiología','actividad':'Verificar en primera instancia que se tengan los insumos suficientes para realizar la acción.'},
        {'num':'5.4','responsable':'Auxiliar de epidemiología','actividad':'Observar que realiza la técnica adecuada y con el tiempo adecuado. Es decir que se cumplan con los 11 pasos establecidos por la Organización Mundial de la Salud (OMS), para tener unas manos seguras.'},
        {'num':'5.5','responsable':'Auxiliar de epidemiología','actividad':'Verificar en el personal clínico, que realicen su higiene de manos en los 5 momentos.'},
        {'num':'5.6','responsable':'Auxiliar de epidemiología','actividad':'Una vez observada la acción, abrir la encuesta en el celular y llenar el formulario. (El formulario FT-UV-12 se encuentra en el correo electrónico hsm.epidemiologia@gmail.com.)'},
        {'num':'5.7','responsable':'Auxiliar de epidemiología','actividad':'La base de datos se irá actualizando cada vez que se llene una encuesta nueva.'},
    ],
    'riesgos': [
        {'riesgo':'Brotes de infecciones y autoinfección por no respetar medida precautoria.','barrera':'Realizar capacitación y supervisión.'},
        {'riesgo':'Carencia de insumos para aplicar medidas.','barrera':'Solicitar el apoyo a la administración para el abastecimiento de insumos.'},
    ],
    'referencias': [
        {'nombre':'Instrucción de trabajo para la higiene de manos con agua y jabón.','codigo':'IT-UV-01'},
        {'nombre':'Instrucción de trabajo para la higiene de manos con gel alcoholado.','codigo':'IT-UV-04'},
        {'nombre':'Norma Oficial Mexicana NOM-045-SSA2-2015, Para La Vigilancia Epidemiológica, Prevención Y Control De Las Infecciones Nosocomiales.','codigo':'NA'},
        {'nombre':'Evaluación sobre la acción esencial para seguridad del paciente número 05, y Reducir el Riesgo de Infecciones Asociadas a la Atención de Salud.','codigo':'FT-UV-12'},
    ],
    'control_cambios': [
        {'version':'01','fecha':'01/06/2021','descripcion':'Alta de documento','realizado':CC_ELAB,'aprobado':CC_APR1},
        {'version':'02','fecha':'08/09/2023','descripcion':'Modificación de documento','realizado':CC_ELAB,'aprobado':CC_APR1},
        {'version':'03','fecha':'30/09/2025','descripcion':'Actualización de instrucción','realizado':CC_ELAB,'aprobado':CC_APR2},
    ],
})

# ── IT-UV-16 ──────────────────────────────────────────────────────────────
docs.append({
    'code': 'IT-UV-16',
    'alcance': 'Esta actividad inicia desde la identificación de casos probables de enfermedades sujetas a vigilancia epidemiológica y termina cuando se confirma la recepción de la notificación por parte de las autoridades de la Región Sanitaria XIII.',
    'material': ['Censos diarios de atención hospitalaria y de urgencias','Estudios Epidemiológicos','Computadora'],
    'desarrollo': [
        {'num':'5.1','responsable':'Auxiliar de epidemiología','actividad':'Cada miércoles de cada semana se hace la notificación de los casos de interés epidemiológico a la Región Sanitaria XIII correspondiente a este hospital.'},
        {'num':'5.2','responsable':'Auxiliar de epidemiología','actividad':'Se revisan todas las fuentes de información para recabar casos de interés epidemiológico, correspondiente a la semana epidemiológica. (La semana a notificar será una previa).'},
        {'num':'5.3','responsable':'Auxiliar de epidemiología','actividad':'Las fuentes de información a revisar serán: censos diarios de pacientes hospitalizados, registro de atención de urgencias y estudios epidemiológicos.'},
        {'num':'5.5','responsable':'Auxiliar de epidemiología','actividad':'Se revisa el total de diagnósticos registrados en cada una de las bases de datos y se seleccionan aquéllos que sean sujetos a vigilancia epidemiológica, esto es, que se encuentren incluidos en el formato SUIVE-1-2019.'},
        {'num':'5.6','responsable':'Auxiliar de epidemiología','actividad':'Los casos se cuantificarán basándose en diagnóstico, grupo de edad y sexo.'},
        {'num':'5.7','responsable':'Auxiliar de epidemiología','actividad':'El llenado del formato SUIVE-1-2019 se llevará a cabo en forma electrónica.'},
        {'num':'5.8','responsable':'Auxiliar de epidemiología','actividad':'Una vez llenado se guarda con el nombre: SUIVE y el número de la semana epidemiológica que se informa.'},
        {'num':'5.9','responsable':'Auxiliar de epidemiología','actividad':'Se envía el archivo electrónico del SUIVE, por correo electrónico a la Región Sanitaria Centro Guadalajara XIII, al siguiente correo: suiveregionxiii@hotmail.com'},
        {'num':'5.10','responsable':'Auxiliar de epidemiología','actividad':'Cuando el personal de la Región Sanitaria XIII envía el acuse de recibido, éste se imprime y se archiva en la carpeta nombrada "Censo diario", la cual se encuentra en el archivo de la oficina de la UVEH.'},
    ],
    'riesgos': [
        {'riesgo':'Envío extemporáneo de notificación de SUIVE al correo electrónico.','barrera':'Comunicación continua con la región sanitaria para cualquier imprevisto.'},
    ],
    'referencias': [
        {'nombre':'Norma Oficial Mexicana NOM-045-SSA2-2005, Para la vigilancia epidemiológica, prevención y control de las infecciones nosocomiales.','codigo':'NA'},
        {'nombre':'Norma Oficial Mexicana NOM-017-SSA2-2012, Para la vigilancia epidemiológica.','codigo':'NA'},
        {'nombre':'Manual de Procedimientos Estandarizados para la notificación Convencional de Casos Nuevos de Enfermedad. Secretaría de Salud, 2015, México.','codigo':'NA'},
    ],
    'control_cambios': [
        {'version':'01','fecha':'01/06/2021','descripcion':'Alta de documento','realizado':CC_ELAB,'aprobado':CC_APR1},
        {'version':'02','fecha':'30/09/2025','descripcion':'Actualización de instrucción','realizado':CC_ELAB,'aprobado':CC_APR2},
    ],
})

# ── IT-UV-17 ──────────────────────────────────────────────────────────────
docs.append({
    'code': 'IT-UV-17',
    'alcance': 'Esta actividad consiste en realizar la búsqueda de casos de enfermedades sujetas a vigilancia epidemiológica y de infecciones hospitalarias, y termina cuando se notifica a la Región Sanitaria XIII mediante el estudio epidemiológico.',
    'material': ['Censos diarios de atención hospitalaria y de urgencias','Formato electrónico SUIVE-1-2019','Estudios Epidemiológicos','Computadora'],
    'desarrollo': [
        {'num':'5.1','responsable':'Auxiliar de epidemiología','actividad':'Realiza la búsqueda de enfermedades sujetas a vigilancia epidemiológica y de infecciones hospitalarias, en primera instancia diariamente y por la mañana se solicita en el servicio de admisión un censo de pacientes hospitalizados, se identifican las habitaciones ocupadas, así como los pacientes de nuevo ingreso.'},
        {'num':'5.2','responsable':'Auxiliar de epidemiología','actividad':'Después se accede al censo electrónico del Hospital Santa Margarita para conocer los diagnósticos de los nuevos ingresos: MEDIST/ADMISION, TRANSFERENCIA Y ALTA/CONSULTA/CENSO DE PACIENTES POR DEPENDENCIA.'},
        {'num':'5.3','responsable':'Auxiliar de epidemiología','actividad':'Revisar el Censo Médico diario para estar al tanto de la evolución de los pacientes hospitalizados.'},
        {'num':'5.4','responsable':'Auxiliar de epidemiología','actividad':'Se acude al servicio de urgencias y los servicios de hospitalización (Planta Baja, Alta, Juan Pablo II, Ginecología, Terapia Intensiva, Cuneros, UCIN, pediatría) a revisar los expedientes detenidamente.'},
        {'num':'5.5','responsable':'Auxiliar de epidemiología','actividad':'Después se visita el Laboratorio, para revisar los resultados de exámenes y muestras.'},
        {'num':'5.6','responsable':'Auxiliar de epidemiología','actividad':'En caso de identificar alguna enfermedad o infección de interés epidemiológico, se realiza el llenado del estudio de caso y se notifica a la región sanitaria y al jefe de epidemiología mediante los correos electrónicos correspondientes.'},
        {'num':'5.7','responsable':'Auxiliar de epidemiología','actividad':'Se sacan copia del estudio epidemiológico y se envía de manera física a la Región Sanitaria XIII.'},
        {'num':'5.8','responsable':'Auxiliar de epidemiología','actividad':'Una vez sellado de recibido, se archiva el estudio epidemiológico en la carpeta correspondiente.'},
    ],
    'riesgos': [
        {'riesgo':'Detectar de manera tardía enfermedad y/o infección de notificación inmediata.','barrera':'Personal capacitado y con habilidades en el área de UVEH.'},
    ],
    'referencias': [
        {'nombre':'Norma Oficial Mexicana NOM-045-SSA2-2005, Para la vigilancia epidemiológica, prevención y control de las infecciones nosocomiales.','codigo':'NA'},
        {'nombre':'Norma Oficial Mexicana NOM-017-SSA2-2012, Para la vigilancia epidemiológica.','codigo':'NA'},
        {'nombre':'Formato electrónico SUIVE-1-2019.','codigo':'NA'},
    ],
    'control_cambios': cc3('01/06/2021','08/09/2023'),
})

# ── IT-UV-18 ──────────────────────────────────────────────────────────────
docs.append({
    'code': 'IT-UV-18',
    'alcance': 'Esta actividad comienza cuando se analiza los diagnósticos de los pacientes hospitalizados de los diferentes servicios y finaliza cuando se llena formato de evaluación de medidas precautorias.',
    'material': ['Formato de seguimiento de pacientes','Lapicera','Celular'],
    'desarrollo': [
        {'num':'5.1','responsable':'Auxiliar de epidemiología','actividad':'Se realizará vigilancia activa (IT-UV-17).'},
        {'num':'5.2','responsable':'Auxiliar de epidemiología','actividad':'Una vez revisado cada uno de los diagnósticos, se designa qué tipo de medidas precautoria debe tener cada paciente (Estándar, Contacto, Gota, Aérea e Inversa). Nota: La medida precautoria cambiará dependiendo de la evolución del paciente.'},
        {'num':'5.3','responsable':'Auxiliar de epidemiología','actividad':'Se visita todos los servicios de hospitalización y se comienza a evaluar las medidas. En cada central de enfermería existe un manual de Indicaciones de Medidas Precautorias, así como cuadro ilustrativo, en el cual se resume y orienta al personal a tomar la decisión correcta.'},
        {'num':'5.4','responsable':'Auxiliar de epidemiología','actividad':'Se evaluará también que tomen las medidas de protección descritas en cada medida. En caso de ser incorrecta se llama la atención y se explica el porqué del cambio; en caso de no poner ninguna medida se hace la notificación al enfermero a cargo, o al jefe de enfermería para dar seguimiento.'},
        {'num':'5.5','responsable':'Auxiliar de epidemiología','actividad':'Se toma evidencia a través de fotografía en caso de no cumplir con esta instrucción.'},
    ],
    'riesgos': [
        {'riesgo':'Desconocimiento del personal clínico de las medidas precautorias hospitalarias.','barrera':'Capacitación continua al personal clínico y nuevo ingreso.'},
        {'riesgo':'Omisión de instrucción del trabajo.','barrera':'Supervisión continua a que se realice el proceso.'},
    ],
    'referencias': [
        {'nombre':'Norma Oficial Mexicana NOM-045-SSA2-2005, Para la vigilancia epidemiológica, prevención y control de las infecciones nosocomiales.','codigo':'NA'},
        {'nombre':'Medidas precautorias.','codigo':'FT-UV 05'},
        {'nombre':'Precauciones por contacto.','codigo':'IT-UV-08'},
        {'nombre':'Precauciones vía aéreas.','codigo':'IT-UV-09'},
        {'nombre':'Precauciones por gota.','codigo':'IT-UV-11'},
        {'nombre':'Precauciones estándar.','codigo':'IT-UV-12'},
        {'nombre':'Precauciones por vector.','codigo':'IT-UV-13'},
        {'nombre':'Precauciones MDRO.','codigo':'IT-UV-24'},
        {'nombre':'Precauciones inversas.','codigo':'IT-UV-14'},
    ],
    'control_cambios': cc3('01/06/2021','08/09/2023'),
})

# ── IT-UV-19 ──────────────────────────────────────────────────────────────
docs.append({
    'code': 'IT-UV-19',
    'alcance': 'Esta actividad inicia cuando el personal de Epidemiología supervisa en cada área los contenedores de punzocortantes y termina cuando hace el llenado de la bitácora de supervisión y toma evidencia si hubiera alguna incidencia.',
    'material': ['Bitácora de Supervisión','Lapicera','Guantes','Celular'],
    'desarrollo': [
        {'num':'5.1','responsable':'Auxiliar de epidemiología','actividad':'Toma formato para hacer la evaluación de uso y desecho de punzocortantes, y lapicera para hacer llenado.'},
        {'num':'5.2','responsable':'Auxiliar de epidemiología','actividad':'Pasa a todas las áreas a supervisar la clasificación adecuada de Punzocortantes, Bolsa Roja (Material Contaminado) y que no sobrepase el 80% de la capacidad del contenedor.'},
        {'num':'5.3','responsable':'Auxiliar de epidemiología','actividad':'Revisa minuciosamente cada contenedor.'},
        {'num':'5.4','responsable':'Auxiliar de epidemiología','actividad':'Si se percata de algún incidente, se toma fotografía como evidencia.'},
        {'num':'5.5','responsable':'Auxiliar de epidemiología','actividad':'Se informa al responsable de área, para notificarle la incidencia y buscar el responsable.'},
        {'num':'5.6','responsable':'Auxiliar de epidemiología','actividad':'Se avisa al departamento de Seguridad e Higiene y Medio Ambiente de la incidencia para que le dé seguimiento. Nota: si los contenedores rebasan más del 80% se notificará a mantenimiento para el cambio de contenedor.'},
    ],
    'riesgos': [
        {'riesgo':'Desconocimiento del personal clínico para la clasificación de los punzocortantes.','barrera':'Capacitación continua al personal clínico y nuevo ingreso del manejo de punzocortantes.'},
        {'riesgo':'Accidentes por punzocortantes por mala técnica de desechar los objetos punzocortantes (encapuchado).','barrera':'Supervisión continua de manejo de punzocortantes y seguimiento al colaborador en caso de accidente.'},
    ],
    'referencias': [
        {'nombre':'Norma Oficial Mexicana NOM-045-SSA2-2005, Para la vigilancia epidemiológica, prevención y control de las infecciones nosocomiales.','codigo':'NA'},
        {'nombre':'Norma Oficial Mexicana NOM-017-SSA2-2012, Para la vigilancia epidemiológica.','codigo':'NA'},
        {'nombre':'Norma Oficial Mexicana NOM-087-ECOL-SSA1-2002, Protección ambiental - Salud ambiental - Residuos peligrosos biológico-infecciosos - Clasificación y especificaciones de manejo.','codigo':'NA'},
    ],
    'control_cambios': cc3('01/06/2021','08/09/2023', d3='Actualización de instrucción'),
})

# ── IT-UV-20 ──────────────────────────────────────────────────────────────
docs.append({
    'code': 'IT-UV-20',
    'alcance': 'Esta actividad inicia cuando el personal de Epidemiología supervisa en cada área los refrigeradores de medicamentos y termina cuando hace el llenado de la bitácora de supervisión y toma evidencia si hubiera alguna incidencia.',
    'material': ['Bitácora de Supervisión','Lapicera','Celular'],
    'desarrollo': [
        {'num':'5.1','responsable':'Auxiliar de epidemiología','actividad':'Toma formato para hacer de supervisión de refrigeradores de medicamentos (FT-UV-22).'},
        {'num':'5.2','responsable':'Auxiliar de epidemiología','actividad':'Supervisa todas las áreas donde hay refrigeradores para medicamentos.'},
        {'num':'5.3','responsable':'Auxiliar de epidemiología','actividad':'Revisa minuciosamente cada refrigerador.'},
        {'num':'5.4','responsable':'Auxiliar de epidemiología','actividad':'Se evalúa limpieza y bitácora de temperatura.'},
        {'num':'5.5','responsable':'Auxiliar de epidemiología','actividad':'Si se percata de algún incidente, se toma fotografía como evidencia.'},
        {'num':'5.6','responsable':'Auxiliar de epidemiología','actividad':'Se informa al responsable de área, para notificarle la incidencia y buscar soluciones al problema.'},
        {'num':'5.7','responsable':'Auxiliar de epidemiología','actividad':'Se informa al departamento de farmacovigilancia para que le dé seguimiento a las incidencias.'},
    ],
    'riesgos': [
        {'riesgo':'Riesgo de contaminación a medicamentos y por ende riesgo de infección a pacientes que se le suministran.','barrera':'Supervisión continua y cultivos de superficies monitoreo.'},
    ],
    'referencias': [
        {'nombre':'Norma Oficial Mexicana NOM-045-SSA2-2005, Para la vigilancia epidemiológica, prevención y control de las infecciones nosocomiales.','codigo':'NA'},
        {'nombre':'Supervisión de centrales y áreas.','codigo':'FT-UV-22'},
    ],
    'control_cambios': cc3('01/06/2021','08/09/2023', d3='Actualización de instrucción'),
})

# ── IT-UV-22 ──────────────────────────────────────────────────────────────
docs.append({
    'code': 'IT-UV-22',
    'alcance': 'Esta actividad inicia cuando el personal de epidemiología revisa el calendario mensual de supervisiones y termina cuando el jefe de epidemiología presenta ante el Comité para la Detección y Control de Infecciones Asociadas a la Atención de la Salud (CODECIAAS).',
    'material': ['Bitácora de Supervisión','Lapicera','Celular'],
    'desarrollo': [
        {'num':'5.1','responsable':'Auxiliar de epidemiología','actividad':'Revisar el calendario de supervisiones que se realiza de manera mensual.'},
        {'num':'5.2','responsable':'Auxiliar de epidemiología','actividad':'Toma bitácora de supervisión correspondiente al calendario.'},
        {'num':'5.3','responsable':'Auxiliar de epidemiología','actividad':'Acude al área correspondiente a supervisar.'},
        {'num':'5.4','responsable':'Auxiliar de epidemiología','actividad':'Se realiza recorrido del área, observando los puntos a evaluar.'},
        {'num':'5.5','responsable':'Auxiliar de epidemiología','actividad':'Se llena bitácora de supervisión y se toma evidencia en caso de que se encuentre.'},
        {'num':'5.6','responsable':'Jefe de epidemiología','actividad':'Revisa la bitácora de supervisión realizada y sugiere medidas pertinentes para mejorar el área. Nota: En caso de tratarse de situaciones extraordinarias, se presenta en el CODECIAAS.'},
        {'num':'5.7','responsable':'CODECIAAS','actividad':'Se presentan las evidencias encontradas en las supervisiones que ponen en riesgo la salud de los pacientes, familiares y colaboradores del hospital.'},
        {'num':'5.8','responsable':'CODECIAAS','actividad':'Propone medidas preventivas y gestiona el recurso para la mejora del área.'},
    ],
    'riesgos': [
        {'riesgo':'Riesgo de infección en pacientes, familiares y colaboradores.','barrera':'Supervisión continua de todas las áreas y los procesos que puedan influir en la adquisición de infecciones hospitalarias.'},
        {'riesgo':'Limitaciones al acceso al área el día de supervisión.','barrera':'Flexibilidad para re agendar en el calendario de supervisión.'},
        {'riesgo':'Incomodidad del personal por la supervisión.','barrera':'Fomentar y crear conciencia de la importancia de las supervisiones para el beneficio del paciente, familiar y colaborador.'},
    ],
    'referencias': [
        {'nombre':'Norma Oficial Mexicana NOM-045-SSA2-2005, Para la vigilancia epidemiológica, prevención y control de las infecciones nosocomiales.','codigo':'NA'},
        {'nombre':'Supervisión de centrales y áreas.','codigo':'FT-UV-22'},
    ],
    'control_cambios': [
        {'version':'01','fecha':'23/12/2021','descripcion':'Alta de documento','realizado':CC_ELAB,'aprobado':CC_APR1},
        {'version':'02','fecha':'07/11/2023','descripcion':'Modificación del documento','realizado':CC_ELAB,'aprobado':CC_APR1},
        {'version':'03','fecha':'30/09/2025','descripcion':'Actualización de instrucción','realizado':CC_ELAB,'aprobado':CC_APR2},
    ],
})

# ── IT-UV-23 ──────────────────────────────────────────────────────────────
docs.append({
    'code': 'IT-UV-23',
    'alcance': 'Esta actividad inicia cuando el personal de epidemiología realiza vigilancia activa y seguimiento de pacientes y termina cuando se analizan las infecciones ante el Comité para la Detección y Control de Infecciones Asociadas a la Atención de la Salud (CODECIAAS).',
    'material': ['Expedientes de paciente','Bitácora de bacteriología','Estudio de caso','Lapicera'],
    'desarrollo': [
        {'num':'5.1','responsable':'Auxiliar de epidemiología','actividad':'Se realiza vigilancia activa (IT-UV-17) con el fin de detectar signos y síntomas que se atribuyen a infecciones asociadas a la atención de salud (IAAS).'},
        {'num':'5.2','responsable':'Auxiliar de epidemiología','actividad':'Se revisa diariamente la bitácora de bacteriología. En caso de detectar crecimiento en los cultivos y hemocultivos de los pacientes, se procede a analizar el caso.'},
        {'num':'5.3','responsable':'Auxiliar de epidemiología','actividad':'Se revisa el expediente completo del paciente, con el fin de definir si la infección corresponde a una IAAS o no. Para considerarse IAAS, las infecciones deben ser contraídas por un paciente durante su tratamiento en un hospital. Deben pasar 48 a 72 horas de ingreso al hospital para que se manifieste una infección hospitalaria.'},
        {'num':'5.4','responsable':'Auxiliar de epidemiología','actividad':'Se llena "Formato de Estudio de caso de Infecciones Asociadas a la Atención de Salud (IAAS)" la cual reporta a la Red Hospitalaria de Vigilancia Epidemiológica (RHOVE).'},
        {'num':'5.5','responsable':'Jefe de epidemiología','actividad':'Revisa y aprueba el estudio de caso.'},
        {'num':'5.6','responsable':'Auxiliar de epidemiología','actividad':'Notifica a Región Sanitaria XIII el estudio de caso a través del correo silvia.medina@jalisco.gob.mx y se notifica en Sistema único de información para la vigilancia epidemiológica (SUIVE). IT-UV-16.'},
        {'num':'5.7','responsable':'Auxiliar de epidemiología','actividad':'Se captura en base de datos.'},
        {'num':'5.8','responsable':'Jefe de epidemiología','actividad':'De manera mensual realiza análisis de las infecciones detectadas y trimestral se presenta ante el Comité de Prevención y Control de Infecciones (CODECIN).'},
        {'num':'5.9','responsable':'CODECIAAS','actividad':'Los miembros del Comité realizan análisis de la situación y se comprometen a mejorar los procesos.'},
    ],
    'riesgos': [
        {'riesgo':'Reporte tardío de cultivos de pacientes, por parte de laboratorio clínico.','barrera':'Monitoreo diario y comunicación continua con la jefatura de laboratorio.'},
        {'riesgo':'Retraso en la actualización de notas evolución.','barrera':'Comunicación con dirección médica para resolución del problema.'},
        {'riesgo':'Omisión de procesos clínicos y no clínicos hacia el paciente.','barrera':'Supervisión constante del personal involucrado en la atención del paciente.'},
    ],
    'referencias': [
        {'nombre':'Norma Oficial Mexicana NOM-045-SSA2-2005, Para la vigilancia epidemiológica, prevención y control de las infecciones nosocomiales.','codigo':'NA'},
        {'nombre':'Formato de estudio de caso de infecciones asociadas a la atención de salud (IAAS).','codigo':'NA'},
        {'nombre':'Sistema único de información para la vigilancia epidemiológica (SUIVE).','codigo':'IT-UV-16'},
        {'nombre':'Vigilancia epidemiológica activa.','codigo':'IT-UV-17'},
    ],
    'control_cambios': [
        {'version':'01','fecha':'23/12/2021','descripcion':'Alta de documento','realizado':CC_ELAB,'aprobado':CC_APR1},
        {'version':'02','fecha':'07/11/2023','descripcion':'Modificación del documento','realizado':CC_ELAB,'aprobado':CC_APR1},
        {'version':'03','fecha':'30/09/2025','descripcion':'Actualización de instrucción','realizado':CC_ELAB,'aprobado':CC_APR2},
    ],
})

# ── IT-UV-24 ──────────────────────────────────────────────────────────────
docs.append({
    'code': 'IT-UV-24',
    'alcance': 'Esta instrucción de trabajo es aplicable a las funciones asistenciales del personal de salud que tienen contacto con pacientes con aislamiento de microorganismos multidrogorresistentes.',
    'material': ['Tarjeta de medida precautoria MDRO color naranja','Guantes','Bata','Gel alcoholado','Agua','Jabón','Sanitas','Cubrebocas'],
    'desarrollo': [
        {'num':'5.1','responsable':'Personal clínico','actividad':'Coloque tarjeta naranja visible.'},
        {'num':'5.2','responsable':'Personal clínico','actividad':'Explique al usuario verbalmente los motivos del aislamiento y a sus familiares.'},
        {'num':'5.3','responsable':'Personal clínico','actividad':'Se asigna habitación y/o cubículo aislado.'},
        {'num':'5.4','responsable':'Personal clínico','actividad':'Uso de Guantes: Realizar higiene de manos (IT-UV-01).'},
        {'num':'5.5','responsable':'Personal clínico','actividad':'Usar guantes estériles durante el contacto directo con el paciente.'},
        {'num':'5.6','responsable':'Personal clínico','actividad':'Cambia estos posteriormente al tener contacto con secreciones o superficies contaminadas.'},
        {'num':'5.7','responsable':'Personal clínico','actividad':'Tira los guantes según corresponda RPBI (bolsa Roja) dentro de la habitación.'},
        {'num':'5.8','responsable':'Personal clínico','actividad':'Lávate las manos en los cinco momentos de atención al paciente.'},
        {'num':'5.9','responsable':'Personal clínico','actividad':'No reutilizar guantes en ningún momento.'},
        {'num':'5.10','responsable':'Personal clínico','actividad':'Bata (tela/desechable): Usa bata limpia, no estéril, de tela o desechable antes de tener cualquier contacto directo con el paciente o ante el riesgo de salpicaduras.'},
        {'num':'5.12','responsable':'Personal clínico','actividad':'No deseches la bata si no tuvo contacto con secreciones o superficies contaminadas.'},
        {'num':'5.13','responsable':'Personal clínico','actividad':'Coloca la bata en el perchero doblada hacia afuera.'},
        {'num':'5.14','responsable':'Personal clínico','actividad':'Desechar la bata si se tuvo contacto con secreciones o superficies contaminadas, mediante una bolsa transparente etiquetada para lavado especial.'},
        {'num':'5.15','responsable':'Personal clínico','actividad':'En el caso de batas desechables serán de un solo uso solo con agentes MDRO y/o altamente patógenos, se deberá desechar dentro de la habitación según corresponda RPBI.'},
        {'num':'5.16','responsable':'Personal clínico','actividad':'Cubre bocas (mascarilla Facial): Colócate cubrebocas ante riesgo de salpicaduras.'},
        {'num':'5.17','responsable':'Personal clínico','actividad':'Lávate las manos en los cinco momentos de atención al paciente.'},
        {'num':'5.18','responsable':'Personal clínico','actividad':'Deséchalo según corresponda RPBI.'},
        {'num':'5.19','responsable':'Personal clínico','actividad':'Realizar higiene de manos en sus cinco momentos de higiene de manos en la atención al paciente.'},
        {'num':'5.20','responsable':'Personal clínico','actividad':'Equipo médico: Uso exclusivo del equipo.'},
        {'num':'5.21','responsable':'Personal clínico','actividad':'Desinfecte todo material previo a su uso y posterior a su uso con soluciones desinfectantes autorizados.'},
        {'num':'5.22','responsable':'Personal clínico','actividad':'Transporte del paciente: Únicamente si es indispensable. Respeta en todo momento la medida de MDRO.'},
        {'num':'5.23','responsable':'Personal clínico','actividad':'Utiliza bata y guantes si se tiene contacto directo o en riesgo de salpicadura.'},
        {'num':'5.24','responsable':'Personal clínico','actividad':'Visitas: Permitidas, pero con restricción únicamente podrá permanecer un familiar en la habitación.'},
        {'num':'5.25','responsable':'Personal clínico','actividad':'Eduque al familiar sobre la higiene de manos, colocación de bata y cubrebocas. Informe sobre no compartir objetos personales.'},
        {'num':'5.26','responsable':'Personal clínico','actividad':'Cultivo: Al egreso del paciente se toma cultivo de superficie de la habitación.'},
        {'num':'5.27','responsable':'Personal clínico','actividad':'Se toma cultivo de superficie al equipo biomédico.'},
    ],
    'riesgos': [
        {'riesgo':'Omisión de precauciones por parte del personal clínico.','barrera':'Realizar capacitación sobre la importancia de las precauciones por MDRO.'},
        {'riesgo':'Brotes de infecciones en pacientes y autoinfección en el personal.','barrera':'Supervisión de la correcta aplicación de la medida.'},
    ],
    'referencias': [
        {'nombre':'Norma Oficial Mexicana NOM-045-SSA2-2005, Para la vigilancia epidemiológica, prevención y control de las infecciones nosocomiales.','codigo':'NA'},
        {'nombre':'Higiene de manos con agua y jabón.','codigo':'IT-UV-01'},
        {'nombre':'Colocación correcta de bata.','codigo':'IT-UV-05'},
        {'nombre':'Colocación correcta del cubrebocas.','codigo':'IT-UV-06'},
    ],
    'control_cambios': [
        {'version':'01','fecha':'30/08/2024','descripcion':'Alta de documento','realizado':CC_ELAB,'aprobado':CC_APR1},
        {'version':'02','fecha':'30/09/2025','descripcion':'Actualización de instrucción','realizado':CC_ELAB,'aprobado':CC_APR2},
    ],
})

# ── Generate SQL ──────────────────────────────────────────────────────────
sql_lines = []
sql_lines.append("-- ============================================================")
sql_lines.append("--  UV IT — Contenido de 20 instrucciones de trabajo")
sql_lines.append("--  Hospital Santa Margarita · SGC ISO 9001:2015")
sql_lines.append("-- ============================================================\n")

for d in docs:
    code = d['code']
    alcance = esc(d['alcance'])
    material = j(d['material'])
    desarrollo = j(d['desarrollo'])
    riesgos = j(d['riesgos'])
    referencias = j(d['referencias'])
    cc = j(d['control_cambios'])

    sql_lines.append(f"-- {code}")
    sql_lines.append(f"""INSERT INTO document_content (
  document_id, alcance, objetivo,
  material_equipo, desarrollo, gestion_riesgos,
  referencias, control_cambios,
  definiciones, responsabilidades)
SELECT
  (SELECT id FROM documents WHERE code = '{code}'),
  '{alcance}',
  '{alcance}',
  '{esc(material)}'::jsonb,
  '{esc(desarrollo)}'::jsonb,
  '{esc(riesgos)}'::jsonb,
  '{esc(referencias)}'::jsonb,
  '{esc(cc)}'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb
ON CONFLICT (document_id) DO UPDATE SET
  alcance=EXCLUDED.alcance, objetivo=EXCLUDED.objetivo,
  material_equipo=EXCLUDED.material_equipo, desarrollo=EXCLUDED.desarrollo,
  gestion_riesgos=EXCLUDED.gestion_riesgos, referencias=EXCLUDED.referencias,
  control_cambios=EXCLUDED.control_cambios,
  definiciones=EXCLUDED.definiciones, responsabilidades=EXCLUDED.responsabilidades;
""")

out_path = "/Users/soov/Documents/STA MAGO/sgc-web/sql/uv_it_content.sql"
with open(out_path, 'w', encoding='utf-8') as f:
    f.write('\n'.join(sql_lines))

print(f"✓ {out_path}")
print(f"  IT docs con contenido: {len(docs)}")
