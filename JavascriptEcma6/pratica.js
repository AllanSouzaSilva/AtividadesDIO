//Retorna o tamanho da string
const textSize = "Texto".length;
console.log("\n Quantidade de letra:  ", textSize);

//Retorna um array quebrado a string por um delimitador
const splittext = 'Texto'.split('x');
console.log("\nArray com as posições separadas pele delimitador: ", splittext);
//Busca por um valor e substitui por outro
const replacetext = 'Texto'.replace('Text','txeT');
console.log("\nSubstituição de valor:", replacetext);

// retorna a "fatia" de um valor 

const lastchar = 'Texto'.splice(-1);
console.log("\núltima letra de uma string: ", lastchar);

const allwhithoutlastchar = 'Texto'.splice(0,-1);
console.log("\n valor da string da primeira letra até a última: ", allwhithoutlastchar);

const secondToEnd = 'Texto'.slice(1);
console.log('\n valor da string da segunda letra até a útima: ', secondToEnd);