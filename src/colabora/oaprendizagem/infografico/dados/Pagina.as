package colabora.oaprendizagem.infografico.dados 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author Lucas S. Junqueira
	 */
	public class Pagina extends EventDispatcher
	{
		
		/**
		 * Imagens desta página.
		 */
		public var imagens:Vector.<Imagem>;
		
		/**
		 * Número da página.
		 */
		public var numero:int;
		
		/**
		 * Referência à imagem a ser tratada.
		 */
		public var refImagem:Imagem;
		
		public function Pagina(num:int) 
		{
			// criando vairáveis
			this.imagens = new Vector.<Imagem>();
			this.numero = num;
		}
		
		// SOMENTE LEITURA
		
		/**
		 * Informações sobre a página.
		 */
		public function get dados():Object
		{
			var retorno:Object = new Object();
			retorno.numero = this.numero;
			retorno.imagens = new Vector.<Object>();
			for (var i:int = 0; i < this.imagens.length; i++) {
				if (this.imagens[i].valida) retorno.imagens.push(this.imagens[i].dados);
			}
			return (retorno);
		}
		
		// FUNÇÕES PÚBLICAS
		
		/**
		 * Carrega informações de uma página.
		 * @param	dados	informações da página
		 */
		public function carregaDados(dados:Object):void
		{
			this.numero = dados.numero as int;
			if (dados.imagens != null) {
				for (var i:int = 0; i < dados.imagens.length; i++) {
					this.adicionaImagem(dados.imagens[i].info as String, dados.imagens[i].tipo as String, dados.imagens[i].fonte as String, dados.imagens[i]);
				}
			}
		}
		
		/**
		 * Adiciona uma imagem à página.
		 * @param	inf	informação (arquivo ou texto)
		 * @param	tp	tipo (tx, bb ou im)
		 * @param	ft	fonte
		 * @param	dd	objeto de inicialização
		 */
		public function adicionaImagem(inf:String, tp:String, ft:String = '', dd:Object = null):void
		{
			if (dd != null) {
				this.imagens.push(new Imagem((dd.info as String), (dd.tipo as String), (dd.ordem as int), (dd.fonte as String), dd));
				if ((dd.tipo as String) != 'tx') {
					this.imagens[this.imagens.length - 1].addEventListener(Event.COMPLETE, onImComplete);
					this.imagens[this.imagens.length - 1].addEventListener(Event.CANCEL, onImCancel);
				} else {
					this.refImagem = this.imagens[this.imagens.length - 1];
					this.dispatchEvent(new Event(Event.COMPLETE));
				}
			} else {
				this.imagens.push(new Imagem(inf, tp, this.imagens.length, ft, null));
				if (tp != 'tx') {
					this.imagens[this.imagens.length - 1].addEventListener(Event.COMPLETE, onImComplete);
					this.imagens[this.imagens.length - 1].addEventListener(Event.CANCEL, onImCancel);
				} else {
					this.refImagem = this.imagens[this.imagens.length - 1];
					this.dispatchEvent(new Event(Event.COMPLETE));
				}
			}
		}
		
		/**
		 * Libera recursos usados por este objeto.
		 */
		public function dispose():void {
			// limpando variáveis
			this.refImagem = null;
			// removendo imagens
			while (this.imagens.length > 0) {
				var img:Imagem = this.imagens.shift();
				if (img.parent != null) img.parent.removeChild(img);
				if (img.hasEventListener(Event.COMPLETE)) img.removeEventListener(Event.COMPLETE, onImComplete);
				if (img.hasEventListener(Event.CANCEL)) img.removeEventListener(Event.CANCEL, onImCancel);
				img.dispose();
			}
		}
		
		// FUNÇÕES PRIVADAS
		
		/**
		 * O conteúdo de uma imagem foi carregado corretamente.
		 */
		private function onImComplete(evt:Event):void
		{
			this.refImagem = evt.target as Imagem;
			this.refImagem.removeEventListener(Event.COMPLETE, onImComplete);
			this.refImagem.removeEventListener(Event.CANCEL, onImCancel);
			this.dispatchEvent(evt.clone());
		}
		
		/**
		 * Falha na carga de uma imagem.
		 */
		private function onImCancel(evt:Event):void
		{
			var imagem:Imagem = evt.target as Imagem;
			imagem.removeEventListener(Event.COMPLETE, onImComplete);
			imagem.removeEventListener(Event.CANCEL, onImCancel);
			var encontrada:int = -1;
			for (var i:int = 0; i < this.imagens.length; i++) {
				if (this.imagens[i] == imagem) encontrada = i;
			}
			if (encontrada >= 0) {
				this.imagens[encontrada].dispose();
				this.imagens.splice(encontrada, 1);
			}
		}
		
	}

}