--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 透破拔  (ID: 65703851)
-- Type: Trap / Flip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：手卡·墓地有怪兽的效果发动时才能发动。那个发动无效并除外。
--[[ __CARD_HEADER_END__ ]]

--透破抜き
function c65703851.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c65703851.condition)
	e1:SetTarget(aux.nbtg)
	e1:SetOperation(c65703851.activate)
	c:RegisterEffect(e1)
end
function c65703851.condition(e,tp,eg,ep,ev,re,r,rp)
	local loc=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	return (loc==LOCATION_HAND or loc==LOCATION_GRAVE) and re:IsActiveType(TYPE_MONSTER) and Duel.IsChainNegatable(ev)
end
function c65703851.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Remove(eg,POS_FACEUP,REASON_EFFECT)
	end
end
