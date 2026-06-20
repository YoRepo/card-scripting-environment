--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 断罪之咒眼  (ID: 79383919)
-- Type: Trap / Flip
-- ATK 0 | DEF 0
-- Setcode: 297
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：自己场上有「咒眼」怪兽存在，魔法·陷阱卡发动时才能发动。那个发动无效并破坏。自己的魔法与陷阱区域有「太阴之咒眼」存在的场合，这张卡的发动和效果不会被无效化。
--[[ __CARD_HEADER_END__ ]]

--断罪の呪眼
function c79383919.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCountLimit(1,79383919+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c79383919.condition)
	e1:SetTarget(c79383919.target)
	e1:SetOperation(c79383919.activate)
	c:RegisterEffect(e1)
end
function c79383919.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x129)
end
function c79383919.condition(e,tp,eg,ep,ev,re,r,rp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev)
		and Duel.IsExistingMatchingCard(c79383919.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c79383919.filter(c)
	return c:IsFaceup() and c:IsCode(44133040)
end
function c79383919.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if e:IsHasType(EFFECT_TYPE_ACTIVATE)
		and Duel.IsExistingMatchingCard(c79383919.filter,tp,LOCATION_SZONE,0,1,nil) then
		e:SetProperty(EFFECT_FLAG_CANNOT_INACTIVATE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CAN_FORBIDDEN)
	else
		e:SetProperty(0)
	end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c79383919.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
