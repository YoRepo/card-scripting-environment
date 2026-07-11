--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Chiron the Mage  (ID: 16956455)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast-Warrior
-- Level: 4
-- ATK 1800 | DEF 1000
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn: You can discard 1 Spell, then target 1 Spell/Trap your opponent controls; destroy
-- that target.
--[[ __CARD_HEADER_END__ ]]

--賢者ケイローン
function c16956455.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(16956455,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c16956455.descost)
	e1:SetTarget(c16956455.destg)
	e1:SetOperation(c16956455.desop)
	c:RegisterEffect(e1)
end
function c16956455.cfilter(c)
	return c:IsType(TYPE_SPELL) and c:IsDiscardable()
end
function c16956455.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c16956455.cfilter,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,c16956455.cfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c16956455.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c16956455.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and c16956455.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c16956455.filter,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c16956455.filter,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c16956455.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
