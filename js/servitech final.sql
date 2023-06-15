-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 09-06-2023 a las 05:01:22
-- Versión del servidor: 5.7.36
-- Versión de PHP: 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `servitech`
--

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `sp_ingresos_usuarios_DIA`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ingresos_usuarios_DIA` ()  BEGIN
     /* 
     * Procedimiento : Oscar Aguilar Luzuriaga -----> Elaborado por Sistemas_Ecu-RedSolutions +56973868607      
     * correo electronico: oscaragui3@hotmail.com - oscaragui353@gmail.com     
     * sitio Web: www.farmaciasanasana.org/
     * 
     */ 
    DECLARE fechaHoy  DATE;
	DECLARE HoraActual varchar(16);
    SET fechaHoy=(SELECT CURDATE() as FechaHoy );
	SET HoraActual=(SELECT CURTIME() as HoraReporteEmitido);
    
    SELECT
    ing.id_ingreso as id,
    usu.nombre as UsuarioIngresa,
    usu.usuario as usuario,
    usu.password as clave,
    ing.ip as IP,
    ing.mac as MAC,
    CONCAT(ing.fecha) AS FechaActual,  
    CONCAT(HoraActual) AS HoraActual
    FROM ingreso_sistema AS ing 
    INNER JOIN usuario as usu ON ing.usuario_id=usu.id_usuario
    LEFT JOIN  rol as r ON usu.id_rol=r.id_rol
    WHERE ing.estado=1 AND usu.estado=1 AND ing.fecha=(SELECT CURDATE() as FechaHoy);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comentarios`
--

DROP TABLE IF EXISTS `comentarios`;
CREATE TABLE IF NOT EXISTS `comentarios` (
  `id_comentarios` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(20) NOT NULL,
  `descripcion` varchar(200) NOT NULL,
  `producto_id` int(10) NOT NULL,
  PRIMARY KEY (`id_comentarios`),
  KEY `FK_producto_id` (`producto_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `comentarios`
--

INSERT INTO `comentarios` (`id_comentarios`, `nombre`, `descripcion`, `producto_id`) VALUES
(1, 'oscar', 'el producto cumple con lo publicado', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ingreso_sistema`
--

DROP TABLE IF EXISTS `ingreso_sistema`;
CREATE TABLE IF NOT EXISTS `ingreso_sistema` (
  `id_ingreso` int(10) NOT NULL AUTO_INCREMENT,
  `ip` varchar(32) NOT NULL,
  `usuario_id` int(10) NOT NULL,
  `mac` varchar(17) NOT NULL,
  `fecha` date NOT NULL,
  `estado` tinyint(4) NOT NULL,
  PRIMARY KEY (`id_ingreso`),
  KEY `FK_usuario_id` (`usuario_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ingreso_sistema`
--

INSERT INTO `ingreso_sistema` (`id_ingreso`, `ip`, `usuario_id`, `mac`, `fecha`, `estado`) VALUES
(1, '190.46.220.151', 1, '98-22-EF-CE-6F-B5', '2023-06-09', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

DROP TABLE IF EXISTS `persona`;
CREATE TABLE IF NOT EXISTS `persona` (
  `id_persona` int(10) NOT NULL AUTO_INCREMENT,
  `rut` int(17) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `direccion` varchar(50) NOT NULL,
  `telefono` int(10) NOT NULL,
  `email` varchar(50) NOT NULL,
  `estado` tinyint(4) NOT NULL,
  PRIMARY KEY (`id_persona`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

DROP TABLE IF EXISTS `producto`;
CREATE TABLE IF NOT EXISTS `producto` (
  `id_producto` int(10) NOT NULL AUTO_INCREMENT,
  `codigo` int(10) NOT NULL,
  `descripcion` varchar(150) NOT NULL,
  `stock` float(12,1) NOT NULL,
  `PrecioVenta` float(12,2) NOT NULL,
  `estado` tinyint(4) NOT NULL,
  PRIMARY KEY (`id_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`id_producto`, `codigo`, `descripcion`, `stock`, `PrecioVenta`, `estado`) VALUES
(1, 145266, 'LAPTOP GAMER HP OMEN', 2.0, 150000.00, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

DROP TABLE IF EXISTS `rol`;
CREATE TABLE IF NOT EXISTS `rol` (
  `id_rol` int(10) NOT NULL AUTO_INCREMENT,
  `nombre_rol` varchar(50) NOT NULL,
  `fecha` date NOT NULL,
  PRIMARY KEY (`id_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`id_rol`, `nombre_rol`, `fecha`) VALUES
(1, 'panelCompra', '2023-06-08');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `rolesusuario`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `rolesusuario`;
CREATE TABLE IF NOT EXISTS `rolesusuario` (
`id_rol` int(10)
,`nombre_rol` varchar(50)
,`fecha` date
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

DROP TABLE IF EXISTS `usuario`;
CREATE TABLE IF NOT EXISTS `usuario` (
  `id_usuario` int(10) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `usuario` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `id_rol` int(11) NOT NULL,
  `estado` tinyint(4) NOT NULL,
  PRIMARY KEY (`id_usuario`),
  KEY `fk_id_rol` (`id_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id_usuario`, `nombre`, `email`, `usuario`, `password`, `id_rol`, `estado`) VALUES
(1, 'oscar', 'oscaragui3@hotmail.com', 'admin', 'a9b956dda0e6b609b8e48ae5edb3bbb624dc0da6', 1, 1);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `usuariologin`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `usuariologin`;
CREATE TABLE IF NOT EXISTS `usuariologin` (
`id` int(10)
,`NombreUsuario` varchar(50)
,`correo` varchar(50)
,`usuario` varchar(50)
,`clave` varchar(50)
,`status` tinyint(4)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `rolesusuario`
--
DROP TABLE IF EXISTS `rolesusuario`;

DROP VIEW IF EXISTS `rolesusuario`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `rolesusuario`  AS SELECT `r`.`id_rol` AS `id_rol`, `r`.`nombre_rol` AS `nombre_rol`, `r`.`fecha` AS `fecha` FROM `rol` AS `r` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `usuariologin`
--
DROP TABLE IF EXISTS `usuariologin`;

DROP VIEW IF EXISTS `usuariologin`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `usuariologin`  AS SELECT `usu`.`id_usuario` AS `id`, `usu`.`nombre` AS `NombreUsuario`, `usu`.`email` AS `correo`, `usu`.`usuario` AS `usuario`, `usu`.`password` AS `clave`, `usu`.`estado` AS `status` FROM ((`usuario` `usu` join `rol` `r` on((`r`.`id_rol` = `usu`.`id_rol`))) join `ingreso_sistema` `ing` on((`ing`.`usuario_id` = `usu`.`id_usuario`))) WHERE (`usu`.`estado` = 1) ;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `comentarios`
--
ALTER TABLE `comentarios`
  ADD CONSTRAINT `FK_producto_id` FOREIGN KEY (`producto_id`) REFERENCES `producto` (`id_producto`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `ingreso_sistema`
--
ALTER TABLE `ingreso_sistema`
  ADD CONSTRAINT `FK_usuario_id` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id_usuario`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `fk_id_rol` FOREIGN KEY (`id_rol`) REFERENCES `rol` (`id_rol`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
