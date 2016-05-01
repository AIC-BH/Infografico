package colabora.oaprendizagem.infografico.display 
{
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author Lucas S. Junqueira
	 */
	public class TelaTexto extends Sprite
	{
		/**
		 * Informações sobre o texto selecionado.
		 */
		public var selecionado:Object;
		
		// VARIÁVEIS PRIVADAS
		
		private var _bg:Shape;
		private var _bgTextArea:Bitmap;
		private var _titulo:TextField;
		
		private var _btcancel:Sprite;
		private var _btok:Sprite;
		
		private var _btPfennig:Sprite;
		private var _btAveria:Sprite;
		private var _btGamaliel:Sprite;
		private var _btCodeRoman:Sprite;
		private var _fonte:String;
		
		public function TelaTexto() 
		{
			// preparando fundo
			this._bg = new Shape();
			this._bg.graphics.beginFill(AreaApp.CORBG);
			this._bg.graphics.drawRect(0, 0, AreaApp.AREAWIDTH, AreaApp.AREAHEIGHT);
			this._bg.graphics.endFill();
			this.addChild(this._bg);
			
			// área de texto
			this._bgTextArea = Main.graficos.getGR('AreaTextoTexto');
			this.addChild(this._bgTextArea);
			
			// entrada de texto
			this._titulo = new TextField();
			this._titulo.embedFonts = true;
			this._titulo.defaultTextFormat = new TextFormat('Pfennig', 40, 0);
			this._titulo.multiline = false;
			this._titulo.wordWrap = false;
			this._titulo.type = TextFieldType.INPUT;
			this._titulo.needsSoftKeyboard = true;
			this.addChild(this._titulo);
			
			// fontes
			this._btPfennig = Main.graficos.getSPGR('BTFontePfennig');
			this._btAveria = Main.graficos.getSPGR('BTFonteAveria');
			this._btGamaliel = Main.graficos.getSPGR('BTFonteGamaliel');
			this._btCodeRoman = Main.graficos.getSPGR('BTFonteCodeRoman');
			this._btPfennig.addEventListener(MouseEvent.CLICK, onPfennig);
			this._btAveria.addEventListener(MouseEvent.CLICK, onAveria);
			this._btGamaliel.addEventListener(MouseEvent.CLICK, onGamaliel);
			this._btCodeRoman.addEventListener(MouseEvent.CLICK, onCodeRoman);
			this.addChild(this._btPfennig);
			this.addChild(this._btAveria);
			this.addChild(this._btGamaliel);
			this.addChild(this._btCodeRoman);
			this._btPfennig.alpha = 1;
			this._btAveria.alpha = 0.5;
			this._btGamaliel.alpha = 0.5;
			this._btCodeRoman.alpha = 0.5;
			this._fonte = 'Pfennig';
			
			// botões ok/cancel
			this._btcancel = Main.graficos.getSPGR('BTCancel');
			this._btcancel.addEventListener(MouseEvent.CLICK, onCancel);
			this.addChild(this._btcancel);
			this._btok = Main.graficos.getSPGR('BTOk');
			this._btok.addEventListener(MouseEvent.CLICK, onOk);
			this.addChild(this._btok);
			
			// posição x
			var intervaloX:Number = (this._bg.width - (4 * this._btPfennig.width)) / 5;
			this._bgTextArea.x = (this._bg.width - this._bgTextArea.width) / 2;
			this._btPfennig.x = intervaloX;
			this._btAveria.x = this._btPfennig.x + this._btPfennig.width + intervaloX;
			this._btGamaliel.x = this._btAveria.x + this._btAveria.width + intervaloX;
			this._btCodeRoman.x = this._btGamaliel.x + this._btGamaliel.width + intervaloX;
			this._btok.x = (this._bg.width / 2) + intervaloX;
			this._btcancel.x = (this._bg.width / 2) - intervaloX - this._btcancel.width;
			
			// posição y
			var intervaloY:Number = (this._bg.height - this._bgTextArea.height - this._btPfennig.height - this._btcancel.height) / 4;
			this._bgTextArea.y = intervaloY;
			this._btPfennig.y = this._btAveria.y = this._btGamaliel.y = this._btCodeRoman.y = this._bgTextArea.y + this._bgTextArea.height + intervaloY;
			this._btcancel.y = this._btok.y = this._btPfennig.y + this._btPfennig.height + intervaloY;
			
			// posicionando caixa de texto
			this._titulo.x = this._bgTextArea.x + 140;
			this._titulo.y = this._bgTextArea.y + 35;
			this._titulo.width = 740;
			this._titulo.height = 80;
			
			// retorno
			this.selecionado = new Object();
			
			// verificando tela
			this.addEventListener(Event.ADDED_TO_STAGE, onStage);
		}
		
		// FUNÇÕES PÚBLICAS
		
		/**
		 * Define o texto mostrado.
		 * @param	tx	texto
		 * @param	ft	fonte
		 */
		public function defineTexto(tx:String, ft:String):void
		{
			this._titulo.text = tx;
			switch (ft) {
				case 'Averia':
					this.onAveria(null);
					break;
				case 'Gamaliel':
					this.onGamaliel(null);
					break;
				case 'CodeNewRoman':
					this.onCodeRoman(null);
					break;
				default:
					this.onPfennig(null);
					break;
			}
		}
		
		// FUNÇÕES PRIVADAS
		
		/**
		 * A tela ficou disponível.
		 */
		private function onStage(evt:Event):void
		{
			this._titulo.text = 'digite seu texto aqui';
			this.onPfennig(null);
		}
		
		/**
		 * Nova fonte: Pfennig.
		 */
		private function onPfennig(evt:MouseEvent):void
		{
			this._btPfennig.alpha = 1;
			this._btAveria.alpha = 0.5;
			this._btGamaliel.alpha = 0.5;
			this._btCodeRoman.alpha = 0.5;
			this._titulo.setTextFormat(new TextFormat('Pfennig', 40, 0));
			this._fonte = 'Pfennig';
		}
		
		/**
		 * Nova fonte: Averia.
		 */
		private function onAveria(evt:MouseEvent):void
		{
			this._btPfennig.alpha = 0.5;
			this._btAveria.alpha = 1;
			this._btGamaliel.alpha = 0.5;
			this._btCodeRoman.alpha = 0.5;
			this._titulo.setTextFormat(new TextFormat('Averia', 40, 0));
			this._fonte = 'Averia';
		}
		
		/**
		 * Nova fonte: Gamaliel.
		 */
		private function onGamaliel(evt:MouseEvent):void
		{
			this._btPfennig.alpha = 0.5;
			this._btAveria.alpha = 0.5;
			this._btGamaliel.alpha = 1;
			this._btCodeRoman.alpha = 0.5;
			this._titulo.setTextFormat(new TextFormat('Gamaliel', 40, 0));
			this._fonte = 'Gamaliel';
		}
		
		/**
		 * Nova fonte: Code New Roman.
		 */
		private function onCodeRoman(evt:MouseEvent):void
		{
			this._btPfennig.alpha = 0.5;
			this._btAveria.alpha = 0.5;
			this._btGamaliel.alpha = 0.5;
			this._btCodeRoman.alpha = 1;
			this._titulo.setTextFormat(new TextFormat('CodeNewRoman', 40, 0));
			this._fonte = 'CodeNewRoman';
		}
		
		/**
		 * Clique no botão cancel.
		 */
		private function onCancel(evt:MouseEvent):void
		{
			parent.removeChild(this);
			this.dispatchEvent(new Event(Event.CANCEL));
		}
		
		/**
		 * Clique no botão ok.
		 */
		private function onOk(evt:MouseEvent):void
		{
			if (this._titulo.text != '') {
				parent.removeChild(this);
				this.selecionado.texto = this._titulo.text;
				this.selecionado.fonte = this._fonte;
				this.dispatchEvent(new Event(Event.SELECT));
			}
		}
	}

}