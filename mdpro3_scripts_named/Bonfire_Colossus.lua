--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Bonfire Colossus  (ID: 59834564)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Beast-Warrior
-- Level: 8
-- ATK 2600 | DEF 2200
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you control a FIRE monster, you can Special Summon this card (from your hand).
-- If this card is Special Summoned: Target 2 FIRE monsters you control; destroy those targets.
--[[ __CARD_HEADER_END__ ]]

--嚇灼の魔神
function c59834564.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c59834564.spcon)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(59834564,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetTarget(c59834564.destg)
	e2:SetOperation(c59834564.desop)
	c:RegisterEffect(e2)
end
function c59834564.filter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_FIRE)
end
function c59834564.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and	Duel.IsExistingMatchingCard(c59834564.filter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
function c59834564.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c59834564.filter(chkc) end
	if chk==0 then return true end
	if Duel.IsExistingTarget(c59834564.filter,tp,LOCATION_MZONE,0,2,nil) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local g=Duel.SelectTarget(tp,c59834564.filter,tp,LOCATION_MZONE,0,2,2,nil)
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,2,0,0)
	end
end
function c59834564.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not g then return end
	local dg=g:Filter(Card.IsRelateToEffect,nil,e)
	Duel.Destroy(dg,REASON_EFFECT)
end
