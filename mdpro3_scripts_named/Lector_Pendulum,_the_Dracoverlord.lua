--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 龙魔王 霸道矢·灵摆  (ID: 7127502)
-- Type: Monster / Effect / Pendulum
-- Attribute: DARK
-- Race: Dragon
-- Level 4
-- Pendulum Scales: L5 / R5
-- ATK 1950 | DEF 0
-- Setcode: 15859930
--
-- Effect Text:
-- ←5 【灵摆】 5→
-- ①：只要这张卡在灵摆区域存在，对方场上的表侧表示的灵摆怪兽的效果无效化。
-- 【怪兽效果】
-- ①：这张卡和灵摆怪兽进行战斗的伤害步骤开始时发动。那只怪兽和这张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--竜魔王レクターP
function c7127502.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--disable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetRange(LOCATION_PZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetTarget(c7127502.distg)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BATTLE_START)
	e2:SetTarget(c7127502.destg)
	e2:SetOperation(c7127502.desop)
	c:RegisterEffect(e2)
end
function c7127502.distg(e,c)
	return c:IsType(TYPE_PENDULUM)
end
function c7127502.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tc=c:GetBattleTarget()
	if chk==0 then return tc and tc:IsFaceup() and tc:IsType(TYPE_PENDULUM) end
	local g=Group.FromCards(c,tc)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,2,0,0)
end
function c7127502.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=c:GetBattleTarget()
	if c:IsRelateToBattle() and tc:IsRelateToBattle() then
		local g=Group.FromCards(c,tc)
		Duel.Destroy(g,REASON_EFFECT)
	end
end
