--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 龙剑士 卓辉星·灵摆  (ID: 75195825)
-- Type: Monster / Normal / Pendulum
-- Attribute: LIGHT
-- Race: Dragon
-- Level 4
-- Pendulum Scales: L3 / R3
-- ATK 1950 | DEF 0
-- Setcode: 15859911
--
-- Effect Text:
-- ←3 【灵摆】 3→
-- ①：只在这张卡在灵摆区域存在才有1次，以自己或者对方的灵摆区域1张卡为对象才能发动。那张卡破坏。
-- 【怪兽描述】
-- 得到志同道合之士们的力量后「龙剑士 光辉星·灵摆」成长的模样。他是被施过不明神秘诅咒后显现出类似龙魔族的龙之力，但在此之前的记忆全部丢失了，真相因此不明。他相信“龙化秘法”就是解开那诅咒和记忆的关键，
-- 今天仍旧继续着前去讨伐邪恶魔王的旅程。
--[[ __CARD_HEADER_END__ ]]

--竜剣士マスターP
function c75195825.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(75195825,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE)
	e2:SetProperty(EFFECT_FLAG_NO_TURN_RESET+EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetTarget(c75195825.sctg)
	e2:SetOperation(c75195825.scop)
	c:RegisterEffect(e2)
end
function c75195825.sctg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_PZONE) end
	if chk==0 then return Duel.IsExistingTarget(nil,tp,LOCATION_PZONE,LOCATION_PZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,nil,tp,LOCATION_PZONE,LOCATION_PZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c75195825.scop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
