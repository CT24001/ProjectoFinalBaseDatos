--P1 comando de prueba
SET SERVEROUTPUT ON;

BEGIN 
    adminProyecto.sp_resumen_periodo(TO_DATE('01/01/2023', 'DD/MM/YYYY'), TO_DATE('31/12/2023', 'DD/MM/YYYY')); 
END;
/
--P2 comando de prueba
SET SERVEROUTPUT ON;

BEGIN
    adminProyecto.sp_top_elementos(3);
END;
/
--P3 comando de prueba
SET SERVEROUTPUT ON;

BEGIN
    adminProyecto.sp_indicadores_categoria;
END;
/
--P4 comando de prueba
SET SERVEROUTPUT ON;

BEGIN
    adminProyecto.sp_alertas_negocio;
END;
/