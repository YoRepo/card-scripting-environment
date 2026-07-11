--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Amphibious Bugroth MK-11  (ID: 4754691)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Machine
-- Level: 5
-- ATK 1850 | DEF 1500
-- Scope: OCG / TCG
--
-- Effect Text:
-- While "Umi" is not on the field, this card gains 700 ATK, also it cannot attack directly.
-- While "Umi" is on the field: You can target 1 face-up non-WATER monster on the field; destroy it.
-- You can only use this effect of "Amphibious Bugroth MK-11" once per turn.
--[[ __CARD_HEADER_END__ ]]

--水陸両用バグロス Mk－11
function c4754691.initial_effect(c)
	aux.AddCodeList(c,22702055)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c4754691.condition)
	e1:SetValue(700)
	c:RegisterEffect(e1)
	--cannot direct attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	e2:SetCondition(c4754691.condition)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(4754691,0))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,4754691)
	e3:SetCondition(c4754691.descon)
	e3:SetTarget(c4754691.destg)
	e3:SetOperation(c4754691.desop)
	c:RegisterEffect(e3)
end
function c4754691.condition(e)
	return not Duel.IsEnvironment(22702055)
end
function c4754691.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsEnvironment(22702055)
end
function c4754691.desfilter(c)
	return c:IsFaceup() and c:IsNonAttribute(ATTRIBUTE_WATER)
end
function c4754691.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c4754691.desfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c4754691.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c4754691.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c4754691.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
