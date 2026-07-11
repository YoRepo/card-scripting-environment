--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Morgan, the Enchantress of Avalon  (ID: 24027078)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level: 3
-- ATK 1300 | DEF 1600
-- Scope: OCG / TCG
--
-- Effect Text:
-- When your opponent activates a card or effect, while you control a "Noble Knight" monster and a
-- "Noble Arms" Equip Spell (Quick Effect): You can send this card from your hand to the GY; destroy 1
-- "Noble Arms" Equip Spell you control, and if you do, negate the activation.
-- You can only use this effect of "Morgan, the Enchantress of Avalon" once per turn.
--[[ __CARD_HEADER_END__ ]]

--アヴァロンの魔女モルガン
function c24027078.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(24027078,0))
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,24027078)
	e1:SetCondition(c24027078.condition)
	e1:SetCost(c24027078.cost)
	e1:SetTarget(c24027078.target)
	e1:SetOperation(c24027078.operation)
	c:RegisterEffect(e1)
end
function c24027078.filter1(c)
	return c:IsFaceup() and c:IsSetCard(0x107a)
end
function c24027078.filter2(c)
	return c:IsFaceup() and c:IsSetCard(0x207a) and c:IsType(TYPE_EQUIP)
end
function c24027078.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and Duel.IsChainNegatable(ev)
		and Duel.IsExistingMatchingCard(c24027078.filter1,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(c24027078.filter2,tp,LOCATION_ONFIELD,0,1,nil)
end
function c24027078.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c24027078.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c24027078.filter2,tp,LOCATION_ONFIELD,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c24027078.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,c24027078.filter2,tp,LOCATION_ONFIELD,0,1,1,nil)
	if #g>0 and Duel.Destroy(g,REASON_EFFECT)~=0 then
		Duel.NegateActivation(ev)
	end
end
