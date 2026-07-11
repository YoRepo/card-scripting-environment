--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Thestalos the Firestorm Monarch  (ID: 26205777)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Pyro
-- Level: 6
-- ATK 2400 | DEF 1000
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is Tribute Summoned: Discard 1 random card from your opponent's hand, then, if it was a
-- Monster Card, inflict damage to your opponent equal to its original Level x 100.
--[[ __CARD_HEADER_END__ ]]

--炎帝テスタロス
function c26205777.initial_effect(c)
	--handes
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(26205777,0))
	e1:SetCategory(CATEGORY_HANDES_OPPO+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(c26205777.condition)
	e1:SetTarget(c26205777.target)
	e1:SetOperation(c26205777.operation)
	c:RegisterEffect(e1)
end
function c26205777.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_ADVANCE)
end
function c26205777.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_HANDES_OPPO,nil,0,1-tp,1)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,0)
end
function c26205777.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if g:GetCount()>0 then
		local sg=g:RandomSelect(1-tp,1)
		Duel.SendtoGrave(sg,REASON_EFFECT+REASON_DISCARD)
		local tc=sg:GetFirst()
		if tc:IsType(TYPE_MONSTER) then
			Duel.Damage(1-tp,tc:GetLevel()*100,REASON_EFFECT)
		end
	end
end
