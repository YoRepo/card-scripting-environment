--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 吸入暗阴的魔镜  (ID: 99735427)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 只要这张卡在场上存在，场上·墓地发动的暗属性怪兽的效果无效化。
--[[ __CARD_HEADER_END__ ]]

--暗闇を吸い込むマジック・ミラー
function c99735427.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--disable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_CHAIN_SOLVING)
	e2:SetOperation(c99735427.disop)
	c:RegisterEffect(e2)
end
function c99735427.disop(e,tp,eg,ep,ev,re,r,rp)
	local loc=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	if re:IsActiveType(TYPE_MONSTER) and (loc==LOCATION_MZONE or loc==LOCATION_GRAVE)
		and re:GetHandler():IsAttribute(ATTRIBUTE_DARK) then
		Duel.NegateEffect(ev)
	end
end
