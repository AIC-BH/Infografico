package
{
	import colabora.display.AreaImagens;
	import colabora.display.TelaSplash;
	import colabora.oaprendizagem.infografico.dados.Infografico;
	import colabora.oaprendizagem.infografico.display.AreaApp;
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.filesystem.File;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import graphic.Graficos;
	import colabora.display.Compartilhamento;
	import colabora.oaprendizagem.dados.ObjetoAprendizagem;
	
	/**
	 * ...
	 * @author Lucas S. Junqueira
	 */
	public class Main extends Sprite 
	{
		/**
		 * Fontes
		 */
		[Embed(source='./fontes/Pfennig.ttf', fontFamily='Pfennig', fontStyle='normal', fontWeight='normal', unicodeRange='U+0020-002F,U+0030-0039,U+003A-0040,U+0041-005A,U+005B-0060,U+0061-007A,U+007B-007E,U+0020,U+00A1-00FF,U+2000-206F,U+20A0-20CF,U+2100-2183', embedAsCFF='false', advancedAntiAliasing='false', mimeType="application/x-font")]
		private var PfennigRegular:Class;
		[Embed(source='./fontes/Averia.ttf', fontFamily='Averia', fontStyle='normal', fontWeight='normal', unicodeRange='U+0020-002F,U+0030-0039,U+003A-0040,U+0041-005A,U+005B-0060,U+0061-007A,U+007B-007E,U+0020,U+00A1-00FF,U+2000-206F,U+20A0-20CF,U+2100-2183', embedAsCFF='false', advancedAntiAliasing='false', mimeType="application/x-font")]
		private var AveriaRegular:Class;
		[Embed(source='./fontes/CodeNewRoman.otf', fontFamily='CodeNewRoman', fontStyle='normal', fontWeight='normal', unicodeRange='U+0020-002F,U+0030-0039,U+003A-0040,U+0041-005A,U+005B-0060,U+0061-007A,U+007B-007E,U+0020,U+00A1-00FF,U+2000-206F,U+20A0-20CF,U+2100-2183', embedAsCFF='false', advancedAntiAliasing='false', mimeType="application/x-font")]
		private var CodeNewRomanRegular:Class;
		[Embed(source='./fontes/Gamaliel.otf', fontFamily='Gamaliel', fontStyle='normal', fontWeight='normal', unicodeRange='U+0020-002F,U+0030-0039,U+003A-0040,U+0041-005A,U+005B-0060,U+0061-007A,U+007B-007E,U+0020,U+00A1-00FF,U+2000-206F,U+20A0-20CF,U+2100-2183', embedAsCFF='false', advancedAntiAliasing='false', mimeType="application/x-font")]
		private var GamalielRegular:Class;
		
		/**
		 * Informações sobre o projeto atual.
		 */
		public static var projeto:Infografico;
		
		/**
		 * Área de conteúdo.
		 */
		public static var conteudo:AreaImagens;
		
		/**
		 * Gráficos usados no app.
		 */
		public static var graficos:Graficos;
		
		/**
		 * App funcionando em um computador?
		 */
		public static var desktop:Boolean = false;
		
		/**
		 * Tela do app.
		 */
		public var appView:AreaApp;
		
		/**
		 * Tela inicial.
		 */
		private var _splash:TelaSplash;
		
		public function Main() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			// preparando acesso aos gráficos
			Main.graficos = new Graficos();
			
			// configurando app
			ObjetoAprendizagem.codigo = 'infografico';
			ObjetoAprendizagem.nome = 'Infográficos';
			ObjetoAprendizagem.compartilhamento = new Compartilhamento(
													Main.graficos.getSPGR('BTCompScan'),
													Main.graficos.getSPGR('BTCompFechar'), 
													Main.graficos.getSPGR('BTCompVoltar'), 
													Main.graficos.getSPGR('BTCompAjuda'), 
													'', 
													Main.graficos.getSPGR('MensagemErroDownload'), 
													Main.graficos.getSPGR('MensagemSucessoDownload'), 
													Main.graficos.getSPGR('MensagemAguardeDownload'));
													
			// preparando listagem da biblioteca
			var biblio:File = File.documentsDirectory.resolvePath(ObjetoAprendizagem.codigo + '/biblioteca/');
			var original:File = File.applicationDirectory.resolvePath('biblioteca/');
			original.copyToAsync(biblio, true);
													
			// criando o projeto atual
			Main.projeto = new Infografico();
			
			// criando visualização do app
			this.appView = new AreaApp();
			this.addChild(this.appView);
			this.appView.posiciona();
			
			// aplicando tela inicial
			this._splash = new TelaSplash(Main.graficos.getGR('Splash'), 5);
			this._splash.addEventListener(Event.COMPLETE, onSplash);
			this.stage.addChild(this._splash);
			
			// atualizando tamanho da tela
			this.stage.addEventListener(Event.RESIZE, onResize);
		}
		
		/**
		 * Ajustando imagem no redimensionamento da tela.
		 */
		private function onResize(evt:Event):void
		{
			this.appView.posiciona();
		}
		
		/**
		 * O tempo da tela inicial terminou.
		 */
		private function onSplash(evt:Event):void
		{
			this._splash.removeEventListener(Event.COMPLETE, onSplash);
			this._splash = null;
		}
		
		private function deactivate(e:Event):void 
		{
			// make sure the app behaves well (or exits) when in background
			//NativeApplication.nativeApplication.exit();
		}
		
	}
	
}