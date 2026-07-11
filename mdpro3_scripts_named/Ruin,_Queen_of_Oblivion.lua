--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Ruin, Queen of Oblivion  (ID: 46427957)
-- Type: Monster / Effect / Ritual
-- Attribute: LIGHT
-- Race: Fairy
-- Level: 8
-- ATK 2300 | DEF 2000
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can Ritual Summon this card with "End of the World".
-- When this attacking card destroys an opponent's monster by battle: You can activate this effect;
-- this card can make a second attack in a row.
--[[ __CARD_HEADER_END__ ]]

--破滅の女神ルイン
function c46427957.initial_effect(c)
	aux.AddCodeList(c,8198712)
	c:EnableReviveLimit()
	--chain attack
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(46427957,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCondition(c46427957.atcon)
	e1:SetOperation(c46427957.atop)
	c:RegisterEffect(e1)
end
function c46427957.atcon(e,tp,eg,ep,ev,re,r,rp)
	return aux.bdocon(e,tp,eg,ep,ev,re,r,rp) and e:GetHandler():IsChainAttackable()
end
function c46427957.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChainAttack()
end
