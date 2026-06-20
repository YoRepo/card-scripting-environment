--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 龙魔王 魔道矢·灵摆  (ID: 69512157)
-- Type: Monster / Normal / Pendulum
-- Attribute: DARK
-- Race: Dragon
-- Level 4
-- Pendulum Scales: L3 / R3
-- ATK 1850 | DEF 0
-- Setcode: 15859930
--
-- Effect Text:
-- ←3 【灵摆】 3→
-- ①：只要这张卡在灵摆区域存在，对方的灵摆区域的卡的效果无效化。
-- 【怪兽描述】
-- 统率着突然出现在这个世上并转眼就彻底蹂躏了世界的大群龙魔族的魔王。据说他是以“龙化秘法”转变了万物成为邪恶的龙形，不过那种力量的真面目还不怎么清楚。强大魔力的源泉甚至有传闻说是不属于这个次元的。
--[[ __CARD_HEADER_END__ ]]

--竜魔王ベクターP
function c69512157.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--disable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DISABLE)
	e2:SetRange(LOCATION_PZONE)
	e2:SetTargetRange(0,LOCATION_PZONE)
	c:RegisterEffect(e2)
	--disable effect
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_CHAIN_SOLVING)
	e3:SetRange(LOCATION_PZONE)
	e3:SetOperation(c69512157.disop)
	c:RegisterEffect(e3)
end
function c69512157.disop(e,tp,eg,ep,ev,re,r,rp)
	local p,loc=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_CONTROLER,CHAININFO_TRIGGERING_LOCATION)
	if re:GetActiveType()==TYPE_PENDULUM+TYPE_SPELL and p~=tp and bit.band(loc,LOCATION_PZONE)~=0 then
		Duel.NegateEffect(ev)
	end
end
