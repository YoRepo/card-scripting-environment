--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Vylon Sigma  (ID: 48370501)
-- Type: Monster / Effect / Synchro
-- Attribute: LIGHT
-- Race: Fairy
-- Level: 7
-- ATK 1800 | DEF 1000
-- Setcode: 0x30
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 LIGHT Tuner + 1 or more non-Tuner LIGHT monsters
-- When this card declares an attack, if it is the only monster you control: You can equip 1 Equip
-- Spell Card from your Deck to this face-up card.
--[[ __CARD_HEADER_END__ ]]

--ヴァイロン・シグマ
function c48370501.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_LIGHT),aux.NonTuner(Card.IsAttribute,ATTRIBUTE_LIGHT),1)
	c:EnableReviveLimit()
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(48370501,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c48370501.eqcon)
	e1:SetTarget(c48370501.eqtg)
	e1:SetOperation(c48370501.eqop)
	c:RegisterEffect(e1)
end
function c48370501.eqcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)<=1
end
function c48370501.filter(c,ec)
	return c:IsType(TYPE_EQUIP) and c:CheckEquipTarget(ec)
end
function c48370501.eqtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingMatchingCard(c48370501.filter,tp,LOCATION_DECK,0,1,nil,e:GetHandler()) end
end
function c48370501.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 or c:IsFacedown() or not c:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(48370501,1))
	local g=Duel.SelectMatchingCard(tp,c48370501.filter,tp,LOCATION_DECK,0,1,1,nil,c)
	if g:GetCount()>0 then
		Duel.Equip(tp,g:GetFirst(),c)
	end
end
